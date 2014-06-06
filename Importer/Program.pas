namespace Importer;

interface

uses
  System.IO,
  System.Linq;

type
  ConsoleApp = class
  public
    class method Main(args: array of String);
  end;

implementation

class method ConsoleApp.Main(args: array of String);
begin
  Console.WriteLine("RemObjects Marzipan Importer");
  Console.WriteLine;
  if length(args) <> 1 then begin
    Console.WriteLine('syntax: importsettings.xml');
    exit;
  end;
  
  var x := new ImporterSettings;
  x.LoadFromXml(args[0]);
  Environment.CurrentDirectory := Path.GetDirectoryName(args[0]);

  var lWorker := new Importer(x);
  lWorker.Log += s->Console.WriteLine(s);
  lWorker.Run;
end;

end.
