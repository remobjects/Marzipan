namespace RemObjects.Marzipan;

interface

uses
  Foundation;

type
  MZException = public class(NSException) end;

  MZCoreRuntime = public class
  private
    class var fInstance: MZCoreRuntime;
    class method get_sharedInstance: MZCoreRuntime;

    fVersion: String;
    fObject, fString, fBoolean, fByte, fSByte, fInt16, fUInt16, fInt32, fUInt32, fInt64, fUInt64, fSingle, fDouble, fIntPtr, fUIntPtr, fChar: MZType;
    fHostHandle: ^Void;
    // fDomainId: Integer; // Reserved for future hosting APIs that return domain/app context IDs.
    fRuntimeRoot: NSString;
    fRuntimeConfigPath: NSString;
    fBridgeAssemblyPath: NSString;
    fHostFxrHandle: ^Void;
    fLoadAssemblyAndGetFunctionPointer: ^Void;

    fTypes: NSMutableDictionary := new NSMutableDictionary;
    fAssemblies: NSMutableDictionary := new NSMutableDictionary;
    // fAssemblyNames: NSMutableDictionary := new NSMutableDictionary; // Reserved for assembly name lookup cache.

    method initializeCoreCLR(aDomain, aAppName, aVersion, aRuntimeRoot, aRuntimeConfigPath, aBridgeAssemblyPath: NSString);
    method runMain;

  assembly

    method createDelegate(aAssemblyName, aTypeName, aMethodName: String): ^Void;

  public
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString);
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString);
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString) lib(aLibPath: NSString) etc(aETCPath: NSString);
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString) runtimeRoot(aRuntimeRoot: NSString) runtimeConfig(aRuntimeConfigPath: NSString) bridge(aBridgeAssemblyPath: NSString);

    class property sharedInstance: MZCoreRuntime read get_sharedInstance;

    property version: String read fVersion;
    property hostHandle: ^Void read fHostHandle;
    // property domainId: Integer read fDomainId; // Reserved for future hosting APIs.
    property runtimeRoot: NSString read fRuntimeRoot;
    property runtimeConfigPath: NSString read fRuntimeConfigPath;
    property bridgeAssemblyPath: NSString read fBridgeAssemblyPath;

    method loadAssembly(aPath: NSString): MZCoreAssembly;
    method getType(aFullName: NSString): MZType;
    method getCoreType(aType: NSString; aAssembly: NSString := "System.Private.CoreLib"): MZType;

    method attachToThread;

    property byte: MZType read get_byte;
    property sbyte: MZType read get_sbyte;
    property int16: MZType read get_int16;
    property uint16: MZType read get_uint16;
    property int32: MZType read get_int32;
    property uint32: MZType read get_uint32;
    property int64: MZType read get_int64;
    property uint64: MZType read get_uint64;
    property single: MZType read get_single;
    property _double: MZType read get_double;
    property intptr: MZType read get_intptr;
    property uintptr: MZType read get_uintptr;
    property _char: MZType read get_char;
    property boolean: MZType read get_boolean;

    property object: MZType read get_object;
    property string: MZType read get_string;
    finalizer;
  private
    method get_object: MZType;
    method get_string: MZType;
    method get_boolean: MZType;
    method get_byte: MZType;
    method get_sbyte: MZType;
    method get_int16: MZType;
    method get_uint16: MZType;
    method get_int32: MZType;
    method get_uint32: MZType;
    method get_int64: MZType;
    method get_uint64: MZType;
    method get_single: MZType;
    method get_double: MZType;
    method get_intptr: MZType;
    method get_uintptr: MZType;
    method get_char: MZType;
  end;

  MZTypeCode = public enum (Other = 0, &Void = 1, Boolean, Char, I1, U1, I2, U2, I4, U4, I8, U8, R4, R8, I = $18, U = $19);

  MZType = public class
  private
    fTypeName: NSString;
    fAssembly: NSString;
  public
    constructor withTypeName(aTypeName: NSString) &assembly(aAssembly: NSString);
    property typeName: NSString read fTypeName;
    property &assembly: NSString read fAssembly;

    method getMethod(aSig: NSString): MZMethod;
    method getMethodThunk(aSig: NSString): ^Void;
    method instantiate: ^Void;
  end;

  MZMethod = public class
  private
    fHandle: ^Void;
  public
    constructor withHandle(aHandle: ^Void);
    property handle: ^Void read fHandle;
    finalizer;
  end;

  MZCallFrame = public class
  private
    fHandle: ^Void;
    class var fCreateDelegate, fFreeDelegate, fInvokeDelegate: ^Void;
    class var fSetObjectDelegate, fSetStringDelegate, fSetBooleanDelegate, fSetI4Delegate, fSetU4Delegate, fSetI8Delegate, fSetU8Delegate, fSetR4Delegate, fSetR8Delegate, fSetIntPtrDelegate, fSetDateTimeDelegate: ^Void;
    class var fGetObjectDelegate, fGetStringDelegate, fGetBooleanDelegate, fGetI4Delegate, fGetU4Delegate, fGetI8Delegate, fGetU8Delegate, fGetR4Delegate, fGetR8Delegate, fGetIntPtrDelegate, fGetDateTimeDelegate: ^Void;
    class var fGetArgumentObjectDelegate, fGetArgumentStringDelegate, fGetArgumentBooleanDelegate, fGetArgumentI4Delegate, fGetArgumentU4Delegate, fGetArgumentI8Delegate, fGetArgumentU8Delegate, fGetArgumentR4Delegate, fGetArgumentR8Delegate, fGetArgumentIntPtrDelegate, fGetArgumentDateTimeDelegate: ^Void;
  public
    constructor withMethod(aMethod: MZMethod) target(aTarget: ^Void) argumentCount(aArgumentCount: Integer);
    property handle: ^Void read fHandle;

    method setObject(aIndex: Integer) value(aValue: ^Void);
    method setString(aIndex: Integer) value(aValue: ^Void);
    method setBoolean(aIndex: Integer) value(aValue: Boolean);
    method setInt32(aIndex: Integer) value(aValue: Int32);
    method setUInt32(aIndex: Integer) value(aValue: UInt32);
    method setInt64(aIndex: Integer) value(aValue: Int64);
    method setUInt64(aIndex: Integer) value(aValue: UInt64);
    method setSingle(aIndex: Integer) value(aValue: Single);
    method setDouble(aIndex: Integer) value(aValue: Double);
    method setIntPtr(aIndex: Integer) value(aValue: intptr_t);
    method setDateTime(aIndex: Integer) value(aValue: MZDateTime);

    method invoke: ^Void;
    method getArgumentObject(aIndex: Integer): ^Void;
    method getArgumentString(aIndex: Integer): ^Void;
    method getArgumentBoolean(aIndex: Integer): Boolean;
    method getArgumentInt32(aIndex: Integer): Int32;
    method getArgumentUInt32(aIndex: Integer): UInt32;
    method getArgumentInt64(aIndex: Integer): Int64;
    method getArgumentUInt64(aIndex: Integer): UInt64;
    method getArgumentSingle(aIndex: Integer): Single;
    method getArgumentDouble(aIndex: Integer): Double;
    method getArgumentIntPtr(aIndex: Integer): intptr_t;
    method getArgumentDateTime(aIndex: Integer): MZDateTime;

    method getObjectResult: ^Void;
    method getStringResult: ^Void;
    method getBooleanResult: Boolean;
    method getInt32Result: Int32;
    method getUInt32Result: UInt32;
    method getInt64Result: Int64;
    method getUInt64Result: UInt64;
    method getSingleResult: Single;
    method getDoubleResult: Double;
    method getIntPtrResult: intptr_t;
    method getDateTimeResult: MZDateTime;
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

  MZObject = public class
  protected
    fInstance: ^Void;
    class var fFreeHandleDelegate: ^Void;
    class var fEqualsDelegate, fDescriptionDelegate, fExceptionStringDelegate: ^Void;
    method setInstance(aInstance: ^Void);
  public
    class method raiseException(aEx: ^Void);
    class method freeHandle(aHandle: ^Void);
    constructor withNetInstance(aInstance: ^Void);
    property __instance: ^Void read fInstance write setInstance;
    class method getTypeCode: MZTypeCode; virtual;
    class method getType: MZType; virtual;
    method toType(aType: &Class): id;
    method &equals(aOther: MZObject): Boolean;
    method description: NSString; override;
    finalizer;
  end;

  MZCoreHelpers = public class
  private
    class var fForceGarbageCollectionDelegate: ^Void;
  public
    class method forceGarbageCollection: NSString;
  end;

  MZDebugVoidCallback = public procedure(aUserData: ^Void);
  MZDebugIntCallback = public procedure(aUserData: ^Void; aValue: Integer);
  MZDebugObjectCallback = public procedure(aUserData: ^Void; aValue: ^Void);
  MZDebugStringCallback = public procedure(aUserData: ^Void; aValue: ^Void);
  MZDebugTwoStringCallback = public procedure(aUserData: ^Void; aFirst: ^Void; aSecond: ^Void);
  MZDebugObjectStringCallback = public procedure(aUserData: ^Void; aFirst: ^Void; aSecond: ^Void);
  MZDebugTwoObjectCallback = public procedure(aUserData: ^Void; aFirst: ^Void; aSecond: ^Void);
  MZDebugRemoteFileNeededCallback = public function(aUserData: ^Void; aRemoteFileName: ^Void): ^Void;
  MZDebugBreakExceptionCallback = public procedure(aUserData: ^Void; aThread: ^Void; aFatal: Byte; aType: ^Void; aMessage: ^Void);
  MZDebugProgressCallback = public procedure(aUserData: ^Void; aPercentage: Integer; aMessage: ^Void);

  MZCoreDebugEngineCallbacks = public class
  private
    class var fAttachCallbacksDelegate: ^Void;
  public
    class method attach(aDebugEngine: ^Void) userData(aUserData: ^Void)
      debugProgress(aDebugProgress: MZDebugProgressCallback)
      threadStarted(aThreadStarted: MZDebugObjectCallback)
      threadFinished(aThreadFinished: MZDebugObjectCallback)
      threadRenamed(aThreadRenamed: MZDebugObjectCallback)
      processTerminated(aProcessTerminated: MZDebugIntCallback)
      processStarted(aProcessStarted: MZDebugVoidCallback)
      processReady(aProcessReady: MZDebugVoidCallback)
      processFailedToStart(aProcessFailedToStart: MZDebugStringCallback)
      log(aLog: MZDebugTwoStringCallback)
      stdOut(aSTDOut: MZDebugStringCallback)
      stdErr(aSTDErr: MZDebugStringCallback)
      breakStop(aBreakStop: MZDebugTwoObjectCallback)
      breakpointResolved(aBreakpointResolved: MZDebugObjectCallback)
      breakpointSignal(aBreakpointSignal: MZDebugObjectStringCallback)
      remoteFileNeeded(aRemoteFileNeeded: MZDebugRemoteFileNeededCallback)
      breakException(aBreakException: MZDebugBreakExceptionCallback)
      disposed(aDisposed: MZDebugVoidCallback)
      moduleLoad(aModuleLoad: MZDebugObjectCallback)
      moduleUnload(aModuleUnload: MZDebugObjectCallback): ^Void;
  end;

  hostfxr_delegate_type = public enum
  (
    hdt_com_activation = 0,
    hdt_load_in_memory_assembly = 1,
    hdt_winrt_activation = 2,
    hdt_com_register = 3,
    hdt_com_unregister = 4,
    hdt_load_assembly_and_get_function_pointer = 5,
    hdt_get_function_pointer = 6
    ) of Integer;

  hostfxr_initialize_parameters = public record
    // Fields are required by hostfxr ABI even if not read directly in managed code.
    size: NativeUInt;
    host_path: ^AnsiChar;
    dotnet_root: ^AnsiChar;
  end;

  get_hostfxr_parameters = public record
    // Fields are required by nethost ABI even if not read directly in managed code.
    size: NativeUInt;
    assembly_path: ^AnsiChar;
    dotnet_root: ^AnsiChar;
  end;

implementation

type
  hostfxr_handle = ^Void;



  hostfxr_initialize_for_runtime_config_fn = function(runtime_config_path: ^AnsiChar; parameters: ^hostfxr_initialize_parameters; out handle: hostfxr_handle): Integer; cdecl;
  hostfxr_get_runtime_delegate_fn = function(handle: hostfxr_handle; delegate_type: hostfxr_delegate_type; out delegate: ^Void): Integer; cdecl;
  hostfxr_close_fn = function(handle: hostfxr_handle): Integer; cdecl;

  get_hostfxr_path_fn = function(buffer: ^AnsiChar; buffer_size: ^NativeUInt; parameters: ^get_hostfxr_parameters): Integer; cdecl;

  load_assembly_and_get_function_pointer_fn = function(assembly_path: ^AnsiChar; type_name: ^AnsiChar; method_name: ^AnsiChar; delegate_type_name: ^AnsiChar; reserved: ^Void; out delegate: ^Void): Integer; cdecl;

const
  RTLD_NOW = 2;

[System.Runtime.InteropServices.DllImport('/usr/lib/libSystem.B.dylib')]
method dlopen(path: ^AnsiChar; mode: Integer): ^Void; external;

[System.Runtime.InteropServices.DllImport('/usr/lib/libSystem.B.dylib')]
method dlsym(handle: ^Void; symbol: ^AnsiChar): ^Void; external;

method fileExists(aPath: NSString): Boolean;
begin
  if (aPath = nil) or (aPath.length = 0) then exit false;
  exit NSFileManager.defaultManager.fileExistsAtPath(aPath);
end;

method tryGetHostFxrPathFromNethost(aRuntimeRoot: NSString): NSString;
begin
  // We try nethost first if the app ships it. If missing, we fall back to scanning host/fxr.
  // This keeps us version-agnostic and avoids hardcoding a specific runtime version.
  if (aRuntimeRoot = nil) or (aRuntimeRoot.length = 0) then exit nil;

  var lCandidates := new NSMutableArray;
  lCandidates.addObject(aRuntimeRoot.stringByAppendingPathComponent('libnethost.dylib'));

  var lFxrRoot := aRuntimeRoot.stringByAppendingPathComponent('host').stringByAppendingPathComponent('fxr');
  if fileExists(lFxrRoot) then begin
    var lDirs := NSFileManager.defaultManager.contentsOfDirectoryAtPath(lFxrRoot) error(nil);
    if lDirs <> nil then begin
      for each lDir in lDirs do
        lCandidates.addObject(lFxrRoot.stringByAppendingPathComponent(String(lDir)).stringByAppendingPathComponent('libnethost.dylib'));
    end;
  end;

  for each lPath in lCandidates do begin
    if not fileExists(NSString(lPath)) then continue;
    var lHandle := dlopen(NSString(lPath).UTF8String, RTLD_NOW);
    if lHandle = nil then continue;
    var lSym := dlsym(lHandle, 'get_hostfxr_path');
    if lSym = nil then continue;

    var lGetPath: get_hostfxr_path_fn;
    ^^Void(@lGetPath)^ := lSym;

    var lBufferSize: NativeUInt := 1024;
    var lBuffer := new AnsiChar[lBufferSize];
    var lParams: get_hostfxr_parameters;
    lParams.size := sizeOf(get_hostfxr_parameters);
    lParams.assembly_path := nil;
    lParams.dotnet_root := aRuntimeRoot.UTF8String;

    var lRes := lGetPath(@lBuffer[0], @lBufferSize, @lParams);
    if lRes = 0 then begin
      exit NSString.stringWithUTF8String(@lBuffer[0]);
    end;
  end;
  exit nil;
end;

method findHostFxrPathByScanning(aRuntimeRoot: NSString): NSString;
begin
  // Fallback: scan host/fxr and pick the numerically highest version folder.
  // This preserves forward-compatibility when the app bundles newer runtimes.
  if (aRuntimeRoot = nil) or (aRuntimeRoot.length = 0) then exit nil;
  var lFxrRoot := aRuntimeRoot.stringByAppendingPathComponent('host').stringByAppendingPathComponent('fxr');
  if not fileExists(lFxrRoot) then exit nil;

  var lDirs := NSFileManager.defaultManager.contentsOfDirectoryAtPath(lFxrRoot) error(nil);
  if (lDirs = nil) or (lDirs.count = 0) then exit nil;

  var lSorted := lDirs.sortedArrayUsingComparator((a, b) -> begin
    exit String(b).compare(String(a)) options(NSStringCompareOptions.NSNumericSearch);
  end);
  var lLatest := NSString(lSorted[0]);
  var lPath := lFxrRoot.stringByAppendingPathComponent(lLatest).stringByAppendingPathComponent('libhostfxr.dylib');
  if fileExists(lPath) then exit lPath;
  exit nil;
end;

method loadHostFxr(aRuntimeRoot: NSString): ^Void;
begin
  // Attempt nethost resolution first; if not present, fall back to a direct scan.
  var lHostFxrPath := tryGetHostFxrPathFromNethost(aRuntimeRoot);
  if lHostFxrPath = nil then
    lHostFxrPath := findHostFxrPathByScanning(aRuntimeRoot);

  if lHostFxrPath = nil then
    raise new MZException withName("CoreCLR") reason("Could not locate libhostfxr.dylib. Ensure runtimeRoot points to a valid dotnet runtime.") userInfo(nil);

  var lHandle := dlopen(lHostFxrPath.UTF8String, RTLD_NOW);
  if lHandle = nil then
    raise new MZException withName("CoreCLR") reason(NSString.stringWithFormat("Failed to load hostfxr: %@", lHostFxrPath)) userInfo(nil);

  exit lHandle;
end;

constructor MZCoreRuntime withDomain(aDomain: NSString) appName(aAppName: NSString);
begin
  constructor withDomain(aDomain) appName(aAppName) version("v8.0.0");
end;

constructor MZCoreRuntime withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString);
begin
  constructor withDomain(aDomain) appName(aAppName) version(aVersion) lib(nil) etc(nil);
end;

constructor MZCoreRuntime withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString) lib(aLibPath: NSString) etc(aETCPath: NSString);
begin
  constructor withDomain(aDomain) appName(aAppName) version(aVersion) runtimeRoot(aLibPath) runtimeConfig(aETCPath) bridge(nil);
end;

constructor MZCoreRuntime withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString) runtimeRoot(aRuntimeRoot: NSString) runtimeConfig(aRuntimeConfigPath: NSString) bridge(aBridgeAssemblyPath: NSString);
begin
  if fInstance <> nil then raise new MZException withName("OnlyOneCoreCLR") reason("Only one runtime per class") userInfo(nil);
  fVersion := aVersion;
  fInstance := self;
  initializeCoreCLR(aDomain, aAppName, aVersion, aRuntimeRoot, aRuntimeConfigPath, aBridgeAssemblyPath);
  runMain();
end;

method MZCoreRuntime.initializeCoreCLR(aDomain, aAppName, aVersion, aRuntimeRoot, aRuntimeConfigPath, aBridgeAssemblyPath: NSString);
begin
  // Fail fast: the library is runtime-agnostic, so the host must provide explicit paths.
  if (aRuntimeRoot = nil) or (aRuntimeRoot.length = 0) then
    raise new MZException withName("CoreCLR") reason("runtimeRoot is required.") userInfo(nil);
  if (aRuntimeConfigPath = nil) or (aRuntimeConfigPath.length = 0) then
    raise new MZException withName("CoreCLR") reason("runtimeConfigPath is required.") userInfo(nil);
  if (aBridgeAssemblyPath = nil) or (aBridgeAssemblyPath.length = 0) then
    raise new MZException withName("CoreCLR") reason("bridgeAssemblyPath is required.") userInfo(nil);
  if not fileExists(aRuntimeConfigPath) then
    raise new MZException withName("CoreCLR") reason(NSString.stringWithFormat("runtimeConfigPath not found: %@", aRuntimeConfigPath)) userInfo(nil);
  if not fileExists(aBridgeAssemblyPath) then
    raise new MZException withName("CoreCLR") reason(NSString.stringWithFormat("bridgeAssemblyPath not found: %@", aBridgeAssemblyPath)) userInfo(nil);

  fRuntimeRoot := aRuntimeRoot;
  fRuntimeConfigPath := aRuntimeConfigPath;
  fBridgeAssemblyPath := aBridgeAssemblyPath;

  // Load hostfxr and get required entry points.
  fHostFxrHandle := loadHostFxr(aRuntimeRoot);
  var lInitSym := dlsym(fHostFxrHandle, 'hostfxr_initialize_for_runtime_config');
  var lGetDelSym := dlsym(fHostFxrHandle, 'hostfxr_get_runtime_delegate');
  var lCloseSym := dlsym(fHostFxrHandle, 'hostfxr_close');
  if (lInitSym = nil) or (lGetDelSym = nil) or (lCloseSym = nil) then
    raise new MZException withName("CoreCLR") reason("hostfxr symbols not found. Ensure the runtimeRoot is valid.") userInfo(nil);

  var lInit: hostfxr_initialize_for_runtime_config_fn;
  var lGetDel: hostfxr_get_runtime_delegate_fn;
  var lClose: hostfxr_close_fn;
  ^^Void(@lInit)^ := lInitSym;
  ^^Void(@lGetDel)^ := lGetDelSym;
  ^^Void(@lClose)^ := lCloseSym;

  var lParams: hostfxr_initialize_parameters;
  lParams.size := sizeOf(hostfxr_initialize_parameters);
  lParams.host_path := nil;
  lParams.dotnet_root := aRuntimeRoot.UTF8String;

  var lHandle: hostfxr_handle := nil;
  var lRes := lInit(aRuntimeConfigPath.UTF8String, @lParams, out lHandle);
  if lRes <> 0 then
    raise new MZException withName("CoreCLR") reason(NSString.stringWithFormat("hostfxr_initialize_for_runtime_config failed: %d", lRes)) userInfo(nil);

  fHostHandle := lHandle;

  // Request the load_assembly_and_get_function_pointer delegate.
  var lDelegate: ^Void := nil;
  lRes := lGetDel(lHandle, hostfxr_delegate_type.hdt_load_assembly_and_get_function_pointer, out lDelegate);
  if (lRes <> 0) or (lDelegate = nil) then
    raise new MZException withName("CoreCLR") reason("Failed to get load_assembly_and_get_function_pointer delegate.") userInfo(nil);

  fLoadAssemblyAndGetFunctionPointer := lDelegate;
  lClose(lHandle);
end;

class method MZCoreRuntime.get_sharedInstance: MZCoreRuntime;
begin
  if not assigned(fInstance) then
    raise new MZException withName("MZException") reason("MZCoreRuntime not initialized") userInfo(nil);
  result := fInstance;
end;

method MZCoreRuntime.createDelegate(aAssemblyName, aTypeName, aMethodName: String): ^Void;
begin
  if fLoadAssemblyAndGetFunctionPointer = nil then
    raise new MZException withName("CoreCLR") reason("Runtime not initialized.") userInfo(nil);

  // load_assembly_and_get_function_pointer expects an assembly path. We default to the bridge path,
  // but allow callers to pass a fully qualified path in aAssemblyName when needed.
  var lAssemblyPath: NSString := fBridgeAssemblyPath;
  if (aAssemblyName <> nil) and (aAssemblyName.rangeOfString('/').location <> NSNotFound) then
    lAssemblyPath := aAssemblyName;
  var lAssemblySimpleName := if (aAssemblyName <> nil) and (aAssemblyName.rangeOfString('/').location = NSNotFound) then
                               NSString(aAssemblyName)
                             else
                               lAssemblyPath.lastPathComponent.stringByDeletingPathExtension;
  var lTypeName := if (aTypeName <> nil) and (aTypeName.rangeOfString(',').location <> NSNotFound) then
                     NSString(aTypeName)
                   else
                     NSString.stringWithFormat("%@, %@", aTypeName, lAssemblySimpleName);

  var lFunc: load_assembly_and_get_function_pointer_fn;
  ^^Void(@lFunc)^ := fLoadAssemblyAndGetFunctionPointer;

  // Bridge entry points are exported with [UnmanagedCallersOnly].  For those,
  // hostfxr requires the magic UNMANAGEDCALLERSONLY_METHOD sentinel instead of
  // a managed delegate type name.  Passing nil here asks hostfxr to synthesize a
  // managed delegate and .NET rejects the request with E_INVALIDARG.
  var lUnmanagedCallersOnly := ^AnsiChar(intptr_t(-1));
  var lOut: ^Void := nil;
  var lRes := lFunc(lAssemblyPath.UTF8String, lTypeName.UTF8String, aMethodName.UTF8String, lUnmanagedCallersOnly, nil, out lOut);
  if (lRes <> 0) or (lOut = nil) then
    raise new MZException withName("CoreCLR") reason(NSString.stringWithFormat("Failed to create delegate: %@.%@ (%d)", aTypeName, aMethodName, lRes)) userInfo(nil);
  exit lOut;
end;

method MZCoreRuntime.loadAssembly(aPath: NSString): MZCoreAssembly;
begin
  locking self do begin
    result := fAssemblies.objectForKey(aPath);
    if assigned(result) then exit;
    var lDelegate := createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.RuntimeHelpers", "LoadAssemblyHandle");
    var lFunc: function(aPath: ^Void): ^Void;
    ^^Void(@lFunc)^ := lDelegate;
    var lPathHandle := MZString.NetStringWithNSString(aPath);
    try
      var lException := lFunc(lPathHandle);
      if lException <> nil then
        MZObject.raiseException(lException);
    finally
      MZObject.freeHandle(lPathHandle);
    end;

    result := new MZCoreAssembly withNameAndPath(aPath.lastPathComponent, aPath);
    fAssemblies.setObject(result) forKey(aPath);
  end;
end;

method MZCoreRuntime.runMain;
begin
  // Optionally call a managed entry point via delegate
end;

method MZCoreRuntime.attachToThread;
begin
  // Not required for CoreCLR
end;

method MZCoreRuntime.getType(aFullName: NSString): MZType;
begin
  locking self do begin
    result := fTypes.objectForKey(aFullName);
    if result <> nil then exit;
    // In CoreCLR, type resolution is via managed code
    var lParts := aFullName.componentsSeparatedByString(",");
    var lTypeName := lParts[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet);
    var lAssembly := if lParts.count > 1 then lParts[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet) else "System.Private.CoreLib";
    result := new MZType withTypeName(lTypeName) &assembly(lAssembly);
    fTypes.setObject(result) forKey(aFullName);
  end;
end;

method MZCoreRuntime.getCoreType(aType: NSString; aAssembly: NSString := "System.Private.CoreLib"): MZType;
begin
  exit getType(NSString.stringWithFormat("%@, %@", aType, aAssembly));
end;

// --- Type property getters ---

method MZCoreRuntime.get_object: MZType;
begin
  if fObject = nil then
    fObject := new MZType withTypeName("System.Object") &assembly("System.Private.CoreLib");
  exit fObject;
end;
method MZCoreRuntime.get_string: MZType;
begin
  if fString = nil then
    fString := new MZType withTypeName("System.String") &assembly("System.Private.CoreLib");
  exit fString;
end;
method MZCoreRuntime.get_boolean: MZType;
begin
  if fBoolean = nil then
    fBoolean := new MZType withTypeName("System.Boolean") &assembly("System.Private.CoreLib");
  exit fBoolean;
end;
method MZCoreRuntime.get_byte: MZType;
begin
  if fByte = nil then
    fByte := new MZType withTypeName("System.Byte") &assembly("System.Private.CoreLib");
  exit fByte;
end;
method MZCoreRuntime.get_sbyte: MZType;
begin
  if fSByte = nil then
    fSByte := new MZType withTypeName("System.SByte") &assembly("System.Private.CoreLib");
  exit fSByte;
end;
method MZCoreRuntime.get_int16: MZType;
begin
  if fInt16 = nil then
    fInt16 := new MZType withTypeName("System.Int16") &assembly("System.Private.CoreLib");
  exit fInt16;
end;
method MZCoreRuntime.get_uint16: MZType;
begin
  if fUInt16 = nil then
    fUInt16 := new MZType withTypeName("System.UInt16") &assembly("System.Private.CoreLib");
  exit fUInt16;
end;
method MZCoreRuntime.get_int32: MZType;
begin
  if fInt32 = nil then
    fInt32 := new MZType withTypeName("System.Int32") &assembly("System.Private.CoreLib");
  exit fInt32;
end;
method MZCoreRuntime.get_uint32: MZType;
begin
  if fUInt32 = nil then
    fUInt32 := new MZType withTypeName("System.UInt32") &assembly("System.Private.CoreLib");
  exit fUInt32;
end;
method MZCoreRuntime.get_int64: MZType;
begin
  if fInt64 = nil then
    fInt64 := new MZType withTypeName("System.Int64") &assembly("System.Private.CoreLib");
  exit fInt64;
end;
method MZCoreRuntime.get_uint64: MZType;
begin
  if fUInt64 = nil then
    fUInt64 := new MZType withTypeName("System.UInt64") &assembly("System.Private.CoreLib");
  exit fUInt64;
end;
method MZCoreRuntime.get_single: MZType;
begin
  if fSingle = nil then
    fSingle := new MZType withTypeName("System.Single") &assembly("System.Private.CoreLib");
  exit fSingle;
end;
method MZCoreRuntime.get_double: MZType;
begin
  if fDouble = nil then
    fDouble := new MZType withTypeName("System.Double") &assembly("System.Private.CoreLib");
  exit fDouble;
end;
method MZCoreRuntime.get_intptr: MZType;
begin
  if fIntPtr = nil then
    fIntPtr := new MZType withTypeName("System.IntPtr") &assembly("System.Private.CoreLib");
  exit fIntPtr;
end;
method MZCoreRuntime.get_uintptr: MZType;
begin
  if fUIntPtr = nil then
    fUIntPtr := new MZType withTypeName("System.UIntPtr") &assembly("System.Private.CoreLib");
  exit fUIntPtr;
end;
method MZCoreRuntime.get_char: MZType;
begin
  if fChar = nil then
    fChar := new MZType withTypeName("System.Char") &assembly("System.Private.CoreLib");
  exit fChar;
end;

finalizer MZCoreRuntime;
begin
  // hostfxr does not provide an explicit shutdown path for all scenarios; keep a no-op here.
end;

// --- MZType ---

constructor MZType withTypeName(aTypeName: NSString) &assembly(aAssembly: NSString);
begin
  fTypeName := aTypeName;
  fAssembly := aAssembly;
end;

method MZType.getMethod(aSig: NSString): MZMethod;
begin
  var lDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.TypeHelpers", "GetMethodHandle");
  var lFunc: function(aAssembly: ^Void; aTypeName: ^Void; aSignature: ^Void): ^Void;
  ^^Void(@lFunc)^ := lDelegate;

  var lAssembly := MZString.NetStringWithNSString(fAssembly);
  var lTypeName := MZString.NetStringWithNSString(fTypeName);
  var lSignature := MZString.NetStringWithNSString(aSig);
  try
    var lHandle := lFunc(lAssembly, lTypeName, lSignature);
    if lHandle = nil then
      raise new MZException withName("UnknownMethod") reason(NSString.stringWithFormat('Unknown Method "%@".', aSig)) userInfo(nil);
    result := new MZMethod withHandle(lHandle);
  finally
    MZObject.freeHandle(lAssembly);
    MZObject.freeHandle(lTypeName);
    MZObject.freeHandle(lSignature);
  end;
end;

method MZType.getMethodThunk(aSig: NSString): ^Void;
begin
  // Mono exposes unmanaged thunks. Core uses a managed reflection call-frame instead.
  exit getMethod(aSig).handle;
end;

method MZType.instantiate: ^Void;
begin
  var lDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.TypeHelpers", "InstantiateHandle");
  var lFunc: function(aAssembly: ^Void; aTypeName: ^Void): ^Void;
  ^^Void(@lFunc)^ := lDelegate;

  var lAssembly := MZString.NetStringWithNSString(fAssembly);
  var lTypeName := MZString.NetStringWithNSString(fTypeName);
  try
    result := lFunc(lAssembly, lTypeName);
  finally
    MZObject.freeHandle(lAssembly);
    MZObject.freeHandle(lTypeName);
  end;
end;

// --- MZMethod ---

constructor MZMethod withHandle(aHandle: ^Void);
begin
  if aHandle = nil then exit nil;
  fHandle := aHandle;
end;

finalizer MZMethod;
begin
  if fHandle <> nil then begin
    MZObject.freeHandle(fHandle);
    fHandle := nil;
  end;
end;

// --- MZCallFrame ---

constructor MZCallFrame withMethod(aMethod: MZMethod) target(aTarget: ^Void) argumentCount(aArgumentCount: Integer);
begin
  if fCreateDelegate = nil then
    fCreateDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "Create");
  var lFunc: function(aMethod: ^Void; aTarget: ^Void; aArgumentCount: Integer): ^Void;
  ^^Void(@lFunc)^ := fCreateDelegate;
  fHandle := lFunc(aMethod.handle, aTarget, aArgumentCount);
end;

method MZCallFrame.setObject(aIndex: Integer) value(aValue: ^Void);
begin
  if fSetObjectDelegate = nil then fSetObjectDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetObject");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: ^Void);
  ^^Void(@lFunc)^ := fSetObjectDelegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.setString(aIndex: Integer) value(aValue: ^Void);
begin
  if fSetStringDelegate = nil then fSetStringDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetString");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: ^Void);
  ^^Void(@lFunc)^ := fSetStringDelegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.setBoolean(aIndex: Integer) value(aValue: Boolean);
begin
  if fSetBooleanDelegate = nil then fSetBooleanDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetBoolean");
  // UnmanagedCallersOnly entry points must use blittable argument/result types.
  // C# bool is not blittable, and CoreCLR can fail in the unmanaged-call prestub
  // before the managed bridge body runs. Keep the bridge ABI byte-sized and turn
  // native booleans into an explicit 0/1 payload.
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: Byte);
  ^^Void(@lFunc)^ := fSetBooleanDelegate;
  lFunc(fHandle, aIndex, if aValue then 1 else 0);
end;

method MZCallFrame.setInt32(aIndex: Integer) value(aValue: Int32);
begin
  if fSetI4Delegate = nil then fSetI4Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetI4");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: Int32);
  ^^Void(@lFunc)^ := fSetI4Delegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.setUInt32(aIndex: Integer) value(aValue: UInt32);
begin
  if fSetU4Delegate = nil then fSetU4Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetU4");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: UInt32);
  ^^Void(@lFunc)^ := fSetU4Delegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.setInt64(aIndex: Integer) value(aValue: Int64);
begin
  if fSetI8Delegate = nil then fSetI8Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetI8");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: Int64);
  ^^Void(@lFunc)^ := fSetI8Delegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.setUInt64(aIndex: Integer) value(aValue: UInt64);
begin
  if fSetU8Delegate = nil then fSetU8Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetU8");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: UInt64);
  ^^Void(@lFunc)^ := fSetU8Delegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.setSingle(aIndex: Integer) value(aValue: Single);
begin
  if fSetR4Delegate = nil then fSetR4Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetR4");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: Single);
  ^^Void(@lFunc)^ := fSetR4Delegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.setDouble(aIndex: Integer) value(aValue: Double);
begin
  if fSetR8Delegate = nil then fSetR8Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetR8");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: Double);
  ^^Void(@lFunc)^ := fSetR8Delegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.setIntPtr(aIndex: Integer) value(aValue: intptr_t);
begin
  if fSetIntPtrDelegate = nil then fSetIntPtrDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetIntPtr");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: intptr_t);
  ^^Void(@lFunc)^ := fSetIntPtrDelegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.setDateTime(aIndex: Integer) value(aValue: MZDateTime);
begin
  if fSetDateTimeDelegate = nil then fSetDateTimeDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "SetDateTime");
  var lFunc: procedure(aFrame: ^Void; aIndex: Integer; aValue: MZDateTime);
  ^^Void(@lFunc)^ := fSetDateTimeDelegate;
  lFunc(fHandle, aIndex, aValue);
end;

method MZCallFrame.invoke: ^Void;
begin
  if fInvokeDelegate = nil then fInvokeDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "Invoke");
  var lFunc: function(aFrame: ^Void): ^Void;
  ^^Void(@lFunc)^ := fInvokeDelegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getArgumentObject(aIndex: Integer): ^Void;
begin
  if fGetArgumentObjectDelegate = nil then fGetArgumentObjectDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentObject");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): ^Void;
  ^^Void(@lFunc)^ := fGetArgumentObjectDelegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getArgumentString(aIndex: Integer): ^Void;
begin
  if fGetArgumentStringDelegate = nil then fGetArgumentStringDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentString");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): ^Void;
  ^^Void(@lFunc)^ := fGetArgumentStringDelegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getArgumentBoolean(aIndex: Integer): Boolean;
begin
  if fGetArgumentBooleanDelegate = nil then fGetArgumentBooleanDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentBoolean");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): Byte;
  ^^Void(@lFunc)^ := fGetArgumentBooleanDelegate;
  exit lFunc(fHandle, aIndex) <> 0;
end;

method MZCallFrame.getArgumentInt32(aIndex: Integer): Int32;
begin
  if fGetArgumentI4Delegate = nil then fGetArgumentI4Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentI4");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): Int32;
  ^^Void(@lFunc)^ := fGetArgumentI4Delegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getArgumentUInt32(aIndex: Integer): UInt32;
begin
  if fGetArgumentU4Delegate = nil then fGetArgumentU4Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentU4");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): UInt32;
  ^^Void(@lFunc)^ := fGetArgumentU4Delegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getArgumentInt64(aIndex: Integer): Int64;
begin
  if fGetArgumentI8Delegate = nil then fGetArgumentI8Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentI8");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): Int64;
  ^^Void(@lFunc)^ := fGetArgumentI8Delegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getArgumentUInt64(aIndex: Integer): UInt64;
begin
  if fGetArgumentU8Delegate = nil then fGetArgumentU8Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentU8");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): UInt64;
  ^^Void(@lFunc)^ := fGetArgumentU8Delegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getArgumentSingle(aIndex: Integer): Single;
begin
  if fGetArgumentR4Delegate = nil then fGetArgumentR4Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentR4");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): Single;
  ^^Void(@lFunc)^ := fGetArgumentR4Delegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getArgumentDouble(aIndex: Integer): Double;
begin
  if fGetArgumentR8Delegate = nil then fGetArgumentR8Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentR8");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): Double;
  ^^Void(@lFunc)^ := fGetArgumentR8Delegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getArgumentIntPtr(aIndex: Integer): intptr_t;
begin
  if fGetArgumentIntPtrDelegate = nil then fGetArgumentIntPtrDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentIntPtr");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): intptr_t;
  ^^Void(@lFunc)^ := fGetArgumentIntPtrDelegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getArgumentDateTime(aIndex: Integer): MZDateTime;
begin
  if fGetArgumentDateTimeDelegate = nil then fGetArgumentDateTimeDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetArgumentDateTime");
  var lFunc: function(aFrame: ^Void; aIndex: Integer): MZDateTime;
  ^^Void(@lFunc)^ := fGetArgumentDateTimeDelegate;
  exit lFunc(fHandle, aIndex);
end;

method MZCallFrame.getObjectResult: ^Void;
begin
  if fGetObjectDelegate = nil then fGetObjectDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultObject");
  var lFunc: function(aFrame: ^Void): ^Void;
  ^^Void(@lFunc)^ := fGetObjectDelegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getStringResult: ^Void;
begin
  if fGetStringDelegate = nil then fGetStringDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultString");
  var lFunc: function(aFrame: ^Void): ^Void;
  ^^Void(@lFunc)^ := fGetStringDelegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getBooleanResult: Boolean;
begin
  if fGetBooleanDelegate = nil then fGetBooleanDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultBoolean");
  // See setBoolean: expose booleans across the unmanaged bridge as byte-sized
  // 0/1 values so the CoreCLR callback signature remains blittable.
  var lFunc: function(aFrame: ^Void): Byte;
  ^^Void(@lFunc)^ := fGetBooleanDelegate;
  exit lFunc(fHandle) <> 0;
end;

method MZCallFrame.getInt32Result: Int32;
begin
  if fGetI4Delegate = nil then fGetI4Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultI4");
  var lFunc: function(aFrame: ^Void): Int32;
  ^^Void(@lFunc)^ := fGetI4Delegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getUInt32Result: UInt32;
begin
  if fGetU4Delegate = nil then fGetU4Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultU4");
  var lFunc: function(aFrame: ^Void): UInt32;
  ^^Void(@lFunc)^ := fGetU4Delegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getInt64Result: Int64;
begin
  if fGetI8Delegate = nil then fGetI8Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultI8");
  var lFunc: function(aFrame: ^Void): Int64;
  ^^Void(@lFunc)^ := fGetI8Delegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getUInt64Result: UInt64;
begin
  if fGetU8Delegate = nil then fGetU8Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultU8");
  var lFunc: function(aFrame: ^Void): UInt64;
  ^^Void(@lFunc)^ := fGetU8Delegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getSingleResult: Single;
begin
  if fGetR4Delegate = nil then fGetR4Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultR4");
  var lFunc: function(aFrame: ^Void): Single;
  ^^Void(@lFunc)^ := fGetR4Delegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getDoubleResult: Double;
begin
  if fGetR8Delegate = nil then fGetR8Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultR8");
  var lFunc: function(aFrame: ^Void): Double;
  ^^Void(@lFunc)^ := fGetR8Delegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getIntPtrResult: intptr_t;
begin
  if fGetIntPtrDelegate = nil then fGetIntPtrDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultIntPtr");
  var lFunc: function(aFrame: ^Void): intptr_t;
  ^^Void(@lFunc)^ := fGetIntPtrDelegate;
  exit lFunc(fHandle);
end;

method MZCallFrame.getDateTimeResult: MZDateTime;
begin
  if fGetDateTimeDelegate = nil then fGetDateTimeDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.CallFrameHelpers", "GetResultDateTime");
  var lFunc: function(aFrame: ^Void): MZDateTime;
  ^^Void(@lFunc)^ := fGetDateTimeDelegate;
  exit lFunc(fHandle);
end;

finalizer MZCallFrame;
begin
  if fHandle <> nil then begin
    if fFreeDelegate = nil then fFreeDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "FreeHandle");
    var lFree: procedure(aHandle: ^Void);
    ^^Void(@lFree)^ := fFreeDelegate;
    lFree(fHandle);
    fHandle := nil;
  end;
end;

// --- MZCoreAssembly ---

constructor MZCoreAssembly withNameAndPath(aName, aPath: NSString);
begin
  fName := aName;
  fPath := aPath;
end;

// --- MZObject ---

constructor MZObject withNetInstance(aInstance: ^Void);
begin
  if not assigned(aInstance) then
    exit nil;
  self := inherited init;
  setInstance(aInstance);
  result := self;
end;

finalizer MZObject;
begin
  if fInstance <> nil then begin
    if fFreeHandleDelegate = nil then
      fFreeHandleDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "FreeHandle");
    var lFree: procedure(aHandle: ^Void);
    ^^Void(@lFree)^ := fFreeHandleDelegate;
    lFree(fInstance);
    fInstance := nil;
  end;
end;

method MZObject.setInstance(aInstance: ^Void);
begin
  if fInstance <> nil then begin
    freeHandle(fInstance);
  end;
  fInstance := aInstance;
end;

method MZObject.description: NSString;
begin
  if fDescriptionDelegate = nil then
    fDescriptionDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "ToString");
  var lFunc: function(aInstance: ^Void): ^Void;
  ^^Void(@lFunc)^ := fDescriptionDelegate;
  var lStringHandle := lFunc(fInstance);
  if lStringHandle = nil then exit nil;
  try
    exit MZString.NSStringWithNetString(lStringHandle);
  finally
    freeHandle(lStringHandle);
  end;
end;

method MZObject.&equals(aOther: MZObject): Boolean;
begin
  if fEqualsDelegate = nil then
    fEqualsDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "Equals");
  // Keep the unmanaged callback signature blittable; the managed bridge returns
  // byte-sized 0/1 instead of C# bool.
  var lFunc: function(aInstance: ^Void; aOther: ^Void): Byte;
  ^^Void(@lFunc)^ := fEqualsDelegate;
  exit lFunc(self.__instance, if aOther = nil then nil else aOther.__instance) <> 0;
end;

class method MZObject.raiseException(aEx: ^Void);
begin
  if aEx = nil then
    raise new MZException withName("Exception") reason("Exception") userInfo(nil);

  if fExceptionStringDelegate = nil then
    fExceptionStringDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "ExceptionToString");
  var lFunc: function(aException: ^Void): ^Void;
  ^^Void(@lFunc)^ := fExceptionStringDelegate;

  var lStringHandle := lFunc(aEx);
  var lMessage: NSString := "Exception";
  if lStringHandle <> nil then begin
    try
      lMessage := MZString.NSStringWithNetString(lStringHandle);
    finally
      freeHandle(lStringHandle);
    end;
  end;
  freeHandle(aEx);
  raise new MZException withName("Exception") reason(lMessage) userInfo(nil);
end;

class method MZObject.freeHandle(aHandle: ^Void);
begin
  if aHandle = nil then exit;
  if fFreeHandleDelegate = nil then
    fFreeHandleDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "FreeHandle");
  var lFree: procedure(aHandle: ^Void);
  ^^Void(@lFree)^ := fFreeHandleDelegate;
  lFree(aHandle);
end;

class method MZObject.getTypeCode: MZTypeCode;
begin
  exit MZTypeCode.Other;
end;

class method MZObject.getType: MZType;
begin
  exit MZCoreRuntime.sharedInstance.getCoreType("System.Object");
end;

method MZObject.toType(aType: &Class): id;
begin
  if self.isKindOfClass(aType) then exit self;
  exit aType.alloc.initWithNetInstance(__instance);
end;

class method MZCoreHelpers.forceGarbageCollection: NSString;
begin
  if fForceGarbageCollectionDelegate = nil then
    fForceGarbageCollectionDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "ForceGarbageCollection");

  var lFunc: function: ^Void;
  ^^Void(@lFunc)^ := fForceGarbageCollectionDelegate;

  var lResult := lFunc();
  try
    result := MZString.NSStringWithNetString(lResult);
  finally
    MZObject.freeHandle(lResult);
  end;
end;

class method MZCoreDebugEngineCallbacks.attach(aDebugEngine: ^Void) userData(aUserData: ^Void)
  debugProgress(aDebugProgress: MZDebugProgressCallback)
  threadStarted(aThreadStarted: MZDebugObjectCallback)
  threadFinished(aThreadFinished: MZDebugObjectCallback)
  threadRenamed(aThreadRenamed: MZDebugObjectCallback)
  processTerminated(aProcessTerminated: MZDebugIntCallback)
  processStarted(aProcessStarted: MZDebugVoidCallback)
  processReady(aProcessReady: MZDebugVoidCallback)
  processFailedToStart(aProcessFailedToStart: MZDebugStringCallback)
  log(aLog: MZDebugTwoStringCallback)
  stdOut(aSTDOut: MZDebugStringCallback)
  stdErr(aSTDErr: MZDebugStringCallback)
  breakStop(aBreakStop: MZDebugTwoObjectCallback)
  breakpointResolved(aBreakpointResolved: MZDebugObjectCallback)
  breakpointSignal(aBreakpointSignal: MZDebugObjectStringCallback)
  remoteFileNeeded(aRemoteFileNeeded: MZDebugRemoteFileNeededCallback)
  breakException(aBreakException: MZDebugBreakExceptionCallback)
  disposed(aDisposed: MZDebugVoidCallback)
  moduleLoad(aModuleLoad: MZDebugObjectCallback)
  moduleUnload(aModuleUnload: MZDebugObjectCallback): ^Void;
begin
  if fAttachCallbacksDelegate = nil then
    fAttachCallbacksDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.DebugEngineCallbackHelpers", "AttachCallbacks");

  var lFunc: function(aDebugEngine: ^Void; aUserData: ^Void;
                      aDebugProgress: ^Void;
                      aThreadStarted: ^Void;
                      aThreadFinished: ^Void;
                      aThreadRenamed: ^Void;
                      aProcessTerminated: ^Void;
                      aProcessStarted: ^Void;
                      aProcessReady: ^Void;
                      aProcessFailedToStart: ^Void;
                      aLog: ^Void;
                      aSTDOut: ^Void;
                      aSTDErr: ^Void;
                      aBreakStop: ^Void;
                      aBreakpointResolved: ^Void;
                      aBreakpointSignal: ^Void;
                      aRemoteFileNeeded: ^Void;
                      aBreakException: ^Void;
                      aDisposed: ^Void;
                      aModuleLoad: ^Void;
                      aModuleUnload: ^Void): ^Void;
  ^^Void(@lFunc)^ := fAttachCallbacksDelegate;

  // Procedural variables are stored as native function pointers.  Do not pass
  // @aDebugProgress (or any sibling) to managed code: that is the address of
  // this stack slot, not the executable callback.  CoreCLR will later invoke
  // these callbacks from thread-pool/debugger threads, so a stack-slot address
  // turns into an EXC_BAD_ACCESS jump into another thread's stack.  Dereference
  // the procedural variable storage once and pass the actual entry point.
  var lDebugProgress: ^Void := ^^Void(@aDebugProgress)^;
  var lThreadStarted: ^Void := ^^Void(@aThreadStarted)^;
  var lThreadFinished: ^Void := ^^Void(@aThreadFinished)^;
  var lThreadRenamed: ^Void := ^^Void(@aThreadRenamed)^;
  var lProcessTerminated: ^Void := ^^Void(@aProcessTerminated)^;
  var lProcessStarted: ^Void := ^^Void(@aProcessStarted)^;
  var lProcessReady: ^Void := ^^Void(@aProcessReady)^;
  var lProcessFailedToStart: ^Void := ^^Void(@aProcessFailedToStart)^;
  var lLog: ^Void := ^^Void(@aLog)^;
  var lSTDOut: ^Void := ^^Void(@aSTDOut)^;
  var lSTDErr: ^Void := ^^Void(@aSTDErr)^;
  var lBreakStop: ^Void := ^^Void(@aBreakStop)^;
  var lBreakpointResolved: ^Void := ^^Void(@aBreakpointResolved)^;
  var lBreakpointSignal: ^Void := ^^Void(@aBreakpointSignal)^;
  var lRemoteFileNeeded: ^Void := ^^Void(@aRemoteFileNeeded)^;
  var lBreakException: ^Void := ^^Void(@aBreakException)^;
  var lDisposed: ^Void := ^^Void(@aDisposed)^;
  var lModuleLoad: ^Void := ^^Void(@aModuleLoad)^;
  var lModuleUnload: ^Void := ^^Void(@aModuleUnload)^;

  exit lFunc(aDebugEngine, aUserData,
             lDebugProgress,
             lThreadStarted,
             lThreadFinished,
             lThreadRenamed,
             lProcessTerminated,
             lProcessStarted,
             lProcessReady,
             lProcessFailedToStart,
             lLog,
             lSTDOut,
             lSTDErr,
             lBreakStop,
             lBreakpointResolved,
             lBreakpointSignal,
             lRemoteFileNeeded,
             lBreakException,
             lDisposed,
             lModuleLoad,
             lModuleUnload);
end;

end.
