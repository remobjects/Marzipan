namespace Importer;

interface

uses
  System.Linq;

type
  ConsoleApp = class
  public
    class method Main(args: array of String);
  end;

implementation

class method ConsoleApp.Main(args: array of String);
begin
  var x := new ImporterSettings;
  x.Namespace := 'RemObjects.Oxygene.Compiler';
  x.OutputFilename := '.\output.pas';
  x.OutputType := OutputType.Nougat;
  x.Types.Add(new ImportType(Name := 'RemObjects.Oxygene.Code.Compiler.CodeCompletionCompiler'));
  x.Libraries.Add('c:\projects\oxygene\bin\RemObjects.Oxygene.tools.dll');
  x.Libraries.Add('c:\projects\oxygene\bin\RemObjects.Oxygene.dll');
  var lWorker := new Importer(x);
  lWorker.Log += s->Console.WriteLine(s);
  lWorker.Run;

  // add your own code here
  Console.WriteLine('Hello World.');
end;

end.
