namespace Importer;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Reflection,
  System.Runtime.InteropServices,
  System.Text,
  System.IO,
  Mono.Cecil,
  Mono.Cecil.Cil,
  RemObjects.CodeGen4;

type
  Importer = public class(IAssemblyResolver)
  private
    method LoadAsm(el: String): ModuleDefinition;
    method IsListObjectRef(aType: TypeReference; out aArray: Boolean): Boolean;
    method WrapListObject(aVal: CGExpression; aType: CGTypeReference; aArray: Boolean): CGExpression;
    method WrapObject(aVal: CGExpression; aType: CGTypeReference): CGExpression;
    method SigTypeToString(aType: TypeReference): String;

    fSettings: ImporterSettings;
    fCodeGenerator: CGCodeGenerator;
    fLibraries: List<ModuleDefinition> := new List<ModuleDefinition>;
    fTypes: Dictionary<TypeDefinition, String> := new Dictionary<TypeDefinition, String>;
    fImportNameMapping: Dictionary<String, String> := new Dictionary<String,String>;
    fReservedCocoaMemberNames := new List<String>();
    fEnumTypes: HashSet<TypeDefinition> := new HashSet<TypeDefinition>;
    fValueTypes: HashSet<TypeDefinition> := new HashSet<TypeDefinition>;
    fPaths: HashSet<String> := new HashSet<String>;
    fLoaded: Dictionary<String, ModuleDefinition> := new Dictionary<String,ModuleDefinition>;
    fUnit: CGCodeUnit;
    fResolver:  DefaultAssemblyResolver := new  DefaultAssemblyResolver();
  protected
    method Resolve(fullName: String): AssemblyDefinition;
    method Resolve(fullName: String; parameters: ReaderParameters): AssemblyDefinition;
    method Resolve(name: AssemblyNameReference): AssemblyDefinition;
    method Resolve(name: AssemblyNameReference; parameters: ReaderParameters): AssemblyDefinition;
    method GetMethodSignature(aSig: MethodDefinition): String;
    method IsObjectRef(aType: TypeReference): Boolean;
  public
    constructor (aSettings: ImporterSettings; aCodeGenerator: CGCodeGenerator);
    method GetMonoType(aType: TypeReference): CGTypeReference;
    method GetMarzipanType(aType: TypeReference): CGTypeReference;
    event Log: Action<String> raise;
    property Output: String;
    property AllowOverloadByName: Boolean := true;

    method Run;
  end;

implementation

constructor Importer(aSettings: ImporterSettings; aCodeGenerator: CGCodeGenerator);
begin
  fSettings := aSettings;
  fCodeGenerator := aCodeGenerator;
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

  fReservedCocoaMemberNames.Add("description");
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
    if lLib.Count = 0 then begin
      writeLn('Warning: Type "'+el.Name+'" not found.');
      continue;
    end;

    var lNewName := if not String.IsNullOrEmpty(el.TargetName) then el.TargetName else fSettings.Prefix+ lLib[0].Name;
    if lLib.Count = 0 then
      raise new Exception('Type "'+el.Name+'" was not found')
    else if (not lLib[0].IsValueType) then
      fTypes.Add(lLib[0], lNewName);
    Log('Adding type '+lNewName+' from '+lLib[0].FullName);
    if (not lLib[0].IsValueType) and (not fImportNameMapping.ContainsKey(lLib[0].FullName)) then
      fImportNameMapping.Add(lLib[0].FullName, lNewName);
  end;
  fUnit := new CGCodeUnit();
  fUnit.HeaderComment := new CGCommentStatement('Marzipan import of '#13#10 + String.Join(#13#10, fLibraries.Select(a->'  '+a.Assembly.Name.ToString).ToArray));
  var lImportsList := new List<CGImport>();
  lImportsList.Add(new CGImport('Foundation'));
  lImportsList.Add(new CGImport('RemObjects.Marzipan'));
  lImportsList.Add(new CGImport('mono.metadata'));
  lImportsList.Add(new CGImport('mono.utils'));
  lImportsList.Add(new CGImport('mono.jit'));
  fUnit.Imports := lImportsList;

  fUnit.Namespace := new CGNamespaceReference(if String.IsNullOrEmpty(fSettings.Namespace) then Path.GetFileNameWithoutExtension(fSettings.OutputFilename) else fSettings.Namespace);
  fUnit.FileName := Path.GetFileNameWithoutExtension(fSettings.OutputFilename);

  var lVars := new List<CGMemberDefinition>;
  var lMethods := new List<CGMemberDefinition>;

  var lNames: HashSet<String> := new HashSet<String>;
  var lSignatures: HashSet<String> := new HashSet<String>;
  var lMethodMap: Dictionary<MethodDefinition, CGMethodDefinition> := new Dictionary<MethodDefinition,CGMethodDefinition>;
  for each el in fTypes.OrderBy(t -> t.Key.FullName) do begin
    Log('Generating type '+el.Key.FullName);
    lMethodMap.Clear;

    var lFTypePropertyName := 'fType_'+el.Key.FullName.Replace(".", "_");

    var lType := new CGClassTypeDefinition(coalesce(el.Value, el.Key.Name));
    lType.Visibility := CGTypeVisibilityKind.Public;

    lType.Comment := new CGCommentStatement('Import of '+el.Key.FullName+' from '+el.Key.Scope.Name);
    var lpt: String;
    if (el.Key.BaseType = nil) or not fImportNameMapping.TryGetValue(el.Key.BaseType.FullName, out lpt) then
      lpt := 'MZObject';
    lType.Ancestors.Add(new CGNamedTypeReference(lpt));

    fUnit.Types.Add(lType);
    lNames.Clear;
    lSignatures.Clear;
    lMethodMap.Clear;
    for each meth in el.Key.Methods.OrderBy(m -> GetMethodSignature(m)) index n do begin
      if (meth.GenericParameters.Count > 0) or (meth.IsSpecialName and meth.Name.StartsWith('op_')) or (meth.IsConstructor and meth.IsStatic) then continue;
      if (meth.ReturnType.IsGenericInstance and meth.ReturnType.IsValueType) then continue;
      if meth.Parameters.Any(a->a.ParameterType.IsGenericInstance and a.ParameterType.IsValueType) then continue;
      if not meth.IsPublic then continue;

      var lMonoSig := new CGBlockTypeDefinition('');
      lMonoSig.IsPlainFunctionPointer := true;

      if (meth.ReturnType.FullName <> 'System.Void') then
        lMonoSig.ReturnType := GetMonoType(meth.ReturnType);

      if meth.HasThis then begin
        var lCGParameterDefinition: CGParameterDefinition := new CGParameterDefinition('__instance', new CGPointerTypeReference(new CGNamedTypeReference('MonoObject')));
        lMonoSig.Parameters.Add(lCGParameterDefinition);
      end;

      var lCGFieldDefinition := new CGFieldDefinition('f_'+n+'_'+meth.Name.Replace('.', '_'), new CGInlineBlockTypeReference(lMonoSig));
      lCGFieldDefinition.Static := true;
      lCGFieldDefinition.Visibility := CGMemberVisibilityKind.Private;

      var lSignature := meth.Name;
      for each elpar in meth.Parameters do begin
        var lParamType: CGTypeReference;
        if elpar.ParameterType.IsByReference then
          lParamType := new CGPointerTypeReference( GetMonoType(elpar.ParameterType.GetElementType))
        else
          lParamType := GetMonoType(elpar.ParameterType);

        lMonoSig.Parameters.Add(new CGParameterDefinition('_' + elpar.Name, lParamType));
        lSignature := lSignature+"+"+lParamType.ToString;
      end;

      lMonoSig.Parameters.Add(new CGParameterDefinition('exception', new CGPointerTypeReference(new CGPointerTypeReference(new CGNamedTypeReference('MonoException')))));

      lVars.Add(lCGFieldDefinition);

      var lMeth := new CGMethodDefinition(if fReservedCocoaMemberNames.Contains(meth.Name.ToLowerInvariant()) then meth.Name+"_" else meth.Name);
      lMeth.Visibility := CGMemberVisibilityKind.Public;
      lMethodMap[meth] := lMeth;
      lMeth.ReturnType := GetMarzipanType(meth.ReturnType);
      if meth.IsConstructor then begin
        lMeth.Name := 'init';
        lMeth.ReturnType := new CGPredefinedTypeReference(CGPredefinedTypeKind.Dynamic);
      end;

      if lSignatures.Contains(lSignature) or (lNames.Contains(lMeth.Name) and (not AllowOverloadByName or (lMeth.Name = "init"))) then begin
        writeLn(lSignature);
        for i: Integer := 2 to Int32.MaxValue -1 do begin
          if not lNames.Contains(lMeth.Name+i) then begin
            lMeth.Name := lMeth.Name+i;
            break;
          end;
        end;
      end;

      lNames.Add(lMeth.Name);
      lSignatures.Add(lSignature);
      lMethods.Add(lMeth);
      lMeth.Static := meth.IsStatic;

      var lCGBeginEndBlockStatement := new CGBeginEndBlockStatement();
      lCGBeginEndBlockStatement.Statements := new List<CGStatement>();

      //Create CGIfThenElseStatement
      var lCondition := new CGUnaryOperatorExpression(new CGAssignedExpression(new CGNamedIdentifierExpression(lCGFieldDefinition.Name)), CGUnaryOperatorKind.Not);
      //Source
      var lValue := new CGMethodCallExpression(nil, 'getMethodThunk', [new CGCallParameter(new CGStringLiteralExpression(GetMethodSignature(meth)))]);
      lValue.CallSite := new CGNamedIdentifierExpression(lFTypePropertyName);

      //Dest
      var lCGUnaryOperatorExpression := new CGUnaryOperatorExpression(new CGNamedIdentifierExpression(lCGFieldDefinition.Name), CGUnaryOperatorKind.AddressOf);
      var lUnaryValue := new CGTypeCastExpression(lCGUnaryOperatorExpression, new CGPointerTypeReference(new CGPointerTypeReference(new CGPredefinedTypeReference(CGPredefinedTypeKind.Void))));

      var lIfStatement : CGStatement := new CGAssignmentStatement(new CGPointerDereferenceExpression(lUnaryValue), lValue);

      var lElseStatement: CGStatement := nil;
      var lCGIfThenElseStatement := new CGIfThenElseStatement(lCondition, lIfStatement, lElseStatement);

      lCGBeginEndBlockStatement.Statements.Add(lCGIfThenElseStatement);

       var lCGVariableDeclarationStatement := new CGVariableDeclarationStatement('ex', new CGPointerTypeReference(new CGNamedTypeReference('MonoException')));
       lCGVariableDeclarationStatement.Value := new CGNilExpression();
       lCGBeginEndBlockStatement.Statements.Add(lCGVariableDeclarationStatement);

       var lHasResult := meth.ReturnType.FullName <> 'System.Void';

       if lHasResult then
        lCGBeginEndBlockStatement.Statements.Add(new CGVariableDeclarationStatement('res', GetMonoType(meth.ReturnType)));

      var lCall := new CGMethodCallExpression(nil, lCGFieldDefinition.Name);

      if meth.IsStatic = false then begin
        if meth.IsConstructor then begin
          var lCGMethodCallExpression := new CGMethodCallExpression(new CGInheritedExpression(), 'init');

          lCGBeginEndBlockStatement.Statements.Insert(0, new CGBinaryOperatorExpression(new CGSelfExpression(), lCGMethodCallExpression, CGBinaryOperatorKind.Assign));

          var lMonoObject := new CGPointerTypeReference(new CGNamedTypeReference('MonoObject'));
          var lDefaultValue := new CGMethodCallExpression(new CGNamedIdentifierExpression(lFTypePropertyName), 'instantiate');
          lCGBeginEndBlockStatement.Statements.Add(new CGVariableDeclarationStatement('inst', lMonoObject, lDefaultValue));
        end else
          lCGBeginEndBlockStatement.Statements.Add(new CGVariableDeclarationStatement('inst', new CGPointerTypeReference(new CGNamedTypeReference('MonoObject')), new CGNamedIdentifierExpression('__instance')));
          lCall.Parameters.Add(new CGCallParameter(new CGNamedIdentifierExpression('inst'), ''));
      end;

      //lMeth.Statements.Add(lCGBeginEndBlockStatement);

      var lAfterCall: LinkedList<CGStatement>;
      for i: Integer := 0 to meth.Parameters.Count -1 do begin
        var lParamName := '_'+meth.Parameters[i].Name;
        var lParamType: CGTypeReference;
        var lParamModifier: CGParameterModifierKind;
        var lPTar: TypeReference := meth.Parameters[i].ParameterType;
        var lIsByReference := lPTar.IsByReference;
        if lIsByReference then begin
          lPTar := ByReferenceType(lPTar).ElementType;
          lParamType := GetMarzipanType(lPTar);
          if meth.Parameters[i].IsOut then
            lParamModifier := CGParameterModifierKind.Out
          else
            lParamModifier := CGParameterModifierKind.Var;
        end
        else
          lParamType := GetMarzipanType(lPTar);

        var lPar := new CGParameterDefinition(lParamName, lParamType);
        if lIsByReference then lPar.Modifier := lParamModifier;

        lMeth.Parameters.Add(lPar);

        if lPTar.FullName = 'System.String' then begin
          if lPar.Modifier in [CGParameterModifierKind.Var,CGParameterModifierKind.Out] then begin
            lCGBeginEndBlockStatement.Statements.Add(new CGVariableDeclarationStatement('par'+i, GetMonoType(lPTar),
                                                                                  new CGMethodCallExpression(new CGNamedIdentifierExpression('MZString'), 'MonoStringWithNSString', [new CGCallParameter(new CGNamedIdentifierExpression(lPar.Name))]) ));
            lCall.Parameters.Add(new CGCallParameter(new CGUnaryOperatorExpression(new CGNamedIdentifierExpression('par'+i), CGUnaryOperatorKind.AddressOf)));
            if lAfterCall = nil then begin
              lAfterCall := new LinkedList<CGStatement>;
            end;
            lAfterCall.AddLast(new CGAssignmentStatement(new CGNamedIdentifierExpression(lPar.Name), WrapObject(new CGNamedIdentifierExpression('par'+i), lPar.Type)));
          end
          else begin
            lCall.Parameters.Add(new CGCallParameter(new CGMethodCallExpression(
                                  new CGTypeReferenceExpression(new CGNamedTypeReference('MZString')), 'MonoStringWithNSString',
                                 [new CGCallParameter(new CGNamedIdentifierExpression(lPar.Name))])));
          end;
        end else
        if IsObjectRef(lPTar) then begin
          if lPar.Modifier in [CGParameterModifierKind.Var,CGParameterModifierKind.Out] then begin
            var lTempExpr := new CGIfThenElseExpression(new CGUnaryOperatorExpression(new CGAssignedExpression(new CGNamedIdentifierExpression(lPar.Name)), CGUnaryOperatorKind.Not), new CGNilExpression(), new CGMethodCallExpression(new CGNamedIdentifierExpression(lPar.Name), '__instance'));

            lCGBeginEndBlockStatement.Statements.Add(new CGVariableDeclarationStatement('par'+i, GetMonoType(lPTar), new CGTypeCastExpression(lTempExpr, GetMonoType(lPTar)) ));

            lCall.Parameters.Add(new CGCallParameter(new CGUnaryOperatorExpression(new CGNamedIdentifierExpression('par'+i), CGUnaryOperatorKind.AddressOf)));
            if lAfterCall = nil then begin
              lAfterCall := new LinkedList<CGStatement>;
            end;
            var lArr: Boolean;
            if IsListObjectRef(lPTar, out lArr) then
              lAfterCall.AddLast(new CGAssignmentStatement(new CGNamedIdentifierExpression(lPar.Name),
                                                           WrapListObject(new CGNamedIdentifierExpression('par'+i),
                                                                          GetMarzipanType(if lPTar is GenericInstanceType then
                                                                                            GenericInstanceType(lPTar).GenericArguments[0]
                                                                                          else
                                                                                            lPTar.GetElementType), lArr)))
            else
              lAfterCall.AddLast(new CGAssignmentStatement(new CGNamedIdentifierExpression(lPar.Name), WrapObject(new CGNamedIdentifierExpression('par'+i), lPar.Type)));
          end else begin
            lCall.Parameters.Add(new CGCallParameter(new CGTypeCastExpression(new CGIfThenElseExpression(new CGUnaryOperatorExpression(new CGAssignedExpression(new CGNamedIdentifierExpression(lPar.Name)), CGUnaryOperatorKind.Not), new CGNilExpression(), new CGMethodCallExpression(new CGNamedIdentifierExpression(lPar.Name), '__instance')) , GetMonoType(lPTar))));
          end;
        end else begin
          if lPar.Modifier in [CGParameterModifierKind.Var,CGParameterModifierKind.Out] then
            lCall.Parameters.Add(new CGCallParameter(new CGUnaryOperatorExpression(new CGNamedIdentifierExpression(lPar.Name), CGUnaryOperatorKind.AddressOf)))
          else
            lCall.Parameters.Add(new CGCallParameter(new CGNamedIdentifierExpression(lPar.Name)));
        end;
      end;

      lCall.Parameters.Add(new CGCallParameter(new CGUnaryOperatorExpression(new CGNamedIdentifierExpression('ex'), CGUnaryOperatorKind.AddressOf)));

      if lHasResult then begin
        var lCGAssignmentStatement := new CGAssignmentStatement(new CGNamedIdentifierExpression('res'), lCall);
        lCGBeginEndBlockStatement.Statements.Add(lCGAssignmentStatement);
      end
      else begin
         lCGBeginEndBlockStatement.Statements.Add(lCall);
      end;

      for each elz in lAfterCall do
        lCGBeginEndBlockStatement.Statements.Add(elz);

       var lCGIfElseStat := new CGIfThenElseStatement(new CGAssignedExpression( new CGNamedIdentifierExpression('ex')),
                              new CGMethodCallExpression(nil, 'raiseException', [new CGCallParameter(new CGNamedIdentifierExpression('ex'))] )
                              );

      lCGBeginEndBlockStatement.Statements.Add(lCGIfElseStat);

      if meth.IsConstructor then begin
        lCGBeginEndBlockStatement.Statements.Add(new CGAssignmentStatement(new CGNamedIdentifierExpression('__instance'), new CGNamedIdentifierExpression('inst')));
        lCGBeginEndBlockStatement.Statements.Add(new CGReturnStatement(new CGSelfExpression()));
      end;
      var lArr: Boolean;
      if lHasResult then
        if IsListObjectRef(meth.ReturnType, out lArr) then
         lCGBeginEndBlockStatement.Statements.Add(new CGReturnStatement(WrapListObject(new CGNamedIdentifierExpression('res'), GetMarzipanType(
            if meth.ReturnType is GenericInstanceType then
            GenericInstanceType(meth.ReturnType).GenericArguments[0] else
              meth.ReturnType.GetElementType), lArr)))
        else if IsObjectRef(meth.ReturnType) then
          lCGBeginEndBlockStatement.Statements.Add(new CGReturnStatement(WrapObject(new CGNamedIdentifierExpression('res'), GetMarzipanType(meth.ReturnType))))
        else
          lCGBeginEndBlockStatement.Statements.Add(new CGReturnStatement(new CGNamedIdentifierExpression('res')));

      lMeth.Statements.Add(lCGBeginEndBlockStatement);
    end;

    var lProperties := new List<CGPropertyDefinition>;

    for each prop in el.Key.Properties.OrderBy(p -> p.Name) do begin
      if not (((prop.GetMethod <> nil) and (prop.GetMethod.IsPublic)) or ((prop.SetMethod <> nil) and (prop.SetMethod.IsPublic)))then continue;
      var lName := if fReservedCocoaMemberNames.Contains(prop.Name.ToLowerInvariant()) then prop.Name+"_" else prop.Name;
      var lProp := new CGPropertyDefinition(lName);
      if coalesce(prop.GetMethod, prop.SetMethod).IsStatic then
        lProp.Static := true;
      lProp.Visibility := CGMemberVisibilityKind.Public;
      for each elz in prop.Parameters do
        lProp.Parameters.Add(new CGParameterDefinition(elz.Name, GetMarzipanType(elz.ParameterType)));

      lProp.Type := GetMarzipanType(prop.PropertyType);
      if prop.GetMethod <> nil then begin
        var lMeth := lMethodMap[prop.GetMethod];
        lMeth.Visibility := CGMemberVisibilityKind.Private;
        lMeth.Name := /*"get"+*/lName;

        lProp.GetExpression := new CGNamedIdentifierExpression(/*"get"+*/lName);
      end;

      if (prop.SetMethod <> nil) and (prop.SetMethod.IsPublic) then begin
        var lMeth := lMethodMap[prop.SetMethod];
        lMeth.Visibility := CGMemberVisibilityKind.Private;
        // move to top
        lMeth.Name := 'set'+prop.Name;

        lProp.SetExpression := new CGNamedIdentifierExpression('set'+prop.Name);
      end;
      lProperties.Add(lProp);
    end;


    var lFType := new CGPropertyDefinition(lFTypePropertyName);
    lFType.Static := true;
    lFType.Visibility := CGMemberVisibilityKind.Private;

    lFType.Attributes.Add(new CGAttribute(new CGNamedTypeReference('Lazy')));
    lFType.Type := new CGNamedTypeReference('MZType');

    var lCall := new CGMethodCallExpression(new CGMethodCallExpression(new CGNamedIdentifierExpression('MZMonoRuntime'), 'sharedInstance'), 'getType', [new CGCallParameter(new CGStringLiteralExpression(el.Key.FullName+', '+ModuleDefinition(el.Key.Scope).Assembly.Name.Name))]);

    lFType.Initializer := lCall;

    lType.Members.Add(lFType);

    for each elz in lVars do lType.Members.Add(elz);
    lVars.Clear;

    for each elz in lMethods.Where(a->a.Visibility = CGMemberVisibilityKind.Private) do lType.Members.Add(elz);
    for each elz in lMethods.Where(a->a.Visibility = CGMemberVisibilityKind.Public) do lType.Members.Add(elz);
    for each elz in lProperties do lType.Members.Add(elz);
    lMethods.Clear;
    var lGetType := new CGMethodDefinition('getType');
    lGetType.Static := true;
    lGetType.Visibility := CGMemberVisibilityKind.Public;
    lGetType.ReturnType := new CGNamedTypeReference('MZType');
    lGetType.Virtuality := CGMemberVirtualityKind.Override;

    var lGetTypeBeginEndStat := new CGBeginEndBlockStatement();
    lGetTypeBeginEndStat.Statements.Add(new CGReturnStatement(new CGNamedIdentifierExpression(lFTypePropertyName)));
    lGetType.Statements.Add(lGetTypeBeginEndStat);

    lType.Members.Add(lGetType);
  end;

  for each el in fEnumTypes index n do begin
    var lTypeDef := new CGEnumTypeDefinition(fImportNameMapping[el.FullName]);
    lTypeDef.BaseType := GetMonoType(el.Fields.Single(a->a.IsStatic = false).FieldType);
    lTypeDef.Comment := new CGCommentStatement('Import of '+el.FullName+' from '+el.Scope.Name);
    lTypeDef.Visibility := CGTypeVisibilityKind.Public;
    for each lConst in el.Fields.Where(a->a.IsLiteral) do begin
      var lCGField := new CGEnumValueDefinition(lConst.Name);
      lCGField.Static := true;
      lCGField.Value := new CGIntegerLiteralExpression(Convert.ToInt64(lConst.Constant));
      lTypeDef.Members.Add(lCGField);
    end;

    fUnit.Types.Insert(n, lTypeDef);

  end;
  var lStart := fEnumTypes.Count;

  for each el in fValueTypes.ToList() index n do begin
    var lTypeDef := new CGStructTypeDefinition(fImportNameMapping[el.FullName]);
    lTypeDef.Comment := new CGCommentStatement('Import of '+el.FullName+' from '+el.Scope.Name);
    lTypeDef.Visibility := CGTypeVisibilityKind.Public;

    for each lConst in el.Fields.Where(a->a.IsStatic = false) do begin
      lTypeDef.Members.Add(
        new CGFieldDefinition(lConst.Name, GetMonoType(lConst.FieldType), Visibility := CGMemberVisibilityKind.Public));
    end;

    if not fUnit.Types.Contains(lTypeDef) then
      fUnit.Types.Insert(n + lStart, lTypeDef);

  end;

  Log('Generating code');

  Output := fCodeGenerator.GenerateUnit(fUnit);
  case fCodeGenerator type of
    CGOxygeneCodeGenerator: Output := '{$HIDE W8}'+Environment.NewLine+Environment.NewLine+Output;
    CGCSharpCodeGenerator: Output := '#pragma hide W8'+Environment.NewLine+Environment.NewLine+Output;
  end;

  var lFilename := Path.ChangeExtension(fSettings.OutputFilename, fCodeGenerator.defaultFileExtension);
  File.WriteAllText(lFilename, Output);
  Log('Wrote '+lFilename);

  // for ObjC, we gotta emit a second file. We probably should refatcor this logic into CG4
  if fCodeGenerator is CGObjectiveCHCodeGenerator then begin
    var lCodeGenerator2 := new CGObjectiveCMCodeGenerator();
    Output := lCodeGenerator2.GenerateUnit(fUnit);

    lFilename := Path.ChangeExtension(fSettings.OutputFilename, lCodeGenerator2.defaultFileExtension);
    File.WriteAllText(lFilename, Output);
    Log('Wrote '+lFilename);
  end;

end;

method Importer.GetMonoType(aType: TypeReference): CGTypeReference;
begin
  if aType.IsPinned then exit GetMonoType(aType.GetElementType);
  if aType.IsPointer  then exit new CGPointerTypeReference(GetMonoType(aType.GetElementType));
  if aType.IsArray then exit new CGPointerTypeReference(new CGNamedTypeReference('MonoArray'));
  //if aType.IsArray then exit new CGPointerTypeReference(new CGNamedTypeReference('MonoArray'));
  case aType.FullName of
    'System.String': exit new CGPointerTypeReference(new CGNamedTypeReference('MonoString'));
    'System.Object': exit new CGPointerTypeReference(new CGNamedTypeReference('MonoObject'));
    'System.Char': exit new CGNamedTypeReference('Char');
    'System.Single': exit new CGNamedTypeReference('Single');
    'System.Double': exit new CGNamedTypeReference('Double');
    'System.Boolean': exit new CGNamedTypeReference('Boolean');
    'System.SByte': exit new CGNamedTypeReference('int8_t');
    'System.Byte': exit new CGNamedTypeReference('uint8_t');
    'System.Int16': exit new CGNamedTypeReference('int16_t');
    'System.UInt16': exit new CGNamedTypeReference('uint16_t');
    'System.Int32': exit new CGNamedTypeReference('int32_t');
    'System.UInt32': exit new CGNamedTypeReference('uint32_t');
    'System.Int64': exit new CGNamedTypeReference('int64_t');
    'System.UInt64': exit new CGNamedTypeReference('uint64_t');
    'System.IntPtr': exit new CGNamedTypeReference('intptr_t');
    'System.UIntPtr': exit new CGNamedTypeReference('uintptr_t');
  end;
  var lType := aType.Resolve;
  if lType.IsEnum then begin
    if not fEnumTypes.Contains(lType) then begin
      fEnumTypes.Add(lType);
      if not fImportNameMapping.ContainsKey(lType.FullName) then
        fImportNameMapping.Add(lType.FullName, lType.Name);
    end;
    exit new CGNamedTypeReference(lType.Name);
  end;
  if lType.IsValueType and not (lType.IsGenericInstance) and (lType.GenericParameters.Count = 0) then begin
    if not fValueTypes.Contains(lType) Then begin
      fValueTypes.Add(lType);
      if not fImportNameMapping.ContainsKey(lType.FullName) then
        fImportNameMapping.Add(lType.FullName, lType.Name);
    end;
    exit new CGNamedTypeReference(lType.Name);
  end;
  exit new CGPointerTypeReference(new CGNamedTypeReference('MonoObject'));
end;

method Importer.GetMarzipanType(aType: TypeReference): CGTypeReference;
begin
  if aType.FullName = 'System.Void' then exit nil;
  if aType.FullName = 'System.String' then exit new CGNamedTypeReference('NSString');
  if aType.IsPinned then exit GetMonoType(aType.GetElementType);
  if aType.IsPointer then exit new CGPointerTypeReference(GetMonoType(aType.GetElementType));
  var b: Boolean;
  if aType.IsGenericInstance and IsListObjectRef(aType, out b) then
    exit new CGNamedTypeReference('MZObjectList');
  if aType.IsArray then begin
    if aType.GetElementType.IsValueType then
      exit new CGNamedTypeReference('MZObject')
    else
      exit new CGNamedTypeReference('MZArray')
  end;
  var lRes: String;
  if self.fImportNameMapping.TryGetValue(aType.FullName, out lRes) then
    exit new CGNamedTypeReference(lRes);
  exit new CGNamedTypeReference('MZObject');
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

method Importer.WrapObject(aVal: CGExpression; aType: CGTypeReference): CGExpression;
begin
  if CGNamedTypeReference(aType):Name = 'NSString' then begin
    exit
    new CGMethodCallExpression(new CGNamedIdentifierExpression('MZString'), 'NSStringWithMonoString', [new CGCallParameter(aVal, "")]);
  end;
  exit
  new CGIfThenElseExpression(new CGUnaryOperatorExpression(new CGAssignedExpression(aVal), CGUnaryOperatorKind.Not),
                            new CGNilExpression(), new CGNewInstanceExpression(aType, [new CGCallParameter(new CGTypeCastExpression(aVal, new CGPointerTypeReference(new CGNamedTypeReference('MonoObject'))))], ConstructorName := 'withMonoInstance')
  );

end;

method Importer.SigTypeToString(aType: TypeReference): String;
begin
  if aType = nil then exit nil;
  case aType.MetadataType of
    MetadataType.Array: exit SigTypeToString(aType.GetElementType)+'[]';
    MetadataType.Boolean: exit 'bool';
    MetadataType.ByReference: exit SigTypeToString(ByReferenceType(aType).ElementType)+'&';
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

method Importer.WrapListObject(aVal: CGExpression; aType: CGTypeReference; aArray: Boolean): CGExpression;
begin
  var lCondition := new CGUnaryOperatorExpression(new CGAssignedExpression(aVal), CGUnaryOperatorKind.Not);
  var lIfExpression := new CGNilExpression();

  var lCGCallParamsList := new List<CGCallParameter>();
  lCGCallParamsList.Add(new CGCallParameter(new CGTypeCastExpression(aVal, new CGPointerTypeReference(new CGNamedTypeReference('MonoObject'))), 'withMonoInstance'));
  lCGCallParamsList.Add(new CGCallParameter(new CGMethodCallExpression(nil, 'typeOf', [new CGCallParameter(new CGTypeReferenceExpression(aType))] ), 'elementType'));

  var lTypeForNewExpr := if aArray then new CGNamedTypeReference('MZArray') else new CGNamedTypeReference('MZObjectList');

  var lElseExpression := new CGNewInstanceExpression(lTypeForNewExpr, lCGCallParamsList, ConstructorName := 'WithMonoInstance');

  result := new CGIfThenElseExpression(lCondition, lIfExpression, lElseExpression);
end;

end.