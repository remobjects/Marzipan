namespace RemObjects.Marzipan.CoreHostTest;

interface

uses
  Foundation,
  RemObjects.Marzipan,
  RemObjects.Fire.ManagedWrapper;

type
  ConsoleApp = static class
  private
    class method WriteSyntax;
    class method LoadAssembliesFromFolder(aFolder: NSString);
  public
    class method Main(args: array of String): Int32;
  end;

implementation

class method ConsoleApp.WriteSyntax;
begin
  writeLn('syntax: RemObjects.Marzipan.CoreHostTest runtimeRoot bridgeRuntimeConfig bridgeAssembly [compilerFolder]');
  writeLn();
  writeLn('  runtimeRoot          Path to a dotnet runtime root containing host/fxr.');
  writeLn('  bridgeRuntimeConfig  Path to RemObjects.Marzipan.Bridge.runtimeconfig.json.');
  writeLn('  bridgeAssembly       Path to RemObjects.Marzipan.Bridge.dll.');
  writeLn('  compilerFolder       Optional folder containing compiler/Core DLLs to load.');
end;

class method ConsoleApp.LoadAssembliesFromFolder(aFolder: NSString);
begin
  if (aFolder = nil) or (aFolder.length = 0) then exit;
  var lIsDir: Boolean := false;
  if not NSFileManager.defaultManager.fileExistsAtPath(aFolder) isDirectory(@lIsDir) or not lIsDir then begin
    writeLn('Compiler folder not found: '+String(aFolder));
    exit;
  end;

  var lFiles := NSFileManager.defaultManager.contentsOfDirectoryAtPath(aFolder) error(nil);
  for each lFile in lFiles do begin
    var lPath := aFolder.stringByAppendingPathComponent(NSString(lFile));
    if lPath.pathExtension.lowercaseString = 'dll' then begin
      writeLn('Loading '+String(lPath.lastPathComponent));
      MZCoreRuntime.sharedInstance.loadAssembly(lPath);
    end;
  end;
end;

class method ConsoleApp.Main(args: array of String): Int32;
begin
  if length(args) < 3 then begin
    WriteSyntax;
    exit 1;
  end;

  try
    var lRuntimeRoot := NSString.stringWithString(args[0]);
    var lRuntimeConfig := NSString.stringWithString(args[1]);
    var lBridge := NSString.stringWithString(args[2]);
    var lCompilerFolder := if length(args) > 3 then NSString.stringWithString(args[3]) else nil;

    writeLn('Initializing CoreCLR...');
    var lRuntime := new MZCoreRuntime withDomain('MarzipanCoreHostTest') appName('MarzipanCoreHostTest') version('dynamic') runtimeRoot(lRuntimeRoot) runtimeConfig(lRuntimeConfig) bridge(lBridge);

    LoadAssembliesFromFolder(lCompilerFolder);

    writeLn('Testing managed string roundtrip...');
    var lString := MZString.stringWithNSString('Hello from Marzipan/Core');
    writeLn('String length: '+lString.length.ToString);
    writeLn('String value: '+String(lString.NSString));

    writeLn('Testing object instantiation...');
    var lType := lRuntime.getType('System.Text.StringBuilder, System.Private.CoreLib');
    var lObject := new MZObject withNetInstance(lType.instantiate());
    writeLn('Object description: '+String(lObject.description));

    writeLn('Testing generated compiler wrapper call...');
    var lSpaces := BaseParser.GetSpaces(4, FragmentType.Oxygene);
    writeLn('Generated wrapper returned '+lSpaces.length.ToString+' spaces.');
    if lSpaces ≠ '    ' then
      raise new MZException withName('CoreHostTest') reason('Unexpected BaseParser.GetSpaces result.') userInfo(nil);

    writeLn('Core host smoke test passed.');
    exit 0;
  except
    on e: NSException do begin
      writeLn('Core host smoke test failed: '+String(e.reason));
      exit 2;
    end;
  end;
end;

end.
