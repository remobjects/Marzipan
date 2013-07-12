namespace Importer;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Reflection,
  System.Text,
  System.IO,
  Mono.Cecil,
  RemObjects.CodeGenerator;

type
  Importer = public class(IAssemblyResolver)
  private
    method LoadAsm(el: String): ModuleDefinition;
    fSettings: ImporterSettings;
    fLibraries: List<ModuleDefinition> := new List<ModuleDefinition>;
    fTypes: List<TypeDefinition> := new List<TypeDefinition>;
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
    LoadAsm(el);
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
  
  var lNames: HashSet<String> := new HashSet<String>;
  var lMethodMap: Dictionary<MethodDefinition, CGMethod> := new Dictionary<MethodDefinition,CGMethod>;
  for each el in fTypes do begin
    Log('Generating type '+el.FullName);
    lMethodMap.Clear;

    var lType := new CGNamedType();
    lType.Name := el.Name;
    lType.Comment := 'Import of '+el.FullName+' from '+el.Scope.Name;
    var lTypeDef := new CGTypeDefinition();
    lType.Type := lTypeDef;

    fFile.Types.Add(lType);
    var lpt: String;
    if not fImportNameMapping.TryGetValue(el.BaseType.FullName, out lpt) then
      lpt := 'MZObject';
    lTypeDef.ParentType := lpt;
    lTypeDef.TDKind := CGTypeDefKind.Class;
    lNames.Clear;
    lMethodMap.Clear;
    for each meth in el.Methods index n do begin
      if (meth.GenericParameters.Count > 0) or (meth.IsSpecialName and meth.Name.StartsWith('op_')) or (meth.IsConstructor and meth.IsStatic) then continue; 
      if not meth.IsPublic then continue;
      
      var lFType := new CGField;
      lFType.Static := true;
      lFType.Access := CGAccessModifier.Private;
      lFType.Name := 'f_'+n+'_'+meth.Name.Replace('.', '_');
      var lMonoSig := new  CGMethod;
      lMonoSig.MethodKind := CGMethodKind.Method;
      if (meth.ReturnType.FullName <> 'System.Void') then
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
      lMethodMap[meth] := lMeth;
      if meth.IsConstructor then 
        lMeth.Name := 'init'
      else
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
      lMeth.ResultType := GetMarzipanType(meth.ReturnType);
      for i: Integer := 0 to meth.Parameters.Count -1 do begin
        var lPar := new CGMethodArgument();
        lMeth.Arguments.Add(lPar);
        lPar.Name := '_'+meth.Parameters[i].Name;
        if meth.Parameters[i].ParameterType.IsByReference then begin
          lPar.Type := GetMarzipanType(meth.Parameters[i].ParameterType.GetElementType);
          lPar.Modifier := CGMethodArgumentModifier.Var;
        end else 
          lPar.Type := GetMarzipanType(meth.Parameters[i].ParameterType);
      end;
    end;

    var lProperties := new List<CGProperty>;

    for each prop in el.Properties do begin
      if not (((prop.GetMethod <> nil) and (prop.GetMethod.IsPublic)) or ((prop.SetMethod <> nil) and (prop.SetMethod.IsPublic)))then continue;
      var lProp := new CGProperty();
      lProp.Access := CGAccessModifier.Public;
      lProp.Name := prop.Name;
      lProp.Type := GetMonoType(prop.PropertyType);
      if prop.GetMethod <> nil then begin
        var lMeth := lMethodMap[prop.GetMethod];
        lMeth.Access := CGAccessModifier.Private;
        lMeth.Name := prop.Name;

        lProp.Read := new CGIdentifierExpression(ID := prop.Name);
      end;

      if prop.SetMethod <> nil then begin
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
    var lCall := new CGCallExpression(new CGArgument(Value := new CGStringExpression(Value := el.FullName+', '+el.Scope.Name)));
    lCall.Self := new CGIdentifierExpression(ID := 'getType',
      &Self := new CGIdentifierExpression(ID := 'Instance', 
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
  var lType := aType.Resolve;
  var lStr: String;
  if fImportNameMapping.TryGetValue(lType.FullName, out lStr) then exit lStr;
  if lType.IsEnum then begin
    fEnumTypes.Add(lType);
    fImportNameMapping.Add(lType.FullName, lType.Name);
    exit lType.Name;
  end;
  if lType.IsValueType then begin
    fValueTypes.Add(lType);
    fImportNameMapping.Add(lType.FullName, lType.Name);
    exit lType.Name;
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
  fLoaded.Add(md.Assembly.Name.ToString, md);
  exit md;
end;

end.
