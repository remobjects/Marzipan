namespace RemObjects.Marzipan;

interface

uses
  Foundation,
  CoreFoundation;

type
  objc_AssociationPolicy = public enum
    (OBJC_ASSOCIATION_ASSIGN = 0,
     OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,
     OBJC_ASSOCIATION_COPY_NONATOMIC = 3,
     OBJC_ASSOCIATION_RETAIN = 01401,
     OBJC_ASSOCIATION_COPY = 01403) of Integer;

  [System.Runtime.InteropServices.DllImport('libobjc.A.dylib')]
  method objc_setAssociatedObject(aObject: id; aKey: ^Void; aValue: id; aPolicy: objc_AssociationPolicy); external;

type
  MZPinnedStringHolder = class(NSObject)
  private
    fHandle: ^Void;
    fReleaser: procedure(aHandle: ^Void);
  public
    // Keeps a pinned managed string alive until the NSString is released.
    // This enables zero-copy UTF-16 bridging for high-volume string traffic.
    constructor withHandle(aHandle: ^Void) releaser(aReleaser: procedure(aHandle: ^Void));
    method dealloc; override;
  end;

type
  MZString = public class(MZObject)
  private
    method get_length: Integer;
    method get_NSString: NSString;
    class var fLengthDelegate, fGetCharsDelegate, fReleaseCharsDelegate, fFromUtf16Delegate: ^Void;
    class var fPinnedKey: IntPtr;
    class var fType: MZType := MZCoreRuntime.sharedInstance.getCoreType("System.String");
  public
    class method getType: MZType; override;
    class method stringWithNSString(s: NSString): MZString;
    class method NetStringWithNSString(s: NSString): ^Void;
    class method NSStringWithNetString(s: ^Void): NSString;

    property length: Integer read get_length;
    property NSString: NSString read get_NSString;
  end;

  MZDateTime = public Int64;

  MZArray = public class(MZObject, sequence of id)
  private
    fNSArray: NSArray;
    fType: &Class;
    class var fCountDelegate, fGetDelegate, fSetDelegate, fToNSArrayDelegate, fFromNSArrayDelegate, fFromStringArrayDelegate: ^Void;
    class var fFreeHandleDelegate: ^Void;
  public
    constructor withNetInstance(aInst: ^Void) elementType(aType: &Class);
    constructor withNSArray(aArray: NSArray);
    constructor withArray(aArray: array of String);
    property &type: &Class read fType;
    property count: NSUInteger read get_count;
    method objectAtIndex(aIndex: Integer): id;
    method objectAtIndexedSubscript(aIndex: Integer): id;
    method setObject(aObject: NSObject) atIndexedSubscript(aValue: Integer);
    method countByEnumeratingWithState(state: ^NSFastEnumerationState) objects(buffer: ^id) count(len: NSUInteger): NSUInteger;
    method NSArray: NSArray;
  private
    method get_count: NSUInteger;
  end;

  MZObjectList = public class(MZObject, INSFastEnumeration)
  private
    // fArray: MZArray; // Reserved for potential cached materialization.
    fNSArray: NSArray;
    fType: &Class;
    class var fCountDelegate, fGetDelegate, fClearDelegate, fToNSArrayDelegate, fFromNSArrayDelegate, fFromObjectDelegate: ^Void;
    class var fFreeHandleDelegate: ^Void;
  public
    property &type: &Class read fType;
    constructor withNSArray(aNSArray: NSArray);
    constructor withObject(aObject: id);
    constructor withNetInstance(aInst: ^Void) elementType(aType: &Class);
    method clear;
    property count: NSUInteger read get_count;
    method objectAtIndex(aIndex: Integer): id;
    method objectAtIndexedSubscript(aIndex: Integer): id;
    method countByEnumeratingWithState(state: ^NSFastEnumerationState) objects(buffer: ^id) count(len: NSUInteger): NSUInteger;
    method NSArray: NSArray;
  private
    method get_count: NSUInteger;
  end;

  RemObjects.Marzipan.Generic.MZObjectList<T> = public class(INSFastEnumeration<T>) mapped to MZObjectList
  where T is class;
  public
    property count: NSUInteger read mapped.count;
    method objectAtIndex(aIndex: Integer): T; mapped to objectAtIndex(aIndex);
    method objectAtIndexedSubscript(aIndex: Integer): T; mapped to objectAtIndexedSubscript(aIndex);
  end;

  NSString_Marzipan_Helpers = public extension class(NSString)
  public
    class method stringwithNetString(s: ^Void): NSString;
    method NetString: ^Void;
  end;

implementation

{ MZPinnedStringHolder }

constructor MZPinnedStringHolder withHandle(aHandle: ^Void) releaser(aReleaser: procedure(aHandle: ^Void));
begin
  fHandle := aHandle;
  fReleaser := aReleaser;
end;

method MZPinnedStringHolder.dealloc;
begin
  if (fHandle <> nil) and assigned(fReleaser) then
    fReleaser(fHandle);
  inherited dealloc;
end;

{ MZString }

class method MZString.getType: MZType;
begin
  exit fType;
end;

method MZString.get_length: Integer;
begin
  if fLengthDelegate = nil then
    fLengthDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.StringHelpers", "GetLength");
  var lFunc: function(aInstance: ^Void): Integer;
  ^^Void(@lFunc)^ := fLengthDelegate;
  result := lFunc(self.__instance);
end;

class method MZString.stringWithNSString(s: NSString): MZString;
begin
  if s = nil then exit nil;
  exit new MZString withNetInstance(NetStringWithNSString(s));
end;

class method MZString.NetStringWithNSString(s: NSString): ^Void;
begin
  if s = nil then exit nil;
  if fFromUtf16Delegate = nil then
    fFromUtf16Delegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.StringHelpers", "FromUTF16");
  var lFunc: function(aChars: ^Void; aLength: Integer): ^Void;
  ^^Void(@lFunc)^ := fFromUtf16Delegate;

  var lLen := s.length;
  if lLen = 0 then begin
    result := lFunc(nil, 0);
    exit;
  end;

  var lPtr := CFStringGetCharactersPtr(s);
  if lPtr <> nil then begin
    result := lFunc(lPtr, lLen);
    exit;
  end;

  var lBuffer := new rtl.UniChar[lLen];
  CFStringGetCharacters(s, CFRangeMake(0, lLen), @lBuffer[0]);
  result := lFunc(@lBuffer[0], lLen);
end;

class method MZString.NSStringWithNetString(s: ^Void): NSString;
begin
  if s = nil then exit nil;
  if fGetCharsDelegate = nil then
    fGetCharsDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.StringHelpers", "GetChars");
  if fReleaseCharsDelegate = nil then
    fReleaseCharsDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.StringHelpers", "ReleaseChars");

  var lGetChars: function(aInstance: ^Void; aOutChars: ^^Void; aOutLength: ^Integer): ^Void;
  var lRelease: procedure(aHandle: ^Void);
  ^^Void(@lGetChars)^ := fGetCharsDelegate;
  ^^Void(@lRelease)^ := fReleaseCharsDelegate;

  var lChars: ^Void := nil;
  var lLen: Integer := 0;
  var lHandle := lGetChars(s, @lChars, @lLen);
  if lHandle = nil then exit nil;
  if (lChars = nil) or (lLen = 0) then begin
    lRelease(lHandle);
    exit '';
  end;

  // Zero-copy: create NSString backed by the pinned UTF-16 buffer.
  // We attach a holder to release the pin when the NSString is deallocated.
  var lStr := NSString.alloc.initWithCharactersNoCopy(^unichar(lChars)) length(lLen) freeWhenDone(false);
  if fPinnedKey = 0 then
    fPinnedKey := IntPtr(^Void(@fPinnedKey));
  var lHolder := new MZPinnedStringHolder withHandle(lHandle) releaser(lRelease);
  objc_setAssociatedObject(lStr, ^Void(fPinnedKey), lHolder, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  result := lStr;
end;

method MZString.get_NSString: NSString;
begin
  exit NSStringWithNetString(self.__instance);
end;

{ MZArray }

constructor MZArray withNetInstance(aInst: ^Void) elementType(aType: &Class);
begin
  self := inherited initWithNetInstance(aInst);
  fType := aType;
  result := self;
end;

constructor MZArray withNSArray(aArray: NSArray);
begin
  if fFromNSArrayDelegate = nil then
    fFromNSArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ArrayHelpers", "FromNSArray");
  var lFunc: function(aNSArray: id): ^Void;
  ^^Void(@lFunc)^ := fFromNSArrayDelegate;
  var lNetArray := lFunc(aArray);
  self := inherited initWithNetInstance(lNetArray);
  fType := typeOf(MZObject); // or infer from array contents
  result := self;
end;

constructor MZArray withArray(aArray: array of String);
begin
  if fFromStringArrayDelegate = nil then
    fFromStringArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ArrayHelpers", "FromStringArray");
  var lFunc: function(aStrings: ^^Void; aCount: Integer): ^Void;
  var lPtrs := new ^Void[aArray.length];
  for i: Integer := 0 to aArray.length-1 do
    lPtrs[i] := MZString.NetStringWithNSString(aArray[i]);
  ^^Void(@lFunc)^ := fFromStringArrayDelegate;
  var lNetArray := lFunc(@lPtrs[0], aArray.length);
  self := inherited initWithNetInstance(lNetArray);
  fType := typeOf(NSString);
  result := self;
end;

method MZArray.objectAtIndex(aIndex: Integer): id;
begin
  if fGetDelegate = nil then
    fGetDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ArrayHelpers", "GetElement");
  var lFunc: function(aArray: ^Void; aIndex: Integer): ^Void;
  ^^Void(@lFunc)^ := fGetDelegate;
  var lItem := lFunc(self.__instance, aIndex);
  if lItem = nil then exit nil;
  if fType = typeOf(NSString) then
  begin
    // Elements returned by the bridge are GCHandles. For NSString we materialize immediately,
    // then free the handle to avoid leaks (the NSString owns its own memory).
    var lStr := MZString.NSStringWithNetString(lItem);
    if fFreeHandleDelegate = nil then
      fFreeHandleDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "FreeHandle");
    var lFree: procedure(aHandle: ^Void);
    ^^Void(@lFree)^ := fFreeHandleDelegate;
    lFree(lItem);
    exit lStr;
  end;
  var lTmp := fType.alloc();
  exit id(lTmp).initWithNetInstance(lItem);
end;

method MZArray.objectAtIndexedSubscript(aIndex: Integer): id;
begin
  result := objectAtIndex(aIndex);
end;

method MZArray.setObject(aObject: NSObject) atIndexedSubscript(aValue: Integer);
begin
  if fSetDelegate = nil then
    fSetDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ArrayHelpers", "SetElement");
  var lFunc: procedure(aArray: ^Void; aIndex: Integer; aValue: ^Void);
  ^^Void(@lFunc)^ := fSetDelegate;
  var lVal: ^Void;
  if fType = typeOf(NSString) then
    lVal := MZString.NetStringWithNSString(NSString(aObject))
  else
    lVal := MZObject(aObject).__instance;
  lFunc(self.__instance, aValue, lVal);
end;

method MZArray.NSArray: NSArray;
begin
  if fNSArray = nil then begin
    if fToNSArrayDelegate = nil then
      fToNSArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ArrayHelpers", "ToNSArray");
    var lFunc: function(aArray: ^Void): id;
    ^^Void(@lFunc)^ := fToNSArrayDelegate;
    fNSArray := Foundation.NSArray(lFunc(self.__instance));
  end;
  result := fNSArray;
end;

method MZArray.countByEnumeratingWithState(state: ^NSFastEnumerationState) objects(buffer: ^id) count(len: NSUInteger): NSUInteger;
begin
  result := NSArray.countByEnumeratingWithState(state) objects(buffer) count(len);
end;

method MZArray.get_count: NSUInteger;
begin
  if fCountDelegate = nil then
    fCountDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ArrayHelpers", "GetCount");
  var lFunc: function(aArray: ^Void): Integer;
  ^^Void(@lFunc)^ := fCountDelegate;
  result := lFunc(self.__instance);
end;

{ MZObjectList }

constructor MZObjectList withNSArray(aNSArray: NSArray);
begin
  if fFromNSArrayDelegate = nil then
    fFromNSArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ListHelpers", "FromNSArray");
  var lFunc: function(aNSArray: id): ^Void;
  ^^Void(@lFunc)^ := fFromNSArrayDelegate;
  var lNetList := lFunc(aNSArray);
  self := inherited initWithNetInstance(lNetList);
  fType := typeOf(MZObject);
  result := self;
end;

constructor MZObjectList withObject(aObject: id);
begin
  if fFromObjectDelegate = nil then
    fFromObjectDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ListHelpers", "FromObject");
  var lFunc: function(aObject: ^Void): ^Void;
  ^^Void(@lFunc)^ := fFromObjectDelegate;
  var lNetList := lFunc(MZObject(aObject).__instance);
  self := inherited initWithNetInstance(lNetList);
  fType := typeOf(MZObject);
  result := self;
end;

constructor MZObjectList withNetInstance(aInst: ^Void) elementType(aType: &Class);
begin
  self := inherited initWithNetInstance(aInst);
  fType := aType;
  result := self;
end;

method MZObjectList.clear;
begin
  if fClearDelegate = nil then
    fClearDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ListHelpers", "Clear");
  var lFunc: procedure(aList: ^Void);
  ^^Void(@lFunc)^ := fClearDelegate;
  lFunc(self.__instance);
end;

method MZObjectList.objectAtIndex(aIndex: Integer): id;
begin
  if fGetDelegate = nil then
    fGetDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ListHelpers", "GetElement");
  var lFunc: function(aList: ^Void; aIndex: Integer): ^Void;
  ^^Void(@lFunc)^ := fGetDelegate;
  var lItem := lFunc(self.__instance, aIndex);
  if lItem = nil then exit nil;
  if fType = typeOf(NSString) then
  begin
    // Same GCHandle ownership rule as arrays: convert then release the handle.
    var lStr := MZString.NSStringWithNetString(lItem);
    if fFreeHandleDelegate = nil then
      fFreeHandleDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ObjectHelpers", "FreeHandle");
    var lFree: procedure(aHandle: ^Void);
    ^^Void(@lFree)^ := fFreeHandleDelegate;
    lFree(lItem);
    exit lStr;
  end;
  var lTmp := fType.alloc();
  exit id(lTmp).initWithNetInstance(lItem);
end;

method MZObjectList.objectAtIndexedSubscript(aIndex: Integer): id;
begin
  result := objectAtIndex(aIndex);
end;

method MZObjectList.countByEnumeratingWithState(state: ^NSFastEnumerationState) objects(buffer: ^id) count(len: NSUInteger): NSUInteger;
begin
  result := NSArray.countByEnumeratingWithState(state) objects(buffer) count(len);
end;

method MZObjectList.get_count: NSUInteger;
begin
  if fCountDelegate = nil then
    fCountDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ListHelpers", "GetCount");
  var lFunc: function(aList: ^Void): Integer;
  ^^Void(@lFunc)^ := fCountDelegate;
  result := lFunc(self.__instance);
end;

method MZObjectList.NSArray: NSArray;
begin
  if fNSArray = nil then begin
    if fToNSArrayDelegate = nil then
      fToNSArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate("RemObjects.Marzipan.Bridge", "RemObjects.Marzipan.Bridge.ListHelpers", "ToNSArray");
    var lFunc: function(aList: ^Void): id;
    ^^Void(@lFunc)^ := fToNSArrayDelegate;
    fNSArray := Foundation.NSArray(lFunc(self.__instance));
  end;
  result := fNSArray;
end;

{ NSString_Marzipan_Helpers }

class method NSString_Marzipan_Helpers.stringwithNetString(s: ^Void): NSString;
begin
  exit MZString.NSStringWithNetString(s);
end;

method NSString_Marzipan_Helpers.NetString: ^Void;
begin
  exit MZString.NetStringWithNSString(self);
end;

end.
