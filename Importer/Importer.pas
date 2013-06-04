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
      //var lClassVar
      //lTypeDef.Members.Insert(0, 
    end;
    for each elz in lVars do lTypeDef.Members.Add(elz);
    lVars.Clear;
    for each elz in lMethods do lTypeDef.Members.Add(elz);
    lMethods.Clear;
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
    'System.Int32': exit new CGPredefinedTypeRef(CGPredefinedType.Int32);
    'System.String': exit new CGPointerTypeRef(new CGNamedTypeRef('MonoString'));
    // TODO: Finish
  end;
  if aType.IsValueType then begin
    assert(false);
  end;
  exit new CGPointerTypeRef(new CGNamedTypeRef('MonoObject'));
end;

end.
