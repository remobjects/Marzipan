namespace RemObjects.Marzipan;

interface

uses
  Foundation;

type
  // Forward declarations for opaque CoreCLR types
  CoreCLRHostHandle = public IntPtr;
  CoreCLRDomainId = public Integer;

  MZException = public class(NSException) end;

  MZCoreRuntime = public class
  private
    fHostHandle: CoreCLRHostHandle;
    fDomainId: CoreCLRDomainId;
    fAssemblies: NSMutableDictionary := new NSMutableDictionary;
    fTypes: NSMutableDictionary := new NSMutableDictionary;
    class var fInstance: MZCoreRuntime;
    class method get_sharedInstance: MZCoreRuntime;

    method initializeCoreCLR(aAppPath, aAppName: String);
    method createDelegate(aAssemblyName, aTypeName, aMethodName: String): IntPtr;
  public
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString);

    class property sharedInstance: MZCoreRuntime read get_sharedInstance;

    method loadAssembly(aPath: NSString): MZCoreAssembly;
    method getType(aFullName: NSString): MZType;
    method getCoreType(aType: NSString; aAssembly: NSString := 'System.Private.CoreLib'): MZType;

    method attachToThread;

    property domainId: CoreCLRDomainId read fDomainId;
    property hostHandle: CoreCLRHostHandle read fHostHandle;
    finalizer;
  end;

  MZCoreAssembly = public class
  private
    fName: NSString;
    fPath: NSString;
  public
    constructor withNameAndPath(aName, aPath: NSString);
    property name: NSString read fName;
    property path: NSString read fPath;
  end;

  MZType = public class
  private
    fTypeName: NSString;
    fAssembly: NSString;
  public
    constructor withTypeName(aTypeName: NSString) &assembly(aAssembly: NSString);
    property typeName: NSString read fTypeName;
    property &assembly: NSString read fAssembly;
  end;

// CoreCLR hosting API declarations (external, you need to provide the actual dylib path)
function coreclr_initialize(appBasePath: ^AnsiChar; appDomainFriendlyName: ^AnsiChar; propertyCount: Integer; propertyKeys: ^^AnsiChar; propertyValues: ^^AnsiChar; out hostHandle: CoreCLRHostHandle; out domainId: CoreCLRDomainId): Integer; external 'libcoreclr.dylib';
function coreclr_create_delegate(hostHandle: CoreCLRHostHandle; domainId: CoreCLRDomainId; assemblyName: ^AnsiChar; typeName: ^AnsiChar; methodName: ^AnsiChar; out delegate: IntPtr): Integer; external 'libcoreclr.dylib';
function coreclr_shutdown(hostHandle: CoreCLRHostHandle; domainId: CoreCLRDomainId): Integer; external 'libcoreclr.dylib';

implementation

constructor MZCoreRuntime withDomain(aDomain: NSString) appName(aAppName: NSString);
begin
  initializeCoreCLR(aDomain, aAppName);
  fInstance := self;
end;

method MZCoreRuntime.initializeCoreCLR(aAppPath, aAppName: String);
begin
  var lHostHandle: CoreCLRHostHandle;
  var lDomainId: CoreCLRDomainId;

  // Set up CoreCLR properties (Tweak as needed for your environment)
  var lPropertyKeys: array[0..1] of ^AnsiChar := [@"TRUSTED_PLATFORM_ASSEMBLIES", @"APP_PATHS"];
  var lPropertyValues: array[0..1] of ^AnsiChar := ["/usr/local/share/dotnet/shared/Microsoft.NETCore.App/6.0.0", aAppPath.ToUTF8String];

  var lResult := coreclr_initialize(aAppPath.ToUTF8String, aAppName.ToUTF8String, 2, @lPropertyKeys[0], @lPropertyValues[0], out lHostHandle, out lDomainId);
  if lResult <> 0 then
    raise new NSException withName('CoreCLRInitFailed') reason('coreclr_initialize failed with code ' + lResult.ToString) userInfo(nil);

  fHostHandle := lHostHandle;
  fDomainId := lDomainId;
end;

class method MZCoreRuntime.get_sharedInstance: MZCoreRuntime;
begin
  if not assigned(fInstance) then
    raise new NSException withName('MZException') reason('MZCoreRuntime not initialized') userInfo(nil);
  result := fInstance;
end;

method MZCoreRuntime.createDelegate(aAssemblyName, aTypeName, aMethodName: String): IntPtr;
begin
  var lDelegate: IntPtr;
  var lResult := coreclr_create_delegate(fHostHandle, fDomainId, aAssemblyName.ToUTF8String, aTypeName.ToUTF8String, aMethodName.ToUTF8String, out lDelegate);
  if lResult <> 0 then
    raise new NSException withName('CoreCLRDelegateFailed') reason('coreclr_create_delegate failed with code ' + lResult.ToString) userInfo(nil);
  result := lDelegate;
end;

method MZCoreRuntime.loadAssembly(aPath: NSString): MZCoreAssembly;
begin
  // In CoreCLR, assemblies are loaded via managed code. Here, just track the path.
  locking self do begin
    result := fAssemblies.objectForKey(aPath);
    if assigned(result) then exit;
    result := new MZCoreAssembly withNameAndPath(aPath.lastPathComponent, aPath);
    fAssemblies.setObject(result) forKey(aPath);
  end;
end;

method MZCoreRuntime.getType(aFullName: NSString): MZType;
begin
  // In CoreCLR, type resolution is via managed code. Here, just store the name.
  locking self do begin
    result := fTypes.objectForKey(aFullName);
    if assigned(result) then exit;
    // Assume format "Namespace.Type, Assembly"
    var lParts := aFullName.componentsSeparatedByString(',');
    var lTypeName := lParts[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet);
    var lAssembly := if lParts.count > 1 then lParts[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet) else 'System.Private.CoreLib';
    result := new MZType withTypeName(lTypeName) &assembly(lAssembly);
    fTypes.setObject(result) forKey(aFullName);
  end;
end;

method MZCoreRuntime.getCoreType(aType: NSString; aAssembly: NSString := 'System.Private.CoreLib'): MZType;
begin
  exit getType(NSString.stringWithFormat('%@, %@', aType, aAssembly));
end;

method MZCoreRuntime.attachToThread;
begin
  // CoreCLR does not require explicit thread attach in the same way as Mono.
end;

finalizer MZCoreRuntime;
begin
  if fHostHandle <> nil then
    coreclr_shutdown(fHostHandle, fDomainId);
end;

// --- Assembly and Type wrappers ---

constructor MZCoreAssembly withNameAndPath(aName, aPath: NSString);
begin
  fName := aName;
  fPath := aPath;
end;

constructor MZType withTypeName(aTypeName: NSString) &assembly(aAssembly: NSString);
begin
  fTypeName := aTypeName;
  fAssembly := aAssembly;
end;

end.