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
    method GetTypeName(aTR: TypeReference): String;
    begin
      if aTR is GenericInstanceType then
        exit aTR.Name.Replace('`', '')+'_'+String.Join('__', GenericInstanceType(aTR).GenericArguments.Select(a -> GetTypeName(a)));
      var lRemap := fSettings.Types.FirstOrDefault(a -> a.Name = aTR.FullName);
      exit coalesce(lRemap:TargetName, aTR.Name);
    end;

    class method FixType(aGI: TypeReference; aType: TypeReference): TypeReference;
    begin
      if aType is GenericParameter then
        exit GenericInstanceType(aGI).GenericArguments[GenericParameter(aType).Position];
      exit aType;
    end;

    method Resolve(aType: TypeReference): TypeReference;
    begin
      if aType is GenericInstanceType then begin
        var lGI := new GenericInstanceType(aType.Resolve);
        for each el in GenericInstanceType(aType) .GenericArguments do
          lGI.GenericArguments.Add(Resolve(el));
        exit lGI;
      end;

      exit aType.Resolve;
    end;

    property MZObjectTypeReference := new CGNamedTypeReference('MZObject'); lazy; readonly;

    method LoadAsm(el: String): ModuleDefinition;
    method IsListObjectRef(aType: TypeReference; out aArray: Boolean): Boolean;
    method WrapListObject(aVal: CGExpression; aType: CGTypeReference; aArray: Boolean): CGExpression;
    method WrapObject(aVal: CGExpression; aType: CGTypeReference): CGExpression;
    method SigTypeToString(aType: TypeReference): String;
    method SafeIdentifier(aName: String): String;
    method EnsureCoreOpaqueType(aType: TypeReference): String;
    method GenerateCoreMethod(aType: TypeDefinition; aMethod: MethodDefinition; aGeneratedMethod: CGMethodDefinition; aMethodField: CGFieldDefinition; aTypePropertyName: String);
    method AddCoreSetArgument(aBlock: CGBeginEndBlockStatement; aFrameName: String; aIndex: Integer; aParameterName: String; aType: TypeReference; aUseDefaultValue: Boolean);
    method CoreResultExpression(aFrameName: String; aType: TypeReference; aPublicType: CGTypeReference): CGExpression;

    fSettings: ImporterSettings;
    fUseCore: Boolean;
    fCodeGenerator: CGCodeGenerator;
    fLibraries: List<ModuleDefinition> := new List<ModuleDefinition>;
    fTypes: Dictionary<TypeDefinition, String> := new Dictionary<TypeDefinition, String>;
    fImportNameMapping: Dictionary<String, String> := new Dictionary<String,String>;
    fCoreOpaqueTypes: Dictionary<String, String> := new Dictionary<String,String>;
    fCoreOpaqueAssemblies: Dictionary<String, String> := new Dictionary<String,String>;
    fReservedCocoaMemberNames := new List<String>();
    fEnumTypes: HashSet<TypeDefinition> := new HashSet<TypeDefinition>;
    fValueTypes: HashSet<TypeReference> := new HashSet<TypeReference>();
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
  fUseCore := aSettings.Runtime = RuntimeBackend.Core;
  fCodeGenerator := aCodeGenerator;
  fImportNameMapping.Add('System.Object', 'MZObject');
  fImportNameMapping.Add('System.String', 'String');
  fImportNameMapping.Add('System.DateTime', 'MZDateTime');
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
  //fImportNameMapping.Add('System.Guid', 'SystemGuid');

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
    else if not lLib[0].IsValueType then begin
      fTypes.Add(lLib[0], lNewName);
      if not fImportNameMapping.ContainsKey(lLib[0].FullName) then begin
        Log('Adding type '+lNewName+' from '+lLib[0].FullName);
        fImportNameMapping.Add(lLib[0].FullName, lNewName);
      end
      else begin
        Log('Skipping type '+lNewName+' from '+lLib[0].FullName+', already covered.');
      end;
    end
    else begin
      // Explicitly requested value types do not get regular wrapper classes,
      // but they still need a public Oxygene type emitted if another imported
      // record references them.  BeginStatementBuilder.__Flags is the painful
      // real-world example: the XML imports BeginFlags, but the old flow skipped
      // it here and then generated a record field whose enum type did not exist.
      if not fImportNameMapping.ContainsKey(lLib[0].FullName) then
        fImportNameMapping.Add(lLib[0].FullName, lNewName);
      if lLib[0].IsEnum then
        fEnumTypes.Add(lLib[0])
      else if lLib[0].FullName <> 'System.Guid' then
        fValueTypes.Add(lLib[0]);
      Log('Adding value type '+lNewName+' from '+lLib[0].FullName);
    end;
  end;
  fUnit := new CGCodeUnit();
  fUnit.HeaderComment := new CGCommentStatement('Marzipan import of '#13#10 + String.Join(#13#10, fLibraries.Select(a->'  '+a.Assembly.Name.ToString).ToArray));
  var lImportsList := new List<CGImport>();
  lImportsList.Add(new CGImport('Foundation'));
  lImportsList.Add(new CGImport('RemObjects.Marzipan'));
  if not fUseCore then begin
    lImportsList.Add(new CGImport('mono.metadata'));
    lImportsList.Add(new CGImport('mono.utils'));
    lImportsList.Add(new CGImport('mono.jit'));
  end;
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
      //if (meth.ReturnType.IsGenericInstance and meth.ReturnType.IsValueType) then continue;
      //if meth.Parameters.Any(a->a.ParameterType.IsGenericInstance and a.ParameterType.IsValueType) then continue;
      if not meth.IsPublic then continue;
      if meth.Name.Contains('.') and not meth.Name.StartsWith('.') then continue;

      var lMonoSig := new CGBlockTypeDefinition('');
      lMonoSig.IsPlainFunctionPointer := true;

      if (meth.ReturnType.FullName <> 'System.Void') then
        lMonoSig.ReturnType := GetMonoType(meth.ReturnType);

      if meth.HasThis then begin
        var lCGParameterDefinition: CGParameterDefinition := new CGParameterDefinition('__instance', new CGPointerTypeReference(new CGNamedTypeReference('MonoObject')));
        lMonoSig.Parameters.Add(lCGParameterDefinition);
      end;

      var lFieldType := if fUseCore then new CGNamedTypeReference('MZMethod') else new CGInlineBlockTypeReference(lMonoSig);
      var lCGFieldDefinition := new CGFieldDefinition('f_'+n+'_'+meth.Name.Replace('.', '_'), lFieldType);
      lCGFieldDefinition.Static := true;
      lCGFieldDefinition.Visibility := CGMemberVisibilityKind.Private;

      var lSignature := meth.Name;
      var lPublicParameterSignature := '';
      for each elpar in meth.Parameters do begin
        elpar.Name := elpar.Name.Replace('.','_').Replace('$', '_').Replace('@', '_');
        var lParamType: CGTypeReference;
        if elpar.ParameterType.IsByReference then
          lParamType := new CGPointerTypeReference( GetMonoType(ByReferenceType(elpar.ParameterType).ElementType))
        else
          lParamType := GetMonoType(elpar.ParameterType);

        lMonoSig.Parameters.Add(new CGParameterDefinition('_' + elpar.Name, lParamType));
        // The Core runtime passes all managed reference types as opaque GCHandle
        // pointers, so GetMonoType intentionally collapses many different CLR
        // types to ^Void.  That representation is correct for invocation, but
        // it is far too coarse for overload de-duplication: AddMessage(String)
        // and AddMessage(Message) would otherwise look identical and the public
        // wrapper names would collide.  Keep using the CLR/Mono-style signature
        // text here, because it is the same shape the bridge resolver consumes.
        lSignature := lSignature+"+"+if fUseCore then SigTypeToString(elpar.ParameterType) else lParamType.ToString;
        lPublicParameterSignature := lPublicParameterSignature+"+"+GetMarzipanType(if elpar.ParameterType.IsByReference then ByReferenceType(elpar.ParameterType).ElementType else elpar.ParameterType).ToString;

      end;

      lMonoSig.Parameters.Add(new CGParameterDefinition('exception', new CGPointerTypeReference(new CGPointerTypeReference(new CGNamedTypeReference('MonoException')))));

      lVars.Add(lCGFieldDefinition);

      var lMeth := new CGMethodDefinition(if fReservedCocoaMemberNames.Contains(meth.Name.ToLowerInvariant()) then meth.Name+"_" else meth.Name);
      lMeth.Visibility := CGMemberVisibilityKind.Public;
      lMethodMap[meth] := lMeth;
      lMeth.ReturnType := GetMarzipanType(meth.ReturnType);
      //if lMeth.ReturnType = MZObjectTypeReference then
        //lMeth.Comment := new CGCommentStatement(meth.ReturnType.FullName);
      if meth.IsConstructor then begin
        lMeth.Name := 'init';
        lMeth.ReturnType := CGPredefinedTypeReference.InstanceType;
      end;

      if lSignatures.Contains(lSignature) or lSignatures.Contains(lMeth.Name+lPublicParameterSignature) or (lNames.Contains(lMeth.Name) and (not AllowOverloadByName or (lMeth.Name = "init"))) then begin
        writeLn(lSignature);
        for i: Integer := 2 to Int32.MaxValue -1 do begin
          if not lNames.Contains(lMeth.Name+i) and not lSignatures.Contains(lMeth.Name+i+lPublicParameterSignature) then begin
            lMeth.Name := lMeth.Name+i;
            break;
          end;
        end;
      end;

      lNames.Add(lMeth.Name);
      lSignatures.Add(lSignature);
      lSignatures.Add(lMeth.Name+lPublicParameterSignature);
      lMethods.Add(lMeth);
      lMeth.Static := meth.IsStatic;

      if fUseCore then begin
        GenerateCoreMethod(el.Key, meth, lMeth, lCGFieldDefinition, lFTypePropertyName);
        continue;
      end;

      var lCGBeginEndBlockStatement := new CGBeginEndBlockStatement();
      lCGBeginEndBlockStatement.Statements := new List<CGStatement>();

      //Create CGIfThenElseStatement
      var lCondition := new CGUnaryOperatorExpression(new CGAssignedExpression(new CGNamedIdentifierExpression(lCGFieldDefinition.Name)), CGUnaryOperatorKind.Not);
      //Source
      var lValue := new CGMethodCallExpression(nil, 'getMethodThunk', [new CGCallParameter(new CGStringLiteralExpression(GetMethodSignature(meth)))]);
      lValue.CallSite := new CGNamedIdentifierExpression(lFTypePropertyName);

      //Dest
      var lCGUnaryOperatorExpression := new CGUnaryOperatorExpression(new CGNamedIdentifierExpression(lCGFieldDefinition.Name), CGUnaryOperatorKind.AddressOf);
      var lUnaryValue := new CGTypeCastExpression(lCGUnaryOperatorExpression, new CGPointerTypeReference(new CGPointerTypeReference(CGPredefinedTypeReference.Void)));

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

        //if (llParamType = MZObjectTypeReference) and lIsByReference then
          //lPar.Comment := new CGCommentStatement(lPTar.FullName);

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
      //if lProp.Type = MZObjectTypeReference then
        //lProp.Comment := new CGCommentStatement(prop.PropertyType.FullName);
      if assigned(prop.GetMethod) and lMethodMap.ContainsKey(prop.GetMethod) then begin
        var lMeth := lMethodMap[prop.GetMethod];
        lMeth.Visibility := CGMemberVisibilityKind.Private;
        lMeth.Name := /*"get"+*/lName;

        lProp.GetExpression := new CGNamedIdentifierExpression(/*"get"+*/lName);
      end;

      if assigned(prop.SetMethod) and (prop.SetMethod.IsPublic) and lMethodMap.ContainsKey(prop.SetMethod) then begin
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

    var lRuntimeName := if fUseCore then 'MZCoreRuntime' else 'MZMonoRuntime';
    var lCall := new CGMethodCallExpression(new CGMethodCallExpression(new CGNamedIdentifierExpression(lRuntimeName), 'sharedInstance'), 'getType', [new CGCallParameter(new CGStringLiteralExpression(el.Key.FullName+', '+ModuleDefinition(el.Key.Scope).Assembly.Name.Name))]);

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

  for each el in fCoreOpaqueTypes.OrderBy(t -> t.Value) do begin
    var lClrName := el.Key;
    var lWrapperName := el.Value;
    var lAssemblyName: String;
    if not fCoreOpaqueAssemblies.TryGetValue(lClrName, out lAssemblyName) then
      lAssemblyName := '';

    var lType := new CGClassTypeDefinition(lWrapperName);
    lType.Visibility := CGTypeVisibilityKind.Public;
    lType.Comment := new CGCommentStatement('Opaque Core import of '+lClrName);
    lType.Ancestors.Add(new CGNamedTypeReference('MZObject'));

    var lFTypePropertyName := SafeIdentifier('fType_'+lClrName);
    var lFType := new CGPropertyDefinition(lFTypePropertyName);
    lFType.Static := true;
    lFType.Visibility := CGMemberVisibilityKind.Private;
    lFType.Attributes.Add(new CGAttribute(new CGNamedTypeReference('Lazy')));
    lFType.Type := new CGNamedTypeReference('MZType');
    lFType.Initializer := new CGMethodCallExpression(new CGMethodCallExpression(new CGNamedIdentifierExpression('MZCoreRuntime'), 'sharedInstance'),
                                                     'getType',
                                                     [new CGCallParameter(new CGStringLiteralExpression(lClrName+', '+lAssemblyName))]);
    lType.Members.Add(lFType);

    var lGetType := new CGMethodDefinition('getType');
    lGetType.Static := true;
    lGetType.Visibility := CGMemberVisibilityKind.Public;
    lGetType.ReturnType := new CGNamedTypeReference('MZType');
    lGetType.Virtuality := CGMemberVirtualityKind.Override;
    var lGetTypeBeginEndStat := new CGBeginEndBlockStatement();
    lGetTypeBeginEndStat.Statements.Add(new CGReturnStatement(new CGNamedIdentifierExpression(lFTypePropertyName)));
    lGetType.Statements.Add(lGetTypeBeginEndStat);
    lType.Members.Add(lGetType);

    fUnit.Types.Add(lType);
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
    if el.FullName = 'System.Guid' then continue;
    lTypeDef.Comment := new CGCommentStatement('Import of '+el.FullName+' from '+el.Scope.Name);
    lTypeDef.Visibility := CGTypeVisibilityKind.Public;

    for each lConst in el.Resolve.Fields.Where(a->a.IsStatic = false) do begin
      lTypeDef.Members.Add(
        new CGFieldDefinition(lConst.Name.Replace('@', '_'), GetMonoType(FixType(el, lConst.FieldType)), Visibility := CGMemberVisibilityKind.Public));
    end;

    if fUseCore then begin
      // Core reflection returns boxed value types as object handles.  The full
      // field-by-field unboxing path belongs in the bridge, but the generated
      // wrappers need a constructor shape today because result wrapping is
      // intentionally API-compatible with object wrappers (`new Foo
      // withNetInstance(...)`).  This no-op constructor keeps those value-type
      // wrappers buildable; specific hot structs can later replace it with real
      // bridge-backed unboxing without changing public signatures again.
      var lCtor := new CGConstructorDefinition('withNetInstance', Visibility := CGMemberVisibilityKind.Public);
      lCtor.Parameters.Add(new CGParameterDefinition('aInstance', new CGPointerTypeReference(CGPredefinedTypeReference.Void)));
      lCtor.Empty := true;
      lTypeDef.Members.Add(lCtor);
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
  if fUseCore then begin
    if aType.IsArray then exit new CGPointerTypeReference(CGPredefinedTypeReference.Void);
    case aType.FullName of
      'System.String',
      'System.Object': exit new CGPointerTypeReference(CGPredefinedTypeReference.Void);
    end;
    if (not aType.IsValueType) and (not aType.Resolve.IsEnum) then
      exit new CGPointerTypeReference(CGPredefinedTypeReference.Void);
  end;
  if aType.IsArray then exit new CGPointerTypeReference(new CGNamedTypeReference('MonoArray'));
  //if aType.IsArray then exit new CGPointerTypeReference(new CGNamedTypeReference('MonoArray'));
  case aType.FullName of
    'System.String': exit new CGPointerTypeReference(new CGNamedTypeReference('MonoString'));
    'System.Object': exit new CGPointerTypeReference(new CGNamedTypeReference('MonoObject'));
    'System.DateTime': exit new CGNamedTypeReference('MZDateTime');
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
  var lType := Resolve(aType);
  if lType.Resolve.IsEnum then begin
    if not fEnumTypes.Contains(lType.Resolve) then begin
      fEnumTypes.Add(lType.Resolve);
      if not fImportNameMapping.ContainsKey(lType.FullName) then
        fImportNameMapping.Add(lType.FullName, lType.Name);
    end;
    exit new CGNamedTypeReference(lType.Name);
  end;
  if lType.IsValueType then begin
    if not fImportNameMapping.ContainsKey(lType.FullName) then begin
      fImportNameMapping.Add(lType.FullName, GetTypeName(lType));
      if not fValueTypes.Contains(lType) Then begin
        fValueTypes.Add(lType);
      end;
    end;
    exit new CGNamedTypeReference(GetTypeName(lType));
  end;
  exit new CGPointerTypeReference(new CGNamedTypeReference('MonoObject'));
end;

method Importer.GetMarzipanType(aType: TypeReference): CGTypeReference;
begin
  if aType.FullName = 'System.Void' then exit nil;
  if aType.FullName = 'System.String' then exit new CGNamedTypeReference('String');
  if aType.FullName = 'System.DateTime' then exit new CGNamedTypeReference('MZDateTime');;
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
  if fUseCore and IsObjectRef(aType) then
    exit new CGNamedTypeReference(EnsureCoreOpaqueType(aType));
  exit MZObjectTypeReference;
end;

method Importer.SafeIdentifier(aName: String): String;
begin
  if String.IsNullOrEmpty(aName) then
    exit 'OpaqueType';

  var lBuilder := new StringBuilder();
  for each ch in aName do begin
    if Char.IsLetterOrDigit(ch) or (ch = '_') then
      lBuilder.Append(ch)
    else
      lBuilder.Append('_');
  end;

  var lResult := lBuilder.ToString();
  while lResult.Contains('__') do
    lResult := lResult.Replace('__', '_');
  lResult := lResult.Trim('_');

  if String.IsNullOrEmpty(lResult) then
    lResult := 'OpaqueType';
  if not (Char.IsLetter(lResult[0]) or (lResult[0] = '_')) then
    lResult := 'Opaque_'+lResult;
  exit lResult;
end;

method Importer.EnsureCoreOpaqueType(aType: TypeReference): String;
begin
  if aType = nil then
    exit 'MZObject';

  var lFullName := aType.FullName;
  var lName: String;
  if fCoreOpaqueTypes.TryGetValue(lFullName, out lName) then
    exit lName;

  // Some CLR reference types show up in public method signatures even though
  // the XML did not ask us to import their full API surface.  Mono historically
  // collapsed these to MZObject, but that erases useful type identity and can
  // make distinct overloads indistinguishable.  For Core we generate a tiny
  // opaque wrapper class: it carries the GCHandle like any other MZObject, but
  // intentionally has no members beyond getType.  That keeps public signatures
  // concrete without recursively importing the world.
  lName := SafeIdentifier(GetTypeName(aType));
  if fImportNameMapping.ContainsValue(lName) then begin
    for i: Integer := 2 to Int32.MaxValue-1 do begin
      if not fImportNameMapping.ContainsValue(lName+i) then begin
        lName := lName+i;
        break;
      end;
    end;
  end;

  fCoreOpaqueTypes.Add(lFullName, lName);
  case aType.Scope type of
    ModuleDefinition: fCoreOpaqueAssemblies[lFullName] := ModuleDefinition(aType.Scope).Assembly.Name.Name;
    AssemblyNameReference: fCoreOpaqueAssemblies[lFullName] := AssemblyNameReference(aType.Scope).Name;
    else fCoreOpaqueAssemblies[lFullName] := aType.Scope:Name;
  end;
  fImportNameMapping.Add(lFullName, lName);
  exit lName;
end;

method Importer.GenerateCoreMethod(aType: TypeDefinition; aMethod: MethodDefinition; aGeneratedMethod: CGMethodDefinition; aMethodField: CGFieldDefinition; aTypePropertyName: String);
begin
  // The Mono backend builds the public method parameter list while assembling
  // the raw thunk call.  The Core backend does not call a typed Mono thunk, so
  // it has to add the same public parameters up front before it starts filling
  // the managed call frame below.
  for i: Integer := 0 to aMethod.Parameters.Count-1 do begin
    var lParameter := aMethod.Parameters[i];
    var lParamTypeReference := lParameter.ParameterType;
    var lIsByReference := lParamTypeReference.IsByReference;
    if lIsByReference then
      lParamTypeReference := ByReferenceType(lParamTypeReference).ElementType;

    var lParameterDefinition := new CGParameterDefinition('_'+lParameter.Name, GetMarzipanType(lParamTypeReference));
    if lIsByReference then begin
      if lParameter.IsOut then
        lParameterDefinition.Modifier := CGParameterModifierKind.Out
      else
        lParameterDefinition.Modifier := CGParameterModifierKind.Var;
    end;
    aGeneratedMethod.Parameters.Add(lParameterDefinition);
  end;

  var lBlock := new CGBeginEndBlockStatement();
  lBlock.Statements := new List<CGStatement>();

  var lMissingMethod := new CGUnaryOperatorExpression(new CGAssignedExpression(new CGNamedIdentifierExpression(aMethodField.Name)), CGUnaryOperatorKind.Not);
  var lGetMethod := new CGMethodCallExpression(new CGNamedIdentifierExpression(aTypePropertyName), 'getMethod', [new CGCallParameter(new CGStringLiteralExpression(GetMethodSignature(aMethod)))]);
  lBlock.Statements.Add(new CGIfThenElseStatement(lMissingMethod, new CGAssignmentStatement(new CGNamedIdentifierExpression(aMethodField.Name), lGetMethod), nil));

  var lTarget: CGExpression := new CGNilExpression();
  if not aMethod.IsStatic then begin
    if aMethod.IsConstructor then begin
      lBlock.Statements.Insert(0, new CGBinaryOperatorExpression(new CGSelfExpression(), new CGMethodCallExpression(new CGInheritedExpression(), 'init'), CGBinaryOperatorKind.Assign));
      lTarget := new CGNilExpression();
    end
    else
      lTarget := new CGNamedIdentifierExpression('__instance');
  end;

  var lFrameParams := new List<CGCallParameter>();
  lFrameParams.Add(new CGCallParameter(new CGNamedIdentifierExpression(aMethodField.Name), 'withMethod'));
  lFrameParams.Add(new CGCallParameter(lTarget, 'target'));
  lFrameParams.Add(new CGCallParameter(new CGIntegerLiteralExpression(aMethod.Parameters.Count), 'argumentCount'));
  lBlock.Statements.Add(new CGVariableDeclarationStatement('frame',
                                                            new CGNamedTypeReference('MZCallFrame'),
                                                            new CGNewInstanceExpression(new CGNamedTypeReference('MZCallFrame'),
                                                                                        lFrameParams,
                                                                                        ConstructorName := 'withMethod')));

  for i: Integer := 0 to aMethod.Parameters.Count-1 do begin
    var lParamType := aMethod.Parameters[i].ParameterType;
    if lParamType.IsByReference then
      lParamType := ByReferenceType(lParamType).ElementType;
    AddCoreSetArgument(lBlock, 'frame', i, '_'+aMethod.Parameters[i].Name, lParamType, aMethod.Parameters[i].IsOut);
  end;

  lBlock.Statements.Add(new CGVariableDeclarationStatement('ex', new CGPointerTypeReference(CGPredefinedTypeReference.Void), new CGMethodCallExpression(new CGNamedIdentifierExpression('frame'), 'invoke')));
  lBlock.Statements.Add(new CGIfThenElseStatement(new CGAssignedExpression(new CGNamedIdentifierExpression('ex')),
                                                  new CGMethodCallExpression(nil, 'raiseException', [new CGCallParameter(new CGNamedIdentifierExpression('ex'))])));

  if aMethod.IsConstructor then begin
    lBlock.Statements.Add(new CGAssignmentStatement(new CGNamedIdentifierExpression('__instance'), new CGMethodCallExpression(new CGNamedIdentifierExpression('frame'), 'getObjectResult')));
    lBlock.Statements.Add(new CGReturnStatement(new CGSelfExpression()));
  end
  else if aMethod.ReturnType.FullName <> 'System.Void' then begin
    var lArr: Boolean;
    var lPublicType := GetMarzipanType(aMethod.ReturnType);
    if IsListObjectRef(aMethod.ReturnType, out lArr) then
      lBlock.Statements.Add(new CGReturnStatement(WrapListObject(new CGMethodCallExpression(new CGNamedIdentifierExpression('frame'), 'getObjectResult'),
                                                        GetMarzipanType(if aMethod.ReturnType is GenericInstanceType then
                                                                          GenericInstanceType(aMethod.ReturnType).GenericArguments[0]
                                                                        else
                                                                          aMethod.ReturnType.GetElementType), lArr)))
    else
      lBlock.Statements.Add(new CGReturnStatement(CoreResultExpression('frame', aMethod.ReturnType, lPublicType)));
  end;

  aGeneratedMethod.Statements.Add(lBlock);
end;

method Importer.AddCoreSetArgument(aBlock: CGBeginEndBlockStatement; aFrameName: String; aIndex: Integer; aParameterName: String; aType: TypeReference; aUseDefaultValue: Boolean);
begin
  var lFrame := new CGNamedIdentifierExpression(aFrameName);
  var lParam := new CGNamedIdentifierExpression(aParameterName);
  var lMethodName := 'setObject';
  var lValue: CGExpression := if aUseDefaultValue then new CGNilExpression() else lParam;

  case aType.FullName of
    'System.String': begin
      lMethodName := 'setString';
      if not aUseDefaultValue then
        lValue := new CGMethodCallExpression(new CGNamedIdentifierExpression('MZString'), 'NetStringWithNSString', [new CGCallParameter(lParam)]);
    end;
    'System.DateTime': begin
      lMethodName := 'setDateTime';
      lValue := if aUseDefaultValue then new CGIntegerLiteralExpression(0) else lParam;
    end;
    'System.Boolean': begin
      lMethodName := 'setBoolean';
      if aUseDefaultValue then
        lValue := new CGBooleanLiteralExpression(false);
    end;
    'System.Char': begin
      lMethodName := 'setInt32';
      lValue := if aUseDefaultValue then new CGIntegerLiteralExpression(0) else new CGTypeCastExpression(lParam, new CGNamedTypeReference('Int32'));
    end;
    'System.SByte',
    'System.Byte',
    'System.Int16',
    'System.UInt16',
    'System.Int32': begin
      lMethodName := 'setInt32';
      if aUseDefaultValue then
        lValue := new CGIntegerLiteralExpression(0);
    end;
    'System.UInt32': begin
      lMethodName := 'setUInt32';
      if aUseDefaultValue then
        lValue := new CGIntegerLiteralExpression(0);
    end;
    'System.Int64': begin
      lMethodName := 'setInt64';
      if aUseDefaultValue then
        lValue := new CGIntegerLiteralExpression(0);
    end;
    'System.UInt64': begin
      lMethodName := 'setUInt64';
      if aUseDefaultValue then
        lValue := new CGIntegerLiteralExpression(0);
    end;
    'System.Single': begin
      lMethodName := 'setSingle';
      if aUseDefaultValue then
        lValue := new CGIntegerLiteralExpression(0);
    end;
    'System.Double': begin
      lMethodName := 'setDouble';
      if aUseDefaultValue then
        lValue := new CGIntegerLiteralExpression(0);
    end;
    'System.IntPtr',
    'System.UIntPtr': begin
      lMethodName := 'setIntPtr';
      if aUseDefaultValue then
        lValue := new CGIntegerLiteralExpression(0)
      else
        lValue := new CGTypeCastExpression(lParam, new CGNamedTypeReference('intptr_t'));
    end;
    else begin
      if IsObjectRef(aType) then begin
        lValue := new CGIfThenElseExpression(new CGUnaryOperatorExpression(new CGAssignedExpression(lParam), CGUnaryOperatorKind.Not),
                                             new CGNilExpression(),
                                             new CGMethodCallExpression(lParam, '__instance'));
        if aUseDefaultValue then
          lValue := new CGNilExpression();
      end
      else if aType.Resolve.IsEnum then begin
        lMethodName := 'setInt32';
        lValue := if aUseDefaultValue then new CGIntegerLiteralExpression(0) else new CGTypeCastExpression(lParam, new CGNamedTypeReference('Int32'));
      end
      else if aType.Resolve.IsValueType then begin
        // Full struct boxing/unboxing will go through a dedicated bridge path.
        // Until that lands, keep the generated wrapper buildable and fail soft
        // for these rare value-type arguments by passing a null object handle.
        lMethodName := 'setObject';
        lValue := new CGNilExpression();
      end;
    end;
  end;

  aBlock.Statements.Add(new CGMethodCallExpression(lFrame, lMethodName, [new CGCallParameter(new CGIntegerLiteralExpression(aIndex)), new CGCallParameter(lValue, 'value')]));
end;

method Importer.CoreResultExpression(aFrameName: String; aType: TypeReference; aPublicType: CGTypeReference): CGExpression;
begin
  var lFrame := new CGNamedIdentifierExpression(aFrameName);
  case aType.FullName of
    'System.String': exit new CGMethodCallExpression(new CGNamedIdentifierExpression('MZString'), 'NSStringWithNetString', [new CGCallParameter(new CGMethodCallExpression(lFrame, 'getStringResult'))]);
    'System.DateTime': exit new CGMethodCallExpression(lFrame, 'getDateTimeResult');
    'System.Boolean': exit new CGMethodCallExpression(lFrame, 'getBooleanResult');
    'System.Char': exit new CGTypeCastExpression(new CGMethodCallExpression(lFrame, 'getInt32Result'), aPublicType);
    'System.SByte',
    'System.Byte',
    'System.Int16',
    'System.UInt16',
    'System.Int32': exit new CGTypeCastExpression(new CGMethodCallExpression(lFrame, 'getInt32Result'), aPublicType);
    'System.UInt32': exit new CGTypeCastExpression(new CGMethodCallExpression(lFrame, 'getUInt32Result'), aPublicType);
    'System.Int64': exit new CGTypeCastExpression(new CGMethodCallExpression(lFrame, 'getInt64Result'), aPublicType);
    'System.UInt64': exit new CGTypeCastExpression(new CGMethodCallExpression(lFrame, 'getUInt64Result'), aPublicType);
    'System.Single': exit new CGMethodCallExpression(lFrame, 'getSingleResult');
    'System.Double': exit new CGMethodCallExpression(lFrame, 'getDoubleResult');
    'System.IntPtr',
    'System.UIntPtr': exit new CGTypeCastExpression(new CGMethodCallExpression(lFrame, 'getIntPtrResult'), aPublicType);
  end;
  if aType.FullName = 'System.Guid' then
    exit new CGNewInstanceExpression(new CGNamedTypeReference('Guid'), [new CGCallParameter(new CGStringLiteralExpression('00000000-0000-0000-0000-000000000000'))]);
  if aType.Resolve.IsEnum then begin
    var lEnumType := aPublicType;
    case aPublicType type of
      CGNamedTypeReference: begin
        lEnumType := new CGNamedTypeReference(CGNamedTypeReference(aPublicType).Name) &namespace(fUnit.Namespace);
      end;
    end;
    exit new CGTypeCastExpression(new CGMethodCallExpression(lFrame, 'getInt32Result'), lEnumType);
  end;
  exit WrapObject(new CGMethodCallExpression(lFrame, 'getObjectResult'), aPublicType);
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
  if CGNamedTypeReference(aType):Name = 'String' then begin
    var lStringMethod := if fUseCore then 'NSStringWithNetString' else 'NSStringWithMonoString';
    exit new CGMethodCallExpression(new CGNamedIdentifierExpression('MZString'), lStringMethod, [new CGCallParameter(aVal, "")]);
  end;
  var lCtorName := if fUseCore then 'withNetInstance' else 'withMonoInstance';
  var lCastType := if fUseCore then new CGPointerTypeReference(CGPredefinedTypeReference.Void) else new CGPointerTypeReference(new CGNamedTypeReference('MonoObject'));
  exit
  new CGIfThenElseExpression(new CGUnaryOperatorExpression(new CGAssignedExpression(aVal), CGUnaryOperatorKind.Not),
                            new CGNilExpression(), new CGNewInstanceExpression(aType, [new CGCallParameter(new CGTypeCastExpression(aVal, lCastType))], ConstructorName := lCtorName)
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
    MetadataType.Var,
    MetadataType.MVar,
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
  var lCastType := if fUseCore then new CGPointerTypeReference(CGPredefinedTypeReference.Void) else new CGPointerTypeReference(new CGNamedTypeReference('MonoObject'));
  lCGCallParamsList.Add(new CGCallParameter(new CGTypeCastExpression(aVal, lCastType), if fUseCore then 'withNetInstance' else 'withMonoInstance'));
  lCGCallParamsList.Add(new CGCallParameter(new CGMethodCallExpression(nil, 'typeOf', [new CGCallParameter(new CGTypeReferenceExpression(aType))] ), 'elementType'));

  var lTypeForNewExpr := if aArray then new CGNamedTypeReference('MZArray') else new CGNamedTypeReference('MZObjectList');

  var lElseExpression := new CGNewInstanceExpression(lTypeForNewExpr, lCGCallParamsList, ConstructorName := if fUseCore then 'WithNetInstance' else 'WithMonoInstance');

  result := new CGIfThenElseExpression(lCondition, lIfExpression, lElseExpression);
end;

end.
