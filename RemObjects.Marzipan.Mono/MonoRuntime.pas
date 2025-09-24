namespace RemObjects.Marzipan;

interface

uses
  mono.metadata,
  mono.utils,
  mono.jit,
  Foundation;

type
  MZException = public class(NSException) end;

  MZMonoRuntime = public class
  private
    method object: MZType;
    method string: MZType;
    method boolean: MZType;
    method byte: MZType;
    method sbyte: MZType;
    method int16: MZType;
    method uint16: MZType;
    method int32: MZType;
    method uint32: MZType;
    method int64: MZType;
    method uint64: MZType;
    method single: MZType;
    method _double: MZType;
    method intptr: MZType;
    method uintptr: MZType;
    method _char: MZType;
    class method get_sharedInstance: MZMonoRuntime;
    fVersion: String;
    fObject, fString, fboolean, fbyte, fsbyte, fint16, fuint16, fint32, fuint32, fint64, fuint64, fsingle, fdouble, fintptr, fuintptr, fchar: MZType;
    fDomain: ^MonoDomain;

    fTypes: NSMutableDictionary := new NSMutableDictionary;
    fAssemblies: NSMutableDictionary := new NSMutableDictionary;
    fAssemblyNames: NSMutableDictionary := new NSMutableDictionary;
    class var fInstance: MZMonoRuntime;
    method setupDebugger;
    method runMain;
  public
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString);
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString);
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString) lib(aLibPath: NSString) etc(aETCPath: NSString);

    class property sharedInstance: MZMonoRuntime read get_sharedInstance;

    property version: String read fVersion;

    property domain: ^MonoDomain read fDomain;
    method loadAssembly(aPath: NSString): MZMonoAssembly;
    method getType(aFullName: NSString): MZType;
    method getCoreType(aType: NSString; aAssembly: NSString := 'mscorlib'): MZType;

    method attachToThread;

    property byte: MZType read byte;
    property sbyte: MZType read sbyte;
    property int16: MZType read int16;
    property uint16: MZType read uint16;
    property int32: MZType read int32;
    property uint32: MZType read uint32;
    property int64: MZType read int64;
    property uint64: MZType read uint64;
    property single: MZType read single;
    property _double: MZType read _double;
    property intptr: MZType read intptr;
    property uintptr: MZType read uintptr;
    property _char: MZType read _char;
    property boolean: MZType read boolean;

    property object: MZType read object;
    property string: MZType read string;
    finalizer;
  end;

  MZTypeCode = public enum (Other = 0, &Void = 1, Boolean, Char, I1, U1, I2, U2, I4, U4, I8, U8, R4, R8, I = $18, U = $19);
  MZType = public class
  private
    fType: ^MonoType;
  public
    constructor withType(aType: ^MonoType);
    property &type: ^MonoType read fType;

    method getMethod(aSig: NSString): ^MonoMethod;
    method getMethodThunk(aSig: NSString): ^Void;
    method instantiate: ^MonoObject;
  end;

  MZMonoAssembly = public class
  private
    fAssembly: ^MonoAssembly;
    fName: NSString;
    fImage: ^MonoImage;
    method image: ^MonoImage;
    method assemblyName: NSString;
  public
    class method assemblyNameForImage(aImage: ^MonoImage): NSString;
    constructor &assembly(aAssembly: ^MonoAssembly);

    property &image:^MonoImage read image;
    property &assembly: ^MonoAssembly read fAssembly;
    property assemblyName: NSString read assemblyName;
  end;

  MZObject = public class
  protected
    fInstance: ^MonoObject;
    fHandle: Int32;
    class var fEquals: ^Void;
    method setInstance(aInstance: ^MonoObject);
  public
    class method raiseException(aEx: ^MonoException);
    constructor withMonoInstance(aInstance: ^MonoObject);
    method getClass: ^MonoClass;
    property __instance: ^MonoObject read fInstance write setInstance;
    class method getTypeCode: MZTypeCode; virtual;
    class method getType: MZType; virtual;
    method toType(aType: &Class): id;
    method &equals(aOther: MZObject): Boolean;
    method description: NSString; override;
    finalizer;
  end;

implementation

type MZSystemObjectEqualsMethod = method(o: ^MonoObject): Boolean;

constructor MZMonoRuntime withDomain(aDomain: NSString) appName(aAppName: NSString);
begin
  result := initWithDomain(aDomain) appName(aAppName) version('v4.0.30319');
end;

constructor MZMonoRuntime withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString);
begin
  if fInstance <> nil then raise new MZException withName('OnlyOneMono') reason('Only one runtime per class') userInfo(nil);
  if aVersion[0] = 'v' then
    fVersion := aVersion.substringFromIndex(1)
  else
    fVersion := aVersion;
  fInstance := self;

  setupDebugger();
  fDomain := mono_jit_init_version(aAppName.UTF8String, aVersion.UTF8String);
  mono_config_parse(nil);
  mono_thread_set_main (mono_thread_current ());
  runMain();
end;

constructor MZMonoRuntime withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: NSString) lib(aLibPath: NSString) etc(aETCPath: NSString);
begin
  if fInstance <> nil then raise new MZException  withName('OnlyOneMono') reason('Only one runtime per class') userInfo(nil);
  if aVersion[0] = 'v' then
    fVersion := aVersion.substringFromIndex(1)
  else
    fVersion := aVersion;
  fInstance := self;
  if aLibPath <> nil then begin
    mono_set_dirs(aLibPath.UTF8String, aETCPath.UTF8String);
  end;

  setupDebugger();
  fDomain := mono_jit_init_version(aAppName.UTF8String, aVersion.UTF8String);
  mono_config_parse(nil);
  runMain();
end;

method MZMonoRuntime.setupDebugger;
begin
  var debug := getenv("MARZIPAN_MONO_DEBUG");
  if debug ≠ nil then begin
    NSLog("Entering debug mode with options %s"#10, debug);
    mono_debug_init(MonoDebugFormat.MONO_DEBUG_FORMAT_MONO);
    mono_jit_parse_options(1, @debug);
  end
  else begin
    var option: ^AnsiChar := ' -O=all';
    mono_jit_parse_options(1, @option);
  end;
end;

class method MZMonoRuntime.get_sharedInstance: MZMonoRuntime;
begin
  if not assigned(fInstance) then raise new MZException withName('MZException') reason('MZMonoRuntime not initialized') userInfo(nil);
  result := fInstance;
end;

method MZMonoRuntime.object: MZType;
begin
  if fObject = nil then
    fObject := new MZType withType(mono_get_object_class);
  exit fObject;
end;
method MZMonoRuntime.string: MZType;
begin
  if fString = nil then
    fString := new MZType withType(mono_get_string_class);
  exit fString;
end;

finalizer MZMonoRuntime;
begin
  mono_jit_cleanup(fDomain);
end;

method MZMonoRuntime.loadAssembly(aPath: NSString): MZMonoAssembly;
begin
  locking self do begin
    result := fAssemblies.objectForKey(aPath);
    if assigned(result) then exit;
    var lasm := mono_domain_assembly_open (fDomain, aPath.UTF8String);
    if not assigned(lasm) then raise new MZException withName('CouldNotLoadAssembly') reason(NSString.stringWithFormat('Could not load assembly "%@".', aPath)) userinfo(nil);
    result := new MZMonoAssembly &assembly(lasm);
    fAssemblies.setObject(result) forKey(aPath);
    if fAssemblies.count = 1 then
      mono_assembly_set_main(result.assembly);

    fAssemblyNames.setObject(result) forKey(result.assemblyName);
  end;
end;

method MZMonoRuntime.runMain;
begin
  // This is a no-op method that happens to match the criteria needed for the Mono entry point
  var lTmp: ^MonoMethod := getType("System.Threading.Thread, mscorlib").getMethod(":MemoryBarrier");
  var lPath := new ^AnsiChar[2];
  lPath[0] := "";
  lPath[1] := nil;
  mono_runtime_run_main(lTmp, 1, lPath, nil);
end;

method MZMonoRuntime.attachToThread;
begin
  mono_thread_attach(fDomain);
end;

method MZMonoRuntime.getType(aFullName: NSString): MZType;
begin
  locking self do begin
    result := fTypes.objectForKey(aFullName);
    if result <> nil then exit;
    var ltmp := mono_reflection_type_from_name(aFullName.UTF8String, nil);
    if ltmp = nil then raise new MZException withName('UnknownType') reason(NSString.stringWithFormat('Could not find type "%@".', aFullName)) userinfo(nil);
    result := new MZType withType(ltmp);
    fTypes.setObject(result) forKey(aFullName);
  end;
end;

method MZMonoRuntime.getCoreType(aType: NSString; aAssembly: NSString := 'mscorlib'): MZType;
begin
  //exit getType(NSString.stringWithFormat('%@, %@, Version=%@, Culture=neutral, PublicKeyToken=b77a5c561934e089', aType, aAssembly, fVersion));
  exit getType(NSString.stringWithFormat('%@, %@', aType, aAssembly));
end;

method MZMonoRuntime.boolean: MZType;
begin
  if fboolean = nil then
    fboolean := new MZType withType(mono_get_boolean_class);
  exit fboolean;
end;

method MZMonoRuntime.byte: MZType;
begin
  if fbyte = nil then
    fbyte := new MZType withType(mono_get_byte_class);
  exit fbyte;
end;

method MZMonoRuntime.sbyte: MZType;
begin
  if fsbyte = nil then
    fsbyte := new MZType withType(mono_get_sbyte_class);
  exit fsbyte;
end;

method MZMonoRuntime.int16: MZType;
begin
  if fint16 = nil then
    fint16 := new MZType withType(mono_get_int16_class);
  exit fint16;
end;

method MZMonoRuntime.uint16: MZType;
begin
  if fuint16 = nil then
    fuint16 := new MZType withType(mono_get_uint16_class);
  exit fuint16;
end;

method MZMonoRuntime.int32: MZType;
begin
  if fint32 = nil then
    fint32 := new MZType withType(mono_get_int32_class);
  exit fint32;
end;

method MZMonoRuntime.uint32: MZType;
begin
  if fuint32 = nil then
    fuint32 := new MZType withType(mono_get_uint32_class);
  exit fuint32;
end;

method MZMonoRuntime.int64: MZType;
begin
  if fint64 = nil then
    fint64 := new MZType withType(mono_get_int64_class);
  exit fint64;
end;

method MZMonoRuntime.uint64: MZType;
begin
  if fuint64 = nil then
    fuint64 := new MZType withType(mono_get_uint64_class);
  exit fuint64;
end;

method MZMonoRuntime.single: MZType;
begin
  if fsingle = nil then
    fsingle := new MZType withType(mono_get_single_class);
  exit fsingle;
end;

method MZMonoRuntime._double: MZType;
begin
  if fdouble = nil then
    fdouble := new MZType withType(mono_get_double_class);
  exit fdouble;
end;

method MZMonoRuntime.intptr: MZType;
begin
  if fintptr = nil then
    fintptr := new MZType withType(mono_get_intptr_class);
  exit fintptr;
end;

method MZMonoRuntime.uintptr: MZType;
begin
  if fuintptr = nil then
    fuintptr := new MZType withType(mono_get_uintptr_class);
  exit fuintptr;
end;

method MZMonoRuntime._char: MZType;
begin
  if fchar = nil then
    fchar := new MZType withType(mono_get_char_class);
  exit fchar;
end;

constructor MZMonoAssembly &assembly(aAssembly: ^MonoAssembly);
begin
  fAssembly := aAssembly;
end;

method MZMonoAssembly.image: ^MonoImage;
begin
  if fImage = nil then
    fImage := mono_assembly_get_image(fAssembly);
  exit fImage;
end;

method MZMonoAssembly.assemblyName: NSString;
begin
  if fName = nil then begin
    fName := assemblyNameForImage(image);
  end;
  exit fName;
end;

class method MZMonoAssembly.assemblyNameForImage(aImage: ^MonoImage): NSString;
begin
  var lName := mono_image_get_name(aImage);
  result := NSString.stringWithUTF8String(lName);
end;

constructor MZObject withMonoInstance(aInstance: ^MonoObject);
begin
  if not assigned(aInstance) then
    exit nil;
  setInstance(aInstance);
end;

finalizer MZObject;
begin
  mono_gchandle_free(fHandle);
end;

method MZObject.getClass: ^MonoClass;
begin
  exit mono_object_get_class(fInstance);
end;

method MZObject.description: NSString;
begin
  var mcs := mono_object_to_string(fInstance, nil);
  if mcs = nil then exit nil;
  exit NSString.stringWithCharacters(^unichar(mono_string_chars(mcs))) length(mono_string_length(mcs)) ;
end;

method MZObject.&equals(aOther: MZObject): Boolean;
begin
  if fEquals = nil then
    fEquals := MZMonoRuntime.sharedInstance.object.getMethodThunk('System.Object:Equals(System.Object)');
  var lEquals: MZSystemObjectEqualsMethod;
  ^^Void(@lEquals)^ := fEquals;
  exit lEquals(if aOther = nil then nil else aOther.__instance);
end;

class method MZObject.raiseException(aEx: ^MonoException);
begin
  var mcs := mono_object_to_string(^MonoObject(aEx), nil);
  var lMsg: NSString := 'Exception';
  if mcs <> nil then
    lMsg := NSString.stringWithCharacters(^unichar(mono_string_chars(mcs))) length(mono_string_length(mcs));

  raise new MZException withName('Exception') reason(lMsg) userInfo(nil);
end;

class method MZObject.getTypeCode: MZTypeCode;
begin
  exit MZTypeCode.Other;
end;

class method MZObject.getType: MZType;
begin
  exit MZMonoRuntime.sharedInstance.getCoreType('System.Object');
end;

method MZObject.toType(aType: &Class): id;
begin
  if self.isKindOfClass(aType) then exit self;
  exit aType.alloc.initWithMonoInstance(__instance);
end;

method MZObject.setInstance(aInstance: ^MonoObject);
begin
  if fInstance <> nil then
    mono_gchandle_free(fHandle);
  fHandle := mono_gchandle_new(aInstance, 1);
  fInstance := aInstance;
end;

constructor MZType withType(aType: ^MonoType);
begin
  fType := aType;
end;

method MZType.getMethod(aSig: NSString): ^MonoMethod;
begin
  var lSec := mono_method_desc_new(aSig.UTF8String, 1);
  result := mono_method_desc_search_in_class(lSec, mono_class_from_mono_type(fType));
  mono_method_desc_free(lSec);
  if result = nil then begin
    {$IFDEF DEBUG}
    var cl := mono_class_from_mono_type(fType);
    var iter: ^Void := nil;
    var lErr := new NSMutableString withCapacity(1024);
    loop begin
      var m := mono_class_get_methods(cl, @iter);
      if m = nil then break; // done
      var mn := mono_method_full_name(m, 1);
      lErr.appendFormat('%@'#10, String(NSString.stringWithCString(mn) encoding(NSStringEncoding.NSUTF8StringEncoding)));
    end;
    raise new NSException withName('UnknownMethod') reason (NSString.stringWithFormat('Unknown Method "%@". '#10'Possibilities:'#10'%@', aSig, lErr)) userInfo(nil);
    {$ELSE}
    raise new NSException withName('UnknownMethod') reason (NSString.stringWithFormat('Unknown Method "%@".', aSig)) userInfo(nil);
    {$ENDIF}
  end;
end;

method MZType.getMethodThunk(aSig: NSString): ^Void;
begin
  var lMethod := getMethod(aSig);
  result := mono_method_get_unmanaged_thunk(lMethod);
  if not assigned(result) then
    raise new NSException withName('BadMethod') reason (NSString.stringWithFormat('Could not obtain thunk for method "%@".', aSig)) userInfo(nil);
end;

method MZType.instantiate: ^MonoObject;
begin
  exit mono_object_new(MZMonoRuntime.sharedInstance.domain, mono_class_from_mono_type(fType));
end;


end.