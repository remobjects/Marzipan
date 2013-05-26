namespace Importer;

interface

uses
  System.Collections.Generic,
  System.Text,
  System.Linq,
  System.Xml.Linq;

type
  OutputType = public enum (Nougat, ObjC);
  ImporterSettings = public class
  private
    fLibraries : List<String> := new List<String>;
    fTypes: List<ImportType> := new List<ImportType>;
  protected
  public
    property Libraries: List<String> read fLibraries;
    property Types: List<ImportType> read fTypes;
    property &Namespace: String;
    property OutputType: OutputType;

    method LoadFromXml(aFN: String);
    method LoadFromXml(aDoc: XDocument);
  end;

  ImportType = public class
  private
  public
    property Name: String; 
  end;

implementation

method ImporterSettings.LoadFromXml(aFN: String);
begin
  LoadFromXml(XDocument.Load(aFN));
end;

method ImporterSettings.LoadFromXml(aDoc: XDocument);
begin
  if aDoc.Root:Name <> 'import' then raise new Exception('Root node should be "import"');
  &Namespace := aDoc.Root.Element('namespace'):Value;
  if aDoc.Root.Element('outputtype'):Value:ToLowerInvariant = 'objc' then
    OutputType := OutputType.ObjC;
  var lLibs := aDoc.Root.Elements('libraries');
  if lLibs = nil then raise new Exception('"Libraries" node missing');
  Libraries.AddRange(lLibs.Elements('library').Select(a->a.Value));
  var lTypes := aDoc.Root.Elements('types');
  if lTypes = nil then raise new Exception('"Types" node missing');
  for each el in lTypes.Elements('type') do begin
    Types.Add(new ImportType(Name := el.Element('name'):Value));
  end;
end;

end.
