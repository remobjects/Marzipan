namespace Importer;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Reflection,
  System.Text,
  System.IO,
  Mono.Cecil,
  Mono.Cecil.Cil,
  RemObjects.CodeGenerator;

type
  Importer = public class(IAssemblyResolver)
  private
    method LoadAsm(el: String): ModuleDefinition;
    method IsListObjectRef(aType: TypeReference; out aArray: Boolean): Boolean;
    method WrapListObject(aVal: CGIdentifierExpression; aType: CGTypeRef; aArray: Boolean): CGExpression;
    method WrapObject(aVal: CGIdentifierExpression; aType: CGTypeRef): CGExpression;
    method SigTypeToString(aType: TypeReference): String;
    fSettings: ImporterSettings;
    fLibraries: List<ModuleDefinition> := new List<ModuleDefinition>;
    fTypes: Dictionary<TypeDefinition, String> := new Dictionary<TypeDefinition, String>;
    fImportNameMapping: Dictionary<String, String> := new Dictionary<String,String>;
    fEnumTypes: HashSet<TypeDefinition> := new HashSet<TypeDefinition>;
    fValueTypes: HashSet<TypeDefinition> := new HashSet<TypeDefinition>;
    fPaths: Hashset<String> := new HashSet<String>;
    fLoaded: Dictionary<String, ModuleDefinition> := new Dictionary<String,ModuleDefinition>;
    fFile: CGFile;
    fResolver:  DefaultAssemblyResolver := new  DefaultAssemblyResolver();
  protected
    method Resolve(fullName: String): AssemblyDefinition;
    method Resolve(fullName: String; parameters: ReaderParameters): AssemblyDefinition;
    method Resolve(name: AssemblyNameReference): AssemblyDefinition;
    method Resolve(name: AssemblyNameReference; parameters: ReaderParameters): AssemblyDefinition;
    method GetMethodSignature(aSig: MethodDefinition): String;
    method IsObjectRef(aType: TypeReference): Boolean;
  public
    constructor(aSettings: ImporterSettings);
    method GetMonoType(aType: TypeReference): CGTypeRef;
    method GetMarzipanType(aType: TypeReference): CGTypeRef;
    event Log: Action<String> raise;
    property Output: String;

    method Run;
  end;

implementation

constructor Importer(aSettings: ImporterSettings);
begin
  fSettings := aSettings;
  fImportNameMapping.Add('System.Object', 'MZObject');
  fImportNameMapping.Add('System.String', 'NSString');
  fImportNameMapping.Add('System.SByte', 'int8_t');
  fImportNameMapping.Add('System.Byte', 'uint8_t');
  fImportNameMapping.Add('System.Int16', 'int16_t');
  fImportNameMapping.Add('System.UInt16', 'uint16_t');
  fImportNameMapping.Add('System.Int32', 'int32_t');
  fImportNameMapping.Add('System.UInt32', 'uint32_t');
  fImportNameMapping.Add('System.Int64', 'int64_t');
  fImportNameMapping.Add('System.UInt64', 'uint64_t');
  fImportNameMapping.Add('System.IntPtr', 'intptr_t');
  fImportNameMapping.Add('System.UIntPtr', 'uintptr_t');
  fImportNameMapping.Add('System.Char', 'Char');
  fImportNameMapping.Add('System.Single', 'float');
  fImportNameMapping.Add('System.Double', 'double');
  fImportNameMapping.Add('System.Boolean', 'Boolean');
end;

method Importer.Run;
begin
  Log('Loading libraries');
  for each el in fSettings.Libraries do begin
    LoadAsm(el);
  end;
  Log('Resolving types');
  for each el in fSettings.Types do begin
    var lLib := fLibraries.SelectMany(a -> a.Types.Where(b -> (b.GenericParameters.Count = 0) and (b.FullName = el.Name))).ToArray; // Lets ignore those for a sec.
    var lNewName := if not String.IsNullOrEmpty(el.TargetName) then el.TargetName else fSettings.Prefix+ lLib[0].Name;
    if lLib.Count = 0 then
      raise new Exception('Type "'+el.Name+'" was not found')
    else if (not lLib[0].IsValueType) then
      fTypes.Add(lLib[0], lNewName);
    Log('Adding type '+lNewName+' from '+lLib[0].FullName);
    if (not lLib[0].IsValueType) then
      fImportNameMapping.Add(lLib[0].FullName, lNewName);
  end;
  fFile := new CGFile;
  fFile.Comment := 'Marzipan import of '#13#10+
    String.Join(#13#10, fLibraries.Select(a->'  '+a.Assembly.Name.ToString).ToArray);
  fFile.Uses.Add('Foundation');
  fFile.Uses.Add('RemObjects.Marzipan');
  fFile.Uses.Add('mono.metadata');
  fFile.Uses.Add('mono.utils');
  fFile.Uses.Add('mono.jit');

  fFile.Name := if String.IsNullOrEmpty(fSettings.Namespace) then Path.GetFileNameWithoutExtension(fSettings.OutputFilename) else fSettings.Namespace;
  var lVars := new List<CGMember>;
  var lMethods := new List<CGMember>;
  
  var lNames: HashSet<String> := new HashSet<String>;
  var lMethodMap: Dictionary<MethodDefinition, CGMethod> := new Dictionary<MethodDefinition,CGMethod>;
  for each el in fTypes do begin
    Log('Generating type '+el.Key.FullName);
    lMethodMap.Clear;

    var lType := new CGNamedType();
    lType.Name := coalesce(el.Value, el.Key.Name);
    lType.Comment := 'Import of '+el.Key.FullName+' from '+el.Key.Scope.Name;
    var lTypeDef := new CGTypeDefinition();
    lType.Type := lTypeDef;

    fFile.Types.Add(lType);
    var lpt: String;
    if (el.Key.BaseType = nil) or not fImportNameMapping.TryGetValue(el.Key.BaseType.FullName, out lpt) then
      lpt := 'MZObject';
    lTypeDef.ParentType := lpt;
    lTypeDef.TDKind := CGTypeDefKind.Class;
    lNames.Clear;
    lMethodMap.Clear;
    for each meth in el.Key.Methods index n do begin
      if (meth.GenericParameters.Count > 0) or (meth.IsSpecialName and meth.Name.StartsWith('op_')) or (meth.IsConstructor and meth.IsStatic) then continue; 
      if (meth.ReturnType.IsGenericInstance and meth.ReturnType.IsValueType) then continue;
      if meth.Parameters.Any(a->a.ParameterType.IsGenericInstance and a.ParameterType.IsValueType) then continue;
      if not meth.IsPublic then continue;
      
      var lFType := new CGField;
      lFType.Static := true;
      lFType.Access := CGAccessModifier.Private;
      lFType.Name := 'f_'+n+'_'+meth.Name.Replace('.', '_');
      var lMonoSig := new  CGMethod;
      lMonoSig.MethodKind := CGMethodKind.Method;
      if (meth.ReturnType.FullName <> 'System.Void') then
        lMonoSig.ResultType := GetMonoType(meth.ReturnType);
      //else if meth.IsConstructor then
      //  lMonoSig.ResultType := lType.Name;
      if meth.HasThis then
        lMonoSig.Arguments.Add(new CGMethodArgument(Name := '__instance', &Type := new CGPointerTypeRef(new CGNamedTypeRef('MonoObject'))));
      for each elpar in meth.Parameters do begin
        lMonoSig.Arguments.Add(new CGMethodArgument(Name := '_'+elpar.Name, &Type := if elpar.ParameterType.IsByReference 
        then new CGPointerTypeRef( GetMonoType(elpar.ParameterType.GetElementType)) else GetMonoType(elpar.ParameterType)));
      end;
      lMonoSig.Arguments.Add(new CGMethodArgument(Name := 'exception', &Type := new CGPointerTypeRef(new CGPointerTypeRef(new CGNamedTypeRef('MonoException')))));
      lFType.Type := new CGInlineDelegate(Signature := lMonoSig);
      lVars.Add(lFType);
      var lMeth := new CGMethod;
      lMethodMap[meth] := lMeth;
      lMeth.ResultType := GetMarzipanType(meth.ReturnType);
      if meth.IsConstructor then begin
        lMeth.Name := 'init';
        lMeth.ResultType := new CGPredefinedTypeRef(CGPredefinedType.Dynamic);
      end else
        lMeth.Name := meth.Name;
      if lNames.Contains(lMeth.Name) then
        for i: Integer := 2 to Int32.MaxValue -1 do begin
          if not lNames.Contains(lMeth.Name+i) then begin
            lMeth.Name := lMeth.Name+i;
            break;
          end;
            
        end;
      lNames.Add(lMeth.Name);
      lMethods.Add(lMeth);
      lMeth.Static := meth.IsStatic;

      var lBody := new CGBeginStatement();
      lMeth.Body := lBody;
      lMeth.Body.Elements.Add(
        new CGIfStatement(Condition := new CGBinaryExpression(Left := new CGIdentifierExpression(ID := lFType.Name), Right := new CGNilExpression(), &Operator := CGBinaryOperator.Equals),
          &True := new CGAssignmentStatement(
            Source := 
              new CGCallExpression([new CGArgument(Value := new CGStringExpression(Value := GetMethodSignature(meth)))], 
                &Self := new CGIdentifierExpression(ID := 'getMethodThunk', &Self := new CGIdentifierExpression(ID := 'fType'))),
            Dest := 
              new CGUnaryExpression(&Operator := CGUnaryOperator.Dereference,
                value := new CGCastExpression(&Type := new CGPointerTypeRef(new CGPointerTypeRef(new CGPredefinedTypeRef(CGPredefinedType.Void))), Value := 
                  new CGUnaryExpression(&Operator := CGUnaryOperator.AddressOf,
                  Value := new CGIdentifierExpression(ID := lFType.Name)))))));

       lMeth.Body.Elements.Add(new CGVariableStatement([new CGLocalVariable(Name := 'ex', &Type := new CGPointerTypeRef(new CGNamedTypeRef('MonoException')), Initializer := new CGNilExpression())]));

       var lHasResult := meth.ReturnType.FullName <> 'System.Void';
 
       if lHasResult then 
         lMeth.Body.Elements.Add(new CGVariableStatement([new CGLocalVariable(Name := 'res', &Type := GetMonoType(meth.ReturnType))]));

      var lCall := new CGCallExpression(&Self := new CGIdentifierExpression(ID := lFType.Name));
      
      if meth.IsStatic = false then begin
        if meth.IsConstructor then begin
          lMeth.Body.Elements.Insert(0, new CGAssignmentStatement(Dest := new CGSelfExpression, Source := new CGInheritedExpression(&VAlue := new CGCallExpression(&Self := new CGIdentifierExpression(ID := 'init')))));

          lMeth.Body.Elements.Add(new CGVariableStatement([new CGLocalVariable(Name := 'inst', &Type := new CGPointerTypeRef(new CGNamedTypeRef('MonoObject')), Initializer := new CGCallExpression(&Self := new CGIdentifierExpression(&Self :=new  CGIdentifierExpression(ID := 'fType'), ID := 'instantiate')))]))
        end else
          lMeth.Body.Elements.Add(new CGVariableStatement([new CGLocalVariable(Name := 'inst', &Type := new CGPointerTypeRef(new CGNamedTypeRef('MonoObject')), Initializer := new CGIdentifierExpression(ID := '__instance'))]));
        lCall.Arguments.Add(new CGArgument(Value := new CGIdentifierExpression(ID := 'inst')));
      end;


       
(*            
  result := fLength(__instance, @ex);
  if ex <> nil then raiseException(ex);
*)

      var lAfterCall: LinkedList<CGStatement>;
      for i: Integer := 0 to meth.Parameters.Count -1 do begin
        var lPar := new CGMethodArgument();
        lMeth.Arguments.Add(lPar);
        lPar.Name := '_'+meth.Parameters[i].Name;
        var lPTar: TypeReference := meth.Parameters[i].ParameterType;
        if lPTar.IsByReference then begin
          lPTar:= lPTar.GetElementType;
          lPar.Type := GetMarzipanType(lPTar);
          lPar.Modifier := CGMethodArgumentModifier.Var;
        end else 
          lPar.Type := GetMarzipanType(lPTar);

        if lPTar.FullName = 'System.String' then begin
          if lPar.Modifier = CGMethodArgumentModifier.Var then begin
            lMeth.Body.Elements.Add(new CGVariableStatement([new CGLocalVariable(Name := 'par'+i, &Type := GetMonoType(lPTar), Initializer := 
            new CGCallExpression(
              [new CGArgument(Value := new CGIdentifierExpression(ID := lPar.Name))], 
              &Self := new CGIdentifierExpression(ID := 'MonoStringWithNSString', &Self := new CGTypeExpression(&Type := new CGNamedTypeRef('MZString')))))
            ]));
            lCall.Arguments.Add(new CGArgument(Value := new CGUnaryExpression(&Operator := CGUnaryOperator.AddressOf, Value := new CGIdentifierExpression(ID := 'par'+i))));
            if lAfterCall = nil then begin
              lAfterCall := new LinkedList<CGStatement>;
            end;
            lAfterCall.AddLast(new CGAssignmentStatement(Dest := new CGIdentifierExpression(ID := lPar.Name), Source := WrapObject(new CGIdentifierExpression(ID := 'par'+i), lPar.Type)));
          end else begin
            lCall.Arguments.Add(new CGArgument(Value := 
              new CGCallExpression(
              [new CGArgument(Value := new CGIdentifierExpression(ID := lPar.Name))], 
              &Self := new CGIdentifierExpression(ID := 'MonoStringWithNSString', &Self := new CGTypeExpression(&Type := new CGNamedTypeRef('MZString'))))
              ));
          end; 
        end else 
        if IsObjectRef(lPTar) then begin
          if lPar.Modifier = CGMethodArgumentModifier.Var then begin
            lMeth.Body.Elements.Add(new CGVariableStatement([new CGLocalVariable(Name := 'par'+i, &Type := GetMonoType(lPTar), Initializer := 
            new CGCastExpression(&Type := GetMonoType(lPTar), VAlue :=
            new CGIfExpression(Condition := new CGBinaryExpression(&Left := new CGIdentifierExpression(ID := lPar.Name), Right := new CGNilExpression(), &Operator := CGBinaryOperator.Equals),
                &True := new CGNilExpression(), &False := new CGCallExpression(&Self := new CGIdentifierExpression(ID := '__instance', &Self := new CGIdentifierExpression(ID := lPar.Name))))))]));
            lCall.Arguments.Add(new CGArgument(Value := new CGUnaryExpression(&Operator := CGUnaryOperator.AddressOf, Value := new CGIdentifierExpression(ID := 'par'+i))));
            if lAfterCall = nil then begin
              lAfterCall := new LinkedList<CGStatement>;
            end;
            var lArr: Boolean;
            if IsListObjectRef(lPTar, out lArr) then
              lAfterCall.AddLast(new CGAssignmentStatement(Dest := new CGIdentifierExpression(ID := lPar.Name), Source := WrapListObject(new CGIdentifierExpression(ID := 'par'+i), GetMarzipanType(
              if lpt is GenericInstanceType then
              GenericInstanceType(lPTar).GenericArguments[0] else lPTar.GetElementType), lArr)))
            else 
              lAfterCall.AddLast(new CGAssignmentStatement(Dest := new CGIdentifierExpression(ID := lPar.Name), Source := WrapObject(new CGIdentifierExpression(ID := 'par'+i), lPar.Type)));
          end else begin
            lCall.Arguments.Add(new CGArgument(Value := 
              new CGCastExpression(&Type := GetMonoType(lPTar), VAlue :=new CGIfExpression(Condition := new CGBinaryExpression(&Left := new CGIdentifierExpression(ID := lPar.Name), Right := new CGNilExpression(), &Operator := CGBinaryOperator.Equals),
                &True := new CGNilExpression(), &False := new CGCallExpression(&Self := new CGIdentifierExpression(ID := '__instance', &Self := new CGIdentifierExpression(ID := lPar.Name)))))));
          end;
            //lCall.Arguments.Add(new CGArgument(
        end else begin
          if lPar.Modifier = CGMethodArgumentModifier.Var then
            lCall.Arguments.Add(new CGArgument(Value := new CGUnaryExpression(&Operator := CGUnaryOperator.AddressOf, Value := new CGIdentifierExpression(ID := lPar.Name))))
          else
            lCall.Arguments.Add(new CGArgument(Value := new CGIdentifierExpression(ID := lPar.Name)));
        end;
      end;
      var lAsg := new CGAssignmentStatement(Source := lCall);
      if lHasResult then
        lAsg.Dest := new CGIdentifierExpression(ID := 'res');

      lCall.Arguments.Add(new CGArgument(Value := new  CGUnaryExpression(&Operator := CGUnaryOperator.AddressOf, Value := new CGIdentifierExpression(ID := 'ex'))));
      
      lBody.Elements.Add(lAsg);
      for each elz in lAfterCall do
        lBody.Elements.Add(elz);

      lBody.Elements.Add(
        new CGIfStatement(Condition := new CGBinaryExpression(Left := new CGIdentifierExpression(ID := 'ex'), Right := new CGNilExpression(), &Operator := CGBinaryOperator.NotEquals),
        &True := new CGAssignmentStatement(Source := new CGCallExpression([new CGArgument(Value := new CGIdentifierExpression(ID := 'ex'))], &Self := new CGIdentifierExpression(ID := 'raiseException')))));
      if meth.IsConstructor then begin
        lBody.Elements.Add(new CGAssignmentStatement(Dest := new CGIdentifierExpression(ID := 'Instance'), Source := new CGIdentifierExpression(ID := 'inst')));
        lBody.Elements.Add(new CGExitStatement(Value := new CGSelfExpression));
      end;
      var lArr: Boolean;
      if lHasResult then
        if IsListObjectRef(meth.ReturnType, out lArr) then
          lBody.Elements.Add(new CGExitStatement(Value := WrapListObject(new CGIdentifierExpression(ID := 'res'), GetMarzipanType(
            if meth.ReturnType is GenericInstanceType then
            GenericInstanceType(meth.ReturnType).GenericArguments[0] else 
              meth.ReturnType.GetElementType), lArr)))
        else if IsObjectRef(meth.ReturnType) then
          lBody.Elements.Add(new CGExitStatement(Value := WrapObject(new CGIdentifierExpression(ID := 'res'), GetMarzipanType(meth.ReturnType))))
        else
          lBody.Elements.Add(new CGExitStatement(Value := new CGIdentifierExpression(ID := 'res')));
    end;

    var lProperties := new List<CGProperty>;

    for each prop in el.Key.Properties do begin
      if not (((prop.GetMethod <> nil) and (prop.GetMethod.IsPublic)) or ((prop.SetMethod <> nil) and (prop.SetMethod.IsPublic)))then continue;
      var lProp := new CGProperty();
      if coalesce(prop.GetMethod, prop.SetMethod).IsStatic then
        lProp.Static := true;
      lProp.Access := CGAccessModifier.Public;
      for each elz in prop.Parameters do
        lProp.Args.Add(new CGMethodArgument(Name := elz.Name, &Type := GetMarzipanType(elz.ParameterType)));
      lProp.Name := prop.Name;
      lProp.Type := GetMarzipanType(prop.PropertyType);
      if prop.GetMethod <> nil then begin
        var lMeth := lMethodMap[prop.GetMethod];
        lMeth.Access := CGAccessModifier.Private;
        lMeth.Name := prop.Name;

        lProp.Read := new CGIdentifierExpression(ID := prop.Name);
      end;

      if (prop.SetMethod <> nil) and (prop.SetMethod.IsPublic) then begin
        var lMeth := lMethodMap[prop.SetMethod];
        lMeth.Access := CGAccessModifier.Private;
        // move to top
        lMeth.Name := 'set'+prop.Name;

        lProp.Write := new CGIdentifierExpression(ID := 'set'+prop.Name);
      end;
      lProperties .Add(lProp);
    end;


    var lFType := new CGField;
    lFType.Static := true;
    lFType.Access := CGAccessModifier.Private;
    lFType.Name := 'fType';
    lFType.Type := new CGNamedTypeRef('MZType');
    var lCall := new CGCallExpression(new CGArgument(Value := new CGStringExpression(Value := el.Key.FullName+', '+ModuleDefinition(el.Key.Scope).Assembly.Name.Name)));
    lCall.Self := new CGIdentifierExpression(ID := 'getType',
      &Self := new CGIdentifierExpression(ID := 'sharedInstance', 
      &Self := new CGTypeExpression(&Type := new CGNamedTypeRef('MZMonoRuntime'))));
    lFType.Initializer := lCall;
    lTypeDef.Members.Add(lFType);
    for each elz in lVars do lTypeDef.Members.Add(elz);
    lVars.Clear;
    for each elz in lMethods.Where(a->a.Access = CGAccessModifier.Private) do lTypeDef.Members.Add(elz);
    for each elz in lMethods.Where(a->a.Access = CGAccessModifier.Public) do lTypeDef.Members.Add(elz);
    for each elz in lProperties do lTypeDef.Members.Add(elz);
    lMethods.Clear;
    var lGetType := new CGMethod;
    lGetType.Static := true;
    lGetType.MethodKind := CGMethodKind.Method;
    lGetType.Access := CGAccessModifier.Public;
    lGetType.ResultType := 'MZType';
    lGetType.Name := 'getType';
    lGetType.Virtual := CGVirtualBits.Override;
    lGetType.Body := new CGBeginStatement(new CGExitStatement(Value := new CGIdentifierExpression(ID := 'fType')));

    lTypeDef.Members.Add(lGetType);
  end;

  for each el in fEnumTypes index n do begin
    var lType := new CGNamedType();
    lType.Name := fImportNameMapping[el.FullName];
    lType.Comment := 'Import of '+el.FullName+' from '+el.Scope.Name;
    var lTypeDef := new CGTypeDefinition();
    lType.Type := lTypeDef;
    lTypeDef.TDKind := CGTypeDefKind.Enum;
    lTypeDef.ParentType := GetMonoType(el.Fields.Single(a->a.IsStatic = false).FieldType);
    for each lConst in el.Fields.Where(a->a.IsLiteral) do begin
      lTypeDef.Members.Add(
        new CGField(Constant := true, Name := lConst.Name, Initializer := new CGInt64Expression(Value := Convert.ToInt64(lConst.Constant)), &Type := lType.Name, &Static := true));
    end;

    fFile.Types.Insert(n, lType);
    
  end;
  var lStart := fEnumTypes.Count;

  for each el in fValueTypes index n do begin
    var lType := new CGNamedType();
    lType.Name := fImportNameMapping[el.FullName];
    lType.Comment := 'Import of '+el.FullName+' from '+el.Scope.Name;
    var lTypeDef := new CGTypeDefinition();
    lType.Type := lTypeDef;
    lTypeDef.TDKind := CGTypeDefKind.Record;
    for each lConst in el.Fields.Where(a->a.IsStatic = false) do begin
      lTypeDef.Members.Add(
        new CGField(Name := lConst.Name, &Type := GetMonoType(lConst.FieldType)));
    end;

    fFile.Types.Insert(n + lStart, lType);
    
  end;

  Log('Generating code');
  var lGenerator: CGGenerator;
  case self.fSettings.OutputType of
    OutputType.Nougat: lGenerator := new OxygeneGenerator;
    else
      lGenerator := new CSharpGenerator;
  end;
  lGenerator.Build(fFile);
  Output := lGenerator.Output.ToString;
  File.WriteAllText(fSettings.OutputFilename, Output);
end;

method Importer.GetMonoType(aType: TypeReference): CGTypeRef;
begin
  if aType.IsPinned then exit GetMonoType(aType.GetElementType);
  if aType.IsPointer  then exit new CGPointerTypeRef(GetMonoType(aType.GetElementType));
  if aType.IsArray then exit new CGPointerTypeRef(new CGNamedTypeRef('MonoArray'));
  if aType.IsArray then exit new CGPointerTypeRef(new CGNamedTypeRef('MonoArray'));
  case aType.FullName of
    'System.String': exit new CGPointerTypeRef(new CGNamedTypeRef('MonoString'));
    'System.Object': exit new CGPointerTypeRef(new CGNamedTypeRef('MonoObject'));
    'System.Char': exit new CGNamedTypeRef('Char');
    'System.Single': exit new CGNamedTypeRef('Single');
    'System.Double': exit new CGNamedTypeRef('Double');
    'System.Boolean': exit new CGNamedTypeRef('Boolean');
    'System.SByte': exit new CGNamedTypeRef('int8_t');
    'System.Byte': exit new CGNamedTypeRef('uint8_t');
    'System.Int16': exit new CGNamedTypeRef('int16_t');
    'System.UInt16': exit new CGNamedTypeRef('uint16_t');
    'System.Int32': exit new CGNamedTypeRef('int32_t');
    'System.UInt32': exit new CGNamedTypeRef('uint32_t');
    'System.Int64': exit new CGNamedTypeRef('int64_t');
    'System.UInt64': exit new CGNamedTypeRef('uint64_t');
    'System.IntPtr': exit new CGNamedTypeRef('intptr_t');
    'System.UIntPtr': exit new CGNamedTypeRef('uintptr_t');
  end;
  var lType := aType.Resolve;
  //var lStr: String;
  //if fImportNameMapping.TryGetValue(lType.FullName, out lStr) then exit lStr;
  if lType.IsEnum then begin
    if not fEnumTypes.Contains(lType) then begin
      fEnumTypes.Add(lType);
      fImportNameMapping.Add(lType.FullName, lType.Name);
    end;
    exit lType.Name;
  end;
  if lType.IsValueType and not (lType.IsGenericInstance) and (lType.GenericParameters.Count = 0) then begin
    if not fValueTypes.Contains(lType) Then begin
      fValueTypes.Add(lType);
      fImportNameMapping.Add(lType.FullName, lType.Name);
    end;
    exit lType.Name;
  end;
  exit new CGPointerTypeRef(new CGNamedTypeRef('MonoObject'));
end;

method Importer.GetMarzipanType(aType: TypeReference): CGTypeRef;
begin
  if aType.FullName = 'System.Void' then exit nil;
  if aType.FullName = 'System.String' then exit new CGNamedTypeRef('NSString');
  if aType.IsPinned then exit GetMonoType(aType.GetElementType);
  if aType.IsPointer then exit new CGPointerTypeRef(GetMonoType(aType.GetElementType));
  var b: Boolean;
  if aType.IsGenericInstance and IsListObjectRef(aType, out b) then
    exit new CGNamedTypeRef('MZObjectList');
  if aType.IsArray then begin 
    if aType.GetElementType.IsValueType then 
      exit new CGNamedTypeRef('MZObject')
    else
      exit new CGNamedTypeRef('MZArray')
  end;
  var lRes: String;
  if self.fImportNameMapping.TryGetValue(aType.FullName, out lRes) then
    exit lRes;
  exit new CGNamedTypeRef('MZObject');

end;

method Importer.Resolve(fullName: String): AssemblyDefinition;
begin
  raise new NotImplementedException;
end;

method Importer.Resolve(fullName: String; parameters: ReaderParameters): AssemblyDefinition;
begin
  raise new NotImplementedException;
end;

method Importer.Resolve(name: AssemblyNameReference): AssemblyDefinition;
begin
  var lTmp: ModuleDefinition;
  if fLoaded.TryGetValue(name.ToString, out lTmp) then exit lTmp.Assembly;
  for each el in fPaths do begin
    if File.Exists(Path.Combine(el, name.Name+'.dll')) then
      exit LoadAsm(Path.Combine(el, name.Name+'.dll')).Assembly;
    if File.Exists(Path.Combine(el, name.Name+'.exe')) then
      exit LoadAsm(Path.Combine(el, name.Name+'.exe')).Assembly;
    if File.Exists(Path.Combine(el, name.Name+'.DLL')) then
      exit LoadAsm(Path.Combine(el, name.Name+'.DLL')).Assembly;
    if File.Exists(Path.Combine(el, name.Name+'.EXE')) then
      exit LoadAsm(Path.Combine(el, name.Name+'.EXE')).Assembly;
  end;
  exit fResolver.Resolve(name);
end;

method Importer.Resolve(name: AssemblyNameReference; parameters: ReaderParameters): AssemblyDefinition;
begin
  raise new NotImplementedException;
end;

method Importer.LoadAsm(el: String): ModuleDefinition;
begin
  var rp := new ReaderParameters(ReadingMode.Deferred);
  rp.AssemblyResolver := self;
  Log('  Loading '+el);
  fPaths.Add(Path.GetDirectoryName(el));
  var md := ModuleDefinition.ReadModule(el, rp);
  fLibraries.Add(md);
  if fLoaded.TryGetValue(md.Assembly.Name.ToString, out result) then exit;
  fLoaded.Add(md.Assembly.Name.ToString, md);
  exit md;
end;

method Importer.GetMethodSignature(aSig: MethodDefinition): String;
begin
  exit ':'+aSig.Name+'('+String.Join(',', aSig.Parameters.Select(a->SigTypeToString(a.ParameterType)).ToArray)+')';
end;

method Importer.IsObjectRef(aType: TypeReference): Boolean;
begin
  if aType.IsArray then exit true;
  if aType.IsByReference or aType.IsPointer then exit false;
  exit not aType.IsValueType;
end;

method Importer.WrapObject(aVal: CGIdentifierExpression; aType: CGTypeRef): CGExpression;
begin
  if CGNamedTypeRef(aType):Name = 'NSString' then begin 
    exit 
    new CGCallExpression([new CGArgument(Value := aVal)], &Self :=  
      new CGIdentifierExpression(ID := 'NSStringWithMonoString', &Self := new CGIdentifierExpression(ID := 'MZString')));
  end;
  exit
  new CGIfExpression(Condition := new CGBinaryExpression(&Left := aVal, Right := new CGNilExpression(), &Operator := CGBinaryOperator.Equals),
    &True := new CGNilExpression(), &False := new CGNewExpression([new CGArgument(Prefix := 'withMonoInstance',value := new CGCastExpression(&Type := new CGPointerTypeRef('MonoObject'), Value := aVal))], &Type := aType));
            
end;

method Importer.SigTypeToString(aType: TypeReference): String;
begin
  if aType = nil then exit nil;
  case aType.MetadataType of
    MetadataType.Array: exit SigTypeToString(aType.GetElementType)+'[]';
    MetadataType.Boolean: exit 'bool';
    MetadataType.ByReference: exit SigTypeToString(aType.GetElementType)+'&';
    MetadataType.Byte: exit 'byte';
    MetadataType.Int16: exit 'short';
    MetadataType.Int32: exit 'int';
    MetadataType.Int64: exit 'long';
    MetadataType.SByte: exit 'sbyte';
    MetadataType.UInt16: exit 'ushort';
    MetadataType.UInt32: exit 'uint';
    MetadataType.UInt64: exit 'ulong';
    MetadataType.Char: exit 'char';
    MetadataType.Double: exit 'double';
    MetadataType.IntPtr: exit 'intptr';
    MetadataType.UIntPtr: exit 'uintptr';
    MetadataType.Single: exit 'single';
    MetadataType.Void: exit 'void';
    MetadataType.Pointer: exit SigTypeToString(aType.GetElementType)+'*';
    MetadataType.GenericInstance: exit SigTypeToString(GenericInstanceType(aType).ElementType)+'<'+String.Join(',', GenericInstanceType(aType).GenericArguments.Select(a -> SigTypeToString(a)).ToArray)+'>';
    MetadataType.Object: exit 'object';
    MetadataType.String: exit 'string';
    MetadataType.Class,
    MetadataType.ValueType: exit aType.ToString;
   else
     assert(False);
  end;
end;

method Importer.IsListObjectRef(aType: TypeReference; out aArray: Boolean): Boolean;
begin
  aArray := false;
  if aType.IsArray then begin 
    if not IsObjectRef(aType.GetElementType) then exit false;
    aArray := true;
    exit true;
  end;
  if aType.IsGenericInstance then 
    if (aType.GetElementType.FullName = 'System.Collections.Generic.List`1') and IsObjectRef(GenericInstanceType(aType).GenericArguments[0]) then
    exit true;
  exit false;
end;

method Importer.WrapListObject(aVal: CGIdentifierExpression; aType: CGTypeRef; aArray: Boolean): CGExpression;
begin
  exit
  new CGIfExpression(Condition := new CGBinaryExpression(&Left := aVal, Right := new CGNilExpression(), &Operator := CGBinaryOperator.Equals),
    &True := new CGNilExpression(), 
      &False := new CGNewExpression([new CGArgument(Prefix := 'withMonoInstance',
      value := new CGCastExpression(&Type := new CGPointerTypeRef('MonoObject'), Value := aVal)),
      new CGArgument(Prefix := 'elementType', value := new CGCallExpression([new CGArgument(Value := new CGTypeExpression(&Type := aType))], &self := new CGIdentifierExpression(ID := 'typeOf')))
      ], &Type := if aArray then 'MZArray' else 'MZObjectList'));
end;

end.
