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
    fObject, fString: MZType;
    fDomain: ^MonoDomain;

    fTypes: NSMutableDictionary := new NSMutableDictionary;
    fAssemblies: NSMutableDictionary := new NSMutableDictionary;
    fAssemblyNames: NSMutableDictionary := new NSMutableDictionary;
    class var fInstance: MZMonoRuntime;
  public
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: String := 'v4.0.30319');
    constructor withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: String := 'v4.0.30319') lib(aLibPath: NSString) etc(aETCPath: NSString);

    class property Instance: MZMonoRuntime read fInstance;
    

    property domain: ^MonoDomain read fDomain;
    method loadAssembly(aPath: NSString): MZMonoAssembly; 
    method getType(aFullName: NSString): MZType;

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
    method Instantiate: ^MonoObject;
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
  private
    fInstance: ^MonoObject;
    fHandle: Int32;
    class var fEquals: ^Void;
  public
    class method raiseException(aEx: ^MonoException);
    constructor withMonoInstance(aInstance: ^MonoObject);
    method getType: ^MonoType;
    property instance: ^MonoObject read fInstance;
    class method getTypeCode: MZTypeCode; virtual;
    class method getType: MZType; virtual;
    method &equals(aOther: MZObject): Boolean;
    method description: NSString; override;
    finalizer;
  end;

implementation

type __system_object_equals_method = method(o: ^MonoObject): Boolean;

constructor MZMonoRuntime withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: String := 'v4.0.30319');
begin
  if fInstance <> nil then raise new MZException  withName('OnlyOneMono') reason('Only one runtime per class') userInfo(nil);
  fInstance := self;
  fDomain := mono_jit_init_version(aAppName.UTF8String, aVersion.UTF8String);
  mono_config_parse(nil);
  mono_thread_set_main (mono_thread_current ());
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

constructor MZMonoRuntime withDomain(aDomain: NSString) appName(aAppName: NSString) version(aVersion: String) lib(aLibPath: NSString) etc(aETCPath: NSString);
begin
  if fInstance <> nil then raise new MZException  withName('OnlyOneMono') reason('Only one runtime per class') userInfo(nil);
  fInstance := self;
  if aLibPath <> nil then begin
    mono_set_dirs(aLibPath.UTF8String, aETCPath.UTF8String);
  end;
  
  fDomain := mono_jit_init_version(aAppName.UTF8String, aVersion.UTF8String);
  mono_config_parse(nil);
end;

method MZMonoRuntime.loadAssembly(aPath: NSString): MZMonoAssembly;
begin
  locking self do begin
    result := fAssemblies.objectForKey(aPath);
    if assigned(result) then exit;
    var lasm := mono_domain_assembly_open (fDomain, aPath);
    if lasm = nil then raise new MZException('CouldNotLoadAssembly') reason('Could not load assembly') userinfo(nil);
    result := new MZMonoAssembly &assembly(lasm);
    fAssemblies.setObject(result) forKey(aPath);
    if fAssemblies.count = 1 then
      mono_assembly_set_main(result.assembly);

    fAssemblyNames.setObject(result) forKey(result.assemblyName);
  end;
end;

method MZMonoRuntime.getType(aFullName: NSString): MZType;
begin
  locking self do begin
    result := fTypes.objectForKey(aFullName);
    if result <> nil then exit;
    var ltmp := mono_reflection_type_from_name(aFullName, nil);
    if ltmp = nil then raise new MZException('UnknownType') reason('Could not find type') userinfo(nil);
    result := new MZType withType(ltmp);
    fTypes.setObject(result) forKey(aFullName); 
  end;
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
  fHandle := mono_gchandle_new(aInstance, 0);
  fInstance := aInstance;
end;

finalizer MZObject;
begin
  mono_gchandle_free(fHandle);
end;

method MZObject.getType: ^MonoType;
begin
  exit mono_object_get_class(fInstance);
end;

method MZObject.description: NSString;
begin
  var mcs := mono_object_to_string(fInstance, nil);
  if mcs = nil then exit nil;
  exit nsstring.stringWithCharacters(^unichar(mono_string_chars(mcs))) length(mono_string_length(mcs)) ;
end;

method MZObject.&equals(aOther: MZObject): Boolean;
begin
  if fEquals = nil then
    fEquals := MZMonoRuntime.Instance.object.getMethodThunk('System.Object:Equals(System.Object)');
  var lEquals: __system_object_equals_method;
  ^^Void(@lEquals)^ := fEquals;
  exit lEquals(if aOther = nil then nil else aOther.instance);
end;

class method MZObject.raiseException(aEx: ^MonoException);
begin
  var mcs := mono_object_to_string(^MonoObject(aEx), nil);
  var lMsg: NSString := 'Exception';
  if mcs <> nil then 
    lMsg := nsstring.stringWithCharacters(^unichar(mono_string_chars(mcs))) length(mono_string_length(mcs));
  
  raise new MZException withName('Exception') reason(lMsg) userInfo(nil);
end;

class method MZObject.getTypeCode: MZTypeCode;
begin
  exit MZTypeCode.Other;
end;

class method MZObject.getType: MZType;
begin
  exit MZMonoRuntime.Instance.getType('System.Object, mscorlib');
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
  if result = nil then raise new NSException withName('UnknownMethod') reason ('Unknown Method') userInfo(nil);
end;

method MZType.getMethodThunk(aSig: NSString): ^Void;
begin
  exit mono_method_get_unmanaged_thunk(getMethod(aSig));
end;

method MZType.Instantiate: ^MonoObject;
begin
  exit mono_object_new(MZMonoRuntime.Instance.domain, mono_class_from_mono_type(fType));
end;


end.
