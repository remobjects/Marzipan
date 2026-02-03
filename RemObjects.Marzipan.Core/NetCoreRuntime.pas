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
    fDomainId: Integer;

    fTypes: NSMutableDictionary := new NSMutableDictionary;
    fAssemblies: NSMutableDictionary := new NSMutableDictionary;
    fAssemblyNames: NSMutableDictionary := new NSMutableDictionary;

    method initializeCoreCLR(aDomain, aAppName, aVersion, aLibPath, aEtcPath: NSString);
    method runMain;

  assembly

    method createDelegate(aAssemblyName, aTypeName, aMethodName: String): ^Void;

  public
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString);
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString);
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString) lib(aLibPath: NSString) etc(aETCPath: NSString);

    class property sharedInstance: MZCoreRuntime read get_sharedInstance;

    property version: String read fVersion;
    property hostHandle: ^Void read fHostHandle;
    property domainId: Integer read fDomainId;

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

implementation

constructor MZCoreRuntime withDomain(aDomain: NSString) appName(aAppName: NSString);
begin
  constructor withDomain(aDomain) appName(aAppName) version("v6.0.0");
end;

constructor MZCoreRuntime withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString);
begin
  constructor withDomain(aDomain) appName(aAppName) version(aVersion) lib(nil) etc(nil);
end;

constructor MZCoreRuntime withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString) lib(aLibPath: NSString) etc(aETCPath: NSString);
begin
  if fInstance <> nil then raise new MZException withName("OnlyOneCoreCLR") reason("Only one runtime per class") userInfo(nil);
  fVersion := aVersion;
  fInstance := self;
  initializeCoreCLR(aDomain, aAppName, aVersion, aLibPath, aETCPath);
  runMain();
end;

method MZCoreRuntime.initializeCoreCLR(aDomain, aAppName, aVersion, aLibPath, aEtcPath: NSString);
begin
  // Use coreclr_initialize or hostfxr_initialize_for_runtime_config
  // Store fHostHandle and fDomainId
  // (Implementation depends on your CoreCLR hosting setup)
end;

class method MZCoreRuntime.get_sharedInstance: MZCoreRuntime;
begin
  if not assigned(fInstance) then
    raise new MZException withName("MZException") reason("MZCoreRuntime not initialized") userInfo(nil);
  result := fInstance;
end;

method MZCoreRuntime.createDelegate(aAssemblyName, aTypeName, aMethodName: String): ^Void;
begin
  // Use coreclr_create_delegate or hostfxr equivalent
  // (Implementation depends on your CoreCLR hosting setup)
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
  // coreclr_shutdown if needed
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
  if assigned(aInstance) then
    exit nil;
  setInstance(aInstance);
end;

finalizer MZObject;
begin
  // Release GCHandle or reference if needed
end;

method MZObject.setInstance(aInstance: ^Void);
begin
  fInstance := aInstance;
end;

method MZObject.description: NSString;
begin
  // Use managed bridge to get string representation
end;

method MZObject.&equals(aOther: MZObject): Boolean;
begin
  if fEqualsDelegate = nil then
    fEqualsDelegate := MZCoreRuntime.sharedInstance.createDelegate("MarzipanBridge", "MarzipanBridge.ObjectHelpers", "Equals");
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