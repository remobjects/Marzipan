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

    method getMethod(aSig: NSString): ^Void;
    method getMethodThunk(aSig: NSString): ^Void;
    method instantiate: ^Void;
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
    class var fEqualsDelegate: ^Void;
    method setInstance(aInstance: ^Void);
  public
    class method raiseException(aEx: ^Void);
    constructor withNetInstance(aInstance: ^Void);
    property __instance: ^Void read fInstance write setInstance;
    class method getTypeCode: MZTypeCode; virtual;
    class method getType: MZType; virtual;
    method toType(aType: &Class): id;
    method &equals(aOther: MZObject): Boolean;
    method description: NSString; override;
    finalizer;
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

  var lFunc: load_assembly_and_get_function_pointer_fn;
  ^^Void(@lFunc)^ := fLoadAssemblyAndGetFunctionPointer;

  var lOut: ^Void := nil;
  var lRes := lFunc(lAssemblyPath.UTF8String, aTypeName.UTF8String, aMethodName.UTF8String, nil, nil, out lOut);
  if (lRes <> 0) or (lOut = nil) then
    raise new MZException withName("CoreCLR") reason(NSString.stringWithFormat("Failed to create delegate: %@.%@ (%d)", aTypeName, aMethodName, lRes)) userInfo(nil);
  exit lOut;
end;

method MZCoreRuntime.loadAssembly(aPath: NSString): MZCoreAssembly;
begin
  locking self do begin
    result := fAssemblies.objectForKey(aPath);
    if assigned(result) then exit;
    // In CoreCLR, assemblies are loaded via managed code
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

method MZType.getMethod(aSig: NSString): ^Void;
begin
  // Use managed bridge to resolve method
end;

method MZType.getMethodThunk(aSig: NSString): ^Void;
begin
  // Use managed bridge to get unmanaged thunk
end;

method MZType.instantiate: ^Void;
begin
  // Use managed bridge to instantiate object
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
  setInstance(aInstance);
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
    if fFreeHandleDelegate = nil then
      fFreeHandleDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "FreeHandle");
    var lFree: procedure(aHandle: ^Void);
    ^^Void(@lFree)^ := fFreeHandleDelegate;
    lFree(fInstance);
  end;
  fInstance := aInstance;
end;

method MZObject.description: NSString;
begin
  // Use managed bridge to get string representation
end;

method MZObject.&equals(aOther: MZObject): Boolean;
begin
  if fEqualsDelegate = nil then
    fEqualsDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "Equals");
  var lFunc: function(aInstance: ^Void; aOther: ^Void): Boolean;
  ^^Void(@lFunc)^ := fEqualsDelegate;
  exit lFunc(self.__instance, if aOther = nil then nil else aOther.__instance);
end;

class method MZObject.raiseException(aEx: ^Void);
begin
  // Use managed bridge to get exception string and raise NSException
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

end.