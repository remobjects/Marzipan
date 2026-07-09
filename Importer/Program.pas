namespace Importer;

interface

uses
  System.IO,
  System.Linq,
  RemObjects.CodeGen4;

type
  ConsoleApp = static class
  private
    method WriteSyntax;
  public
    method Main(args: array of String);
  end;

implementation

method ConsoleApp.WriteSyntax;
begin
  writeLn('syntax: MZImporter.exe importsettings.xml langauge [mono|core]');
  writeLn();
  writeLn('  where');
  writeLn();
  writeLn('  * importsettings.xml is the path to an XML file with your import settings');
  writeLn();
  writeLn('      See http://docs.elementscompiler.com/Tools/Marzipan for details.');
  writeLn();
  writeLn('  * language is one of the following:');
  writeLn();
  writeLn('    - oxygene');
  writeLn('    - csharp');
  writeLn('    - swift');
  writeLn('    - objectivec');
  writeLn();
end;

method ConsoleApp.Main(args: array of String);
begin
  writeLn("RemObjects Marzipan Importer 2.0");
  writeLn("Built with CodeGen4");
  writeLn();

  if (length(args) < 2) or (length(args) > 3) then begin
    WriteSyntax;
    exit;
  end;

  var lSettingsFile := args[0];
  var lLanguage := args[1];

  var lCodeGenerator := case lLanguage:ToLower() of
    'oxygene','pascal','pas': new CGOxygeneCodeGenerator();
    'c#','csharp','hydrogene','cs': new CGCSharpCodeGenerator withDialect(CGCSharpCodeGeneratorDialect.Hydrogene);
    'swift','silver': new CGSwiftCodeGenerator withDialect(CGSwiftCodeGeneratorDialect.Silver);
    'objc','objectivec','m': new CGObjectiveCHCodeGenerator();
  end;

  if not assigned(lCodeGenerator) then begin
    WriteSyntax;
    exit;
  end;

  if not File.Exists(lSettingsFile) then begin
    writeLn('Import settings file '+Path.GetFileName(lSettingsFile)+' does not exist');
    writeLn();
    exit;
  end;

  var x := new ImporterSettings;
  x.LoadFromXml(lSettingsFile);
  if length(args) = 3 then begin
    case args[2]:ToLowerInvariant of
      'mono': x.Runtime := RuntimeBackend.Mono;
      'core': x.Runtime := RuntimeBackend.Core;
      else begin
        WriteSyntax;
        exit;
      end;
    end;
  end;
  Environment.CurrentDirectory := Path.GetDirectoryName(args[0]);

  var lWorker := new Importer(x, lCodeGenerator);
  lWorker.Log += s -> Console.WriteLine(s);
  lWorker.Run;
end;

end.
