namespace Importer;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.IO,
  Mono.Cecil,
  RemObjects.CodeGenerator;

type
  Importer = public class
  private
    fSettings: ImporterSettings;
    fLibraries: List<ModuleDefinition> := new List<ModuleDefinition>;
    fTypes: List<TypeDefinition> := new List<TypeDefinition>;
    fImportNameMapping: Dictionary<String, String> := new Dictionary<String,String>;
    fFile: CGFile;
  protected
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
  fImportNameMapping.Add('System.String', 'MZString');
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
  fImportNameMapping.Add('System.Char', 'uint16_t');
  fImportNameMapping.Add('System.Single', 'float');
  fImportNameMapping.Add('System.Double', 'double');
  fImportNameMapping.Add('System.Boolean', 'Boolean');
end;

method Importer.Run;
begin
  Log('Loading libraries');
  for each el in fSettings.Libraries do begin
    Log('  Loading '+el);
    fLibraries.Add(ModuleDefinition.ReadModule(el));
  end;
  Log('Resolving types');
  for each el in fSettings.Types do begin
    var lLib := fLibraries.SelectMany(a -> a.Types.Where(b -> (not b.IsValueType) and (b.GenericParameters.Count = 0) and (b.FullName = el.Name))).ToArray; // Lets ignore those for a sec.
    if lLib.Count = 0 then
      raise new Exception('Type "'+el.Name+'" was not found')
    else
      fTypes.Add(lLib[0]);
    var lNewName := fSettings.Prefix+ lLib[0].Name;
    Log('Adding type '+lNewName+' from '+lLib[0].FullName);
    fImportNameMapping.Add(lLib[0].FullName, lNewName);
  end;
  fFile := new CGFile;
  fFile.Comment := 'Marzipan import of '#13#10+
    String.Join(#13#10, fLibraries.Select(a->'  '+a.Assembly.Name.ToString));
  fFile.Uses.Add('RemObjects.Marzipan');
  fFile.Name := Path.GetFileNameWithoutExtension(fSettings.OutputFilename);
  var lVars := new List<CGMember>;
  var lMethods := new List<CGMember>;
  
  for each el in fTypes do begin
    Log('Generating type '+el.FullName);

    var lType := new CGNamedType();
    lType.Name := 'Import_'+el.Name;
    lType.Comment := 'Import of '+el.FullName+' from '+el.Scope.Name;
    var lTypeDef := new CGTypeDefinition();
    lType.Type := lTypeDef;

    fFile.Types.Add(lType);
    var lpt: String;
    if not fImportNameMapping.TryGetValue(el.BaseType.FullName, out lpt) then
      lpt := 'MZObject';
    lTypeDef.ParentType := lpt;
    lTypeDef.TDKind := CGTypeDefKind.Class;

    
    for each meth in el.Methods index n do begin
      if (meth.GenericParameters.Count > 0) or (meth.IsSpecialName and meth.Name.StartsWith('op_')) or (meth.IsConstructor and meth.IsStatic) then continue; 
      if meth.IsPrivate then continue;
      
      var lFType := new CGField;
      lFType.Static := true;
      lFType.Access := CGAccessModifier.Private;
      lFType.Name := 'f_'+n+'_'+meth.Name.Replace('.', '_');
      var lMonoSig := new  CGMethod;
      lMonoSig.MethodKind := CGMethodKind.Method;
      lMonoSig.ResultType := GetMonoType(meth.ReturnType);
      if meth.HasThis then
        lMonoSig.Arguments.Add(new CGMethodArgument(Name := 'instance', &Type := new CGPointerTypeRef(new CGNamedTypeRef('MonoObject'))));
      for each elpar in meth.Parameters do begin
        lMonoSig.Arguments.Add(new CGMethodArgument(Name := '_'+elpar.Name, &Type := GetMonoType(elpar.ParameterType)));
      end;
      lMonoSig.Arguments.Add(new CGMethodArgument(Name := 'exception', &Type := new CGPointerTypeRef(new CGPointerTypeRef(new CGNamedTypeRef('MonoException')))));
      lFType.Type := new CGInlineDelegate(Signature := lMonoSig);
      lVars.Add(lFType);
      var lMeth := new CGMethod;
      if meth.IsConstructor then 
        lMeth.Name := 'init'
      else
        lMeth.Name := meth.Name;
      lMethods.Add(lMeth);
      lMeth.Static := meth.IsStatic;
      lMeth.ResultType := GetMarzipanType(meth.ReturnType);
      for i: Integer := 0 to meth.Parameters.Count -1 do begin
        var lPar := new CGMethodArgument();
        lMeth.Arguments.Add(lPar);
        lPar.Name := '_'+meth.Parameters[i].Name;
        if meth.Parameters[i].ParameterType.IsByReference then begin
          lPAr.Type := GetMarzipanType(meth.Parameters[i].ParameterType.GetElementType);
          lPAr.Modifier := CGMethodArgumentModifier.Var;
        end else 
          lPAr.Type := GetMarzipanType(meth.Parameters[i].ParameterType);
      end;
    end;
    var lFType := new CGField;
    lFType.Static := true;
    lFType.Access := CGAccessModifier.Private;
    lFType.Name := 'fType';
    lFType.Type := new CGNamedTypeRef('MZType');
    var lCall := new CGCallExpression(new CGArgument(Value := new CGStringExpression(Value := el.FullName+', '+el.Scope.Name)));
    lCall.Self := new CGIdentifierExpression(ID := 'getType',
      &Self := new CGIdentifierExpression(ID := 'Instance', 
      &Self := new CGTypeExpression(&Type := new CGNamedTypeRef('MZMonoRuntime'))));
    lFType.Initializer := lCall;
    lTypeDef.Members.Add(lFType);
    for each elz in lVars do lTypeDef.Members.Add(elz);
    lVars.Clear;
    for each elz in lMethods do lTypeDef.Members.Add(elz);
    lMethods.Clear;
    var lGetType := new CGMethod;
    lGEtType.Static := true;
    lGetType.MethodKind := CGMethodKind.Method;
    lGetType.Access := CGAccessModifier.Public;
    lGetType.ResultType := 'MZType';
    lGetType.Name := 'getType';
    lGetType.Virtual := CGVirtualBits.Override;
    lGetType.Body := new CGBeginStatement(new CGExitStatement(Value := new CGIdentifierExpression(ID := 'fType')));

    lTypeDef.Members.Add(lGetType);
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
  if aType.IsPointer then exit new CGPointerTypeRef(GetMonoType(aType.GetElementType));
  case aType.FullName of
    'System.String': exit new CGPointerTypeRef(new CGNamedTypeRef('MonoString'));
    'System.Char': exit new CGPredefinedTypeRef(CGPredefinedType.Char);
    'System.Single': exit new CGPredefinedTypeRef(CGPredefinedType.Single);
    'System.Double': exit new CGPredefinedTypeRef(CGPredefinedType.Double);
    'System.Boolean': exit new CGPredefinedTypeRef(CGPredefinedType.Boolean);
    'System.SByte': exit new CGPredefinedTypeRef(CGPredefinedType.SByte);
    'System.Byte': exit new CGPredefinedTypeRef(CGPredefinedType.Byte);
    'System.Int16': exit new CGPredefinedTypeRef(CGPredefinedType.Int16);
    'System.UInt16': exit new CGPredefinedTypeRef(CGPredefinedType.UInt16);
    'System.Int32': exit new CGPredefinedTypeRef(CGPredefinedType.Int32);
    'System.UInt32': exit new CGPredefinedTypeRef(CGPredefinedType.UInt32);
    'System.Int64': exit new CGPredefinedTypeRef(CGPredefinedType.Int64);
    'System.UInt64': exit new CGPredefinedTypeRef(CGPredefinedType.UInt64);
    'System.IntPtr': exit new CGPredefinedTypeRef(CGPredefinedType.IntPtr);
    'System.UIntPtr': exit new CGPredefinedTypeRef(CGPredefinedType.UIntPtr);
  end;
  if aType.IsValueType then begin
    Log('Type: '+aType+' is a value type and is currently not supported');
    assert(false);
  end;
  exit new CGPointerTypeRef(new CGNamedTypeRef('MonoObject'));
end;

method Importer.GetMarzipanType(aType: TypeReference): CGTypeRef;
begin
  if aType.FullName = 'System.Void' then exit nil;
  if aType.IsPinned then exit GetMonoType(aType.GetElementType);
  if aType.IsPointer then exit new CGPointerTypeRef(GetMonoType(aType.GetElementType));
  var lRes: String;
  if self.fImportNameMapping.TryGetValue(aType.FullName, out lRes) then
    exit lRes;
  exit new CGNamedTypeRef('MZObject');

end;

end.
