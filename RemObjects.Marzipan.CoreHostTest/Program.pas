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
    class method InvokeBridgeSmokeException(aMethodName: NSString) expectedType(aExpectedType: NSString);
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

class method ConsoleApp.InvokeBridgeSmokeException(aMethodName: NSString) expectedType(aExpectedType: NSString);
begin
  writeLn('Testing managed exception propagation for '+String(aExpectedType)+'...');

  var lType := new MZType withTypeName('RemObjects.Marzipan.Bridge.TestHelpers') &assembly('RemObjects.Marzipan.Bridge');
  var lMethod := lType.getMethod(NSString.stringWithFormat(':%@()', aMethodName));
  var lFrame := new MZCallFrame withMethod(lMethod) target(nil) argumentCount(0);
  var lException := lFrame.invoke();

  if not assigned(lException) then
    raise new MZException withName('CoreHostTest') reason(NSString.stringWithFormat('Expected %@, but managed call returned normally.', aExpectedType)) userInfo(nil);

  try
    MZObject.raiseException(lException);
    raise new MZException withName('CoreHostTest') reason(NSString.stringWithFormat('Expected %@, but no native exception was raised.', aExpectedType)) userInfo(nil);
  except
    on e: MZException do begin
      if e.reason.rangeOfString(aExpectedType).location = Foundation.NSNotFound then
        raise new MZException withName('CoreHostTest') reason(NSString.stringWithFormat('Expected %@, got: %@', aExpectedType, e.reason)) userInfo(nil);
      if e.managedExceptionType.rangeOfString(aExpectedType).location = Foundation.NSNotFound then
        raise new MZException withName('CoreHostTest') reason(NSString.stringWithFormat('Expected managedExceptionType %@, got: %@', aExpectedType, e.managedExceptionType)) userInfo(nil);
      if length(e.managedExceptionMessage) = 0 then
        raise new MZException withName('CoreHostTest') reason('Managed exception did not retain its message.') userInfo(nil);
      writeLn('Caught expected MZException: '+String(aExpectedType));
      writeLn('Managed exception: '+String(e.managedExceptionType)+': '+String(e.managedExceptionMessage));
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

    writeLn('Testing Object[] to generic sequence conversion...');
    var lValues := NSMutableArray.array();
    lValues.addObject('one');
    lValues.addObject('two');
    var lManagedValues := new MZArray withNSArray(lValues);
    var lTestType := new MZType withTypeName('RemObjects.Marzipan.Bridge.TestHelpers') &assembly('RemObjects.Marzipan.Bridge');
    var lCountMethod := lTestType.getMethod(':CountStrings(System.Collections.Generic.IEnumerable`1<string>)');
    var lCountFrame := new MZCallFrame withMethod(lCountMethod) target(nil) argumentCount(1);
    lCountFrame.setObject(0) value(lManagedValues.__instance);
    var lCountException := lCountFrame.invoke();
    if assigned(lCountException) then
      MZObject.raiseException(lCountException);
    if lCountFrame.getInt32Result() ≠ 2 then
      raise new MZException withName('CoreHostTest') reason('Object[] was not converted to IEnumerable<string>.') userInfo(nil);

    InvokeBridgeSmokeException('ThrowArgumentException') expectedType('System.ArgumentException');
    InvokeBridgeSmokeException('ThrowNullReferenceException') expectedType('System.NullReferenceException');

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
