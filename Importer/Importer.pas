namespace Importer;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Text,
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
    event Log: Action<String> raise;

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
    var lLib := fLibraries.SelectMany(a -> a.Types.Where(b -> b.FullName = el.Name)).ToArray;
    if lLib.Count = 0 then
      raise new Exception('Type "'+el.Name+'" was not found')
    else
      fTypes.Add(lLib[0]);
    var lNewName := fSettings.Prefix+ lLib[0].Name;
    Log('Adding type '+lNewName+' from '+lLib[0].FullName);
    fImportNameMapping.Add(lLib[0].FullName, lNewName);
  end;
  fFile := new CGFile;
  fFile.Name := Path.GetFileNameWithoutExtension(fSettings.OutputFilename);

  for each el in fTypes do begin
    Log('Generating type '+el.FullName);
  end;

  Log('Generating code');
  raise new NotImplementedException;
  //new CGGenerator(
end;

end.
