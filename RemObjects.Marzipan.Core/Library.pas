namespace RemObjects.Marzipan;

interface

uses
  Foundation;

type
  MZString = public class(MZObject)
  private
    method get_length: Integer;
    method get_NSString: NSString;
    class var fLengthDelegate: IntPtr;
    class var fType: MZType := MZCoreRuntime.sharedInstance.getCoreType('System.String');
  public
    class method getType: MZType; override;
    class method stringWithNSString(s: NSString): MZString;
    class method NetStringWithNSString(s: NSString): IntPtr;
    class method NSStringWithNetString(s: IntPtr): NSString;

    property length: Integer read get_length;
    property NSString: NSString read get_NSString;
  end;

  MZDateTime = public Int64;

  MZArray = public class(MZObject, sequence of id)
  private
    fNSArray: NSArray;
    fType: &Class;
    class var fCountDelegate, fGetDelegate, fSetDelegate, fToNSArrayDelegate, fFromNSArrayDelegate, fFromStringArrayDelegate: IntPtr;
  public
    constructor withNetInstance(aInst: IntPtr) elementType(aType: &Class);
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
    fArray: MZArray;
    fNSArray: NSArray;
    fType: &Class;
    class var fCountDelegate, fGetDelegate, fClearDelegate, fToNSArrayDelegate, fFromNSArrayDelegate, fFromObjectDelegate: IntPtr;
  public
    property &type: &Class read fType;
    constructor withNSArray(aNSArray: NSArray);
    constructor withObject(aObject: id);
    constructor withNetInstance(aInst: IntPtr) elementType(aType: &Class);
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
    class method stringwithNetString(s: IntPtr): NSString;
    method NetString: IntPtr;
  end;

implementation

{ MZString }

class method MZString.getType: MZType;
begin
  exit fType;
end;

method MZString.get_length: Integer;
begin
  if fLengthDelegate = nil then
    fLengthDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.StringHelpers', 'GetLength');
  var lFunc: function(aInstance: IntPtr): Integer;
  ^^Void(@lFunc)^ := fLengthDelegate;
  result := lFunc(self.__instance);
end;

class method MZString.stringWithNSString(s: NSString): MZString;
begin
  if s = nil then exit nil;
  exit new MZString withNetInstance(NetStringWithNSString(s));
end;

class method MZString.NetStringWithNSString(s: NSString): IntPtr;
begin
  var lDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.StringHelpers', 'FromNSString');
  var lFunc: function(aNSString: IntPtr): IntPtr;
  ^^Void(@lFunc)^ := lDelegate;
  result := lFunc(IntPtr(s));
end;

class method MZString.NSStringWithNetString(s: IntPtr): NSString;
begin
  if s = nil then exit nil;
  var lDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.StringHelpers', 'ToNSString');
  var lFunc: function(aNetString: IntPtr): IntPtr;
  ^^Void(@lFunc)^ := lDelegate;
  result := NSString(lFunc(s));
end;

method MZString.get_NSString: NSString;
begin
  exit NSStringWithNetString(self.__instance);
end;

{ MZArray }

constructor MZArray withNetInstance(aInst: IntPtr) elementType(aType: &Class);
begin
  self := inherited withNetInstance(aInst);
  fType := aType;
  result := self;
end;

constructor MZArray withNSArray(aArray: NSArray);
begin
  if fFromNSArrayDelegate = nil then
    fFromNSArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ArrayHelpers', 'FromNSArray');
  var lFunc: function(aNSArray: IntPtr): IntPtr;
  ^^Void(@lFunc)^ := fFromNSArrayDelegate;
  var lNetArray := lFunc(IntPtr(aArray));
  self := inherited withNetInstance(lNetArray);
  fType := typeOf(MZObject); // or infer from array contents
  result := self;
end;

constructor MZArray withArray(aArray: array of String);
begin
  if fFromStringArrayDelegate = nil then
    fFromStringArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ArrayHelpers', 'FromStringArray');
  var lFunc: function(aStrings: ^IntPtr; aCount: Integer): IntPtr;
  var lPtrs := new IntPtr[aArray.Length];
  for i: Integer := 0 to aArray.Length-1 do
    lPtrs[i] := MZString.NetStringWithNSString(aArray[i]);
  ^^Void(@lFunc)^ := fFromStringArrayDelegate;
  var lNetArray := lFunc(@lPtrs[0], aArray.Length);
  self := inherited withNetInstance(lNetArray);
  fType := typeOf(NSString);
  result := self;
end;

method MZArray.objectAtIndex(aIndex: Integer): id;
begin
  if fGetDelegate = nil then
    fGetDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ArrayHelpers', 'GetElement');
  var lFunc: function(aArray: IntPtr; aIndex: Integer): IntPtr;
  ^^Void(@lFunc)^ := fGetDelegate;
  var lItem := lFunc(self.__instance, aIndex);
  if lItem = nil then exit nil;
  if fType = typeOf(NSString) then
    exit MZString.NSStringWithNetString(lItem);
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
    fSetDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ArrayHelpers', 'SetElement');
  var lFunc: procedure(aArray: IntPtr; aIndex: Integer; aValue: IntPtr);
  ^^Void(@lFunc)^ := fSetDelegate;
  var lVal: IntPtr;
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
      fToNSArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ArrayHelpers', 'ToNSArray');
    var lFunc: function(aArray: IntPtr): IntPtr;
    ^^Void(@lFunc)^ := fToNSArrayDelegate;
    fNSArray := NSArray(lFunc(self.__instance));
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
    fCountDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ArrayHelpers', 'GetCount');
  var lFunc: function(aArray: IntPtr): Integer;
  ^^Void(@lFunc)^ := fCountDelegate;
  result := lFunc(self.__instance);
end;

{ MZObjectList }

constructor MZObjectList withNSArray(aNSArray: NSArray);
begin
  if fFromNSArrayDelegate = nil then
    fFromNSArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ListHelpers', 'FromNSArray');
  var lFunc: function(aNSArray: IntPtr): IntPtr;
  ^^Void(@lFunc)^ := fFromNSArrayDelegate;
  var lNetList := lFunc(IntPtr(aNSArray));
  self := inherited withNetInstance(lNetList);
  fType := typeOf(MZObject);
  result := self;
end;

constructor MZObjectList withObject(aObject: id);
begin
  if fFromObjectDelegate = nil then
    fFromObjectDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ListHelpers', 'FromObject');
  var lFunc: function(aObject: IntPtr): IntPtr;
  ^^Void(@lFunc)^ := fFromObjectDelegate;
  var lNetList := lFunc(MZObject(aObject).__instance);
  self := inherited withNetInstance(lNetList);
  fType := typeOf(MZObject);
  result := self;
end;

constructor MZObjectList withNetInstance(aInst: IntPtr) elementType(aType: &Class);
begin
  self := inherited withNetInstance(aInst);
  fType := aType;
  result := self;
end;

method MZObjectList.clear;
begin
  if fClearDelegate = nil then
    fClearDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ListHelpers', 'Clear');
  var lFunc: procedure(aList: IntPtr);
  ^^Void(@lFunc)^ := fClearDelegate;
  lFunc(self.__instance);
end;

method MZObjectList.objectAtIndex(aIndex: Integer): id;
begin
  if fGetDelegate = nil then
    fGetDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ListHelpers', 'GetElement');
  var lFunc: function(aList: IntPtr; aIndex: Integer): IntPtr;
  ^^Void(@lFunc)^ := fGetDelegate;
  var lItem := lFunc(self.__instance, aIndex);
  if lItem = nil then exit nil;
  if fType = typeOf(NSString) then
    exit MZString.NSStringWithNetString(lItem);
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
    fCountDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ListHelpers', 'GetCount');
  var lFunc: function(aList: IntPtr): Integer;
  ^^Void(@lFunc)^ := fCountDelegate;
  result := lFunc(self.__instance);
end;

method MZObjectList.NSArray: NSArray;
begin
  if fNSArray = nil then begin
    if fToNSArrayDelegate = nil then
      fToNSArrayDelegate := MZCoreRuntime.sharedInstance.createDelegate('MarzipanBridge', 'MarzipanBridge.ListHelpers', 'ToNSArray');
    var lFunc: function(aList: IntPtr): IntPtr;
    ^^Void(@lFunc)^ := fToNSArrayDelegate;
    fNSArray := NSArray(lFunc(self.__instance));
  end;
  result := fNSArray;
end;

{ NSString_Marzipan_Helpers }

class method NSString_Marzipan_Helpers.stringwithNetString(s: IntPtr): NSString;
begin
  exit MZString.NSStringWithNetString(s);
end;

method NSString_Marzipan_Helpers.NetString: IntPtr;
begin
  exit MZString.NetStringWithNSString(self);
end;

end.