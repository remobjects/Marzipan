namespace RemObjects.Marzipan;

interface

uses
  mono.utils,
  mono.jit,
  mono.metadata,
  Foundation;

type
  MZString = public class(MZObject)
  private
    method get_length: Integer;
    method get_NSString: NSString;
    class var fLength: method(aInstance: ^MonoObject; aEx: ^^MonoException): Integer;
    class var fType: MZType := MZMonoRuntime.sharedInstance.getCoreType('System.String');
  public
    class method getType: MZType; override;
    class method stringWithNSString(s: NSString): MZString;
    class method MonoStringWithNSString(s: NSString): ^MonoString;
    class method NSStringWithMonoString(s: ^MonoString): NSString;

    property length: Integer read get_length;
    property NSString: NSString read get_NSString;
  end;

  MZDateTime = public int64_t;

  MZArray = public class(MZObject, sequence of id)
  private
    fNSArray: NSArray;
  public
    constructor withMonoInstance(aInst: ^MonoObject) elementType(aType: &Class);
    constructor withNSArray(aArray: NSArray);
    //constructor withArray<T>(aArray: array of T);
    constructor withArray(aArray: array of String);
    property &type: &Class := typeOf(MZObject);
    property elements: ^^MonoObject read ^^MonoObject(mono_array_addr_with_size(^MonoArray(__instance), sizeOf(^MonoObject), 0));
    property count: NSUInteger read mono_array_length(^MonoArray(__instance));
    property «Count»: NSUInteger read count;
    property Length: NSUInteger read count;
    method objectAtIndex(aIndex: Integer): id;
    method objectAtIndexedSubscript(aIndex: Integer): id;
    method setObject(aObject: NSObject) atIndexedSubscript(aValue: Integer);
    method countByEnumeratingWithState(state: ^NSFastEnumerationState) objects(buffer: ^id) count(len: NSUInteger): NSUInteger;
    method NSArray: NSArray;
  end;

  MZObjectList = public class(MZObject, INSFastEnumeration)
  assembly
    fSize: ^Int32;
    fItems: ^^MonoArray;
    fLastItems: ^MonoArray;
    fArray: MZArray;
    fNSArray: NSArray;

    class var fSizeField: ^MonoClassField;
    class var fItemsField: ^MonoClassField;
    method get_count: NSUInteger;
  public
    property &type: &Class := typeOf(MZObject);
    constructor withNSArray(aNSArray: NSArray);
    constructor withObject(aObject: id);
    constructor withMonoInstance(aInst: ^MonoObject) elementType(aType: &Class);
    method clear;
    property count: NSUInteger read get_count;
    property «Count»: NSUInteger read count;
    method objectAtIndex(aIndex: Integer): id;
    method objectAtIndexedSubscript(aIndex: Integer): id;
    method countByEnumeratingWithState(state: ^NSFastEnumerationState) objects(buffer: ^id) count(len: NSUInteger): NSUInteger;
    method NSArray: NSArray;
  end;

  RemObjects.Marzipan.Generic.MZObjectList<T> = public class(INSFastEnumeration<T>) mapped to MZObjectList
    where T is class;
  public
    property count: NSUInteger read mapped.count;
    //property «Count»: NSUInteger read count;
    method objectAtIndex(aIndex: Integer): T; mapped to objectAtIndex(aIndex);
    method objectAtIndexedSubscript(aIndex: Integer): T; mapped to objectAtIndexedSubscript(aIndex);
  end;

  NSString_Marzipan_Helpers = public extension class(NSString)
  public
    class method stringwithMonoString(s: ^MonoString): NSString;
    method MonoString: ^MonoString;
  end;

implementation

{ MZString }

class method MZString.getType: MZType;
begin
  exit fType;
end;

method MZString.get_length: Integer;
begin
  if fLength = nil then
    ^^Void(@fLength)^ := fType.getMethodThunk(':get_Length()');
  var ex: ^MonoException := nil;
  result := fLength(__instance, @ex);
  if ex <> nil then raiseException(ex);
end;

class method MZString.stringWithNSString(s: NSString): MZString;
begin
  if s = nil then exit nil;
  exit new MZString withMonoInstance(^MonoObject(mono_string_from_utf16(^mono_unichar2(s.cStringUsingEncoding(NSStringEncoding.NSUnicodeStringEncoding)))));
end;

method MZString.get_NSString: NSString;
begin
  exit Foundation.NSString.stringWithCharacters(^unichar(mono_string_chars(^MonoString(__instance)))) length(mono_string_length(^MonoString(__instance)));
end;

class method MZString.NSStringWithMonoString(s: ^MonoString): NSString;
begin
  if s = nil then exit nil;
  exit Foundation.NSString.stringWithCharacters(^unichar(mono_string_chars(^MonoString(s)))) length(mono_string_length(^MonoString(s)));
end;

class method MZString.MonoStringWithNSString(s: NSString): ^MonoString;
begin
  if s = nil then exit nil;
  exit mono_string_new_wrapper(s.cStringUsingEncoding(NSStringEncoding.NSUTF8StringEncoding));
end;

class method NSString_Marzipan_Helpers.stringwithMonoString(s: ^MonoString): NSString;
begin
  if s = nil then exit nil;
  exit Foundation.NSString.stringWithCharacters(^unichar(mono_string_chars(^MonoString(s)))) length(mono_string_length(^MonoString(s)));
end;

method NSString_Marzipan_Helpers.MonoString: ^MonoString;
begin
  if self = nil then exit nil;
  exit mono_string_from_utf16(^mono_unichar2(self.cStringUsingEncoding(NSStringEncoding.NSUnicodeStringEncoding)));
end;

{ MZArray }

constructor MZArray withMonoInstance(aInst: ^MonoObject) elementType(aType: &Class);
begin
  self := inherited initWithMonoInstance(aInst);
  if assigned(self) then begin
    &type := aType;
  end;
  result := self;
end;

constructor MZArray withNSArray(aArray: NSArray);
begin
  if aArray.count > 0 then begin
    self := inherited initWithMonoInstance(mono_array_new(MZMonoRuntime.sharedInstance.domain, (aArray[0] as MZObject).getClass(), aArray.count) as ^MonoObject);
    for i: Integer := 0 to aArray.count-1 do begin
      var lInst := MZObject(aArray[i]):__instance;
      elements[i] := lInst;
    end;
  end
  else begin
    self := inherited initWithMonoInstance(mono_array_new(MZMonoRuntime.sharedInstance.domain, mono_class_from_mono_type(MZMonoRuntime.sharedInstance.getCoreType('System.Object').type), 0) as ^MonoObject);
  end;
end;

//constructor MZArray withArray<T>(aArray: array of T);
//begin
  //if length(aArray) > 0 then begin
    //self := inherited initWithMonoInstance(mono_array_new(MZMonoRuntime.sharedInstance.domain, (aArray[0] as MZObject).getClass(), length(aArray)) as ^MonoObject);
    //for i: Integer := 0 to length(aArray)-1 do begin
      //var lInst := MZObject(aArray[i]):__instance;
      //elements[i] := lInst;
    //end;
  //end
  //else begin
    //self := inherited initWithMonoInstance(mono_array_new(MZMonoRuntime.sharedInstance.domain, mono_class_from_mono_type(MZMonoRuntime.sharedInstance.getCoreType('System.Object').type), 0) as ^MonoObject);
  //end;
//end;

constructor MZArray withArray(aArray: array of String);
begin
  self := inherited initWithMonoInstance(mono_array_new(MZMonoRuntime.sharedInstance.domain, mono_class_from_mono_type(MZString.getType.type), RemObjects.Elements.System.length(aArray)) as ^MonoObject);
  for i: Integer := 0 to RemObjects.Elements.System.length(aArray)-1 do begin
    var lInst := MZString.MonoStringWithNSString(aArray[i]) as ^MonoObject;
    elements[i] := lInst;
  end;
end;

method MZArray.objectAtIndex(aIndex: Integer): id;
begin
  var lItem := elements[aIndex];
  if lItem = nil then exit nil;
  if &type = typeOf(NSString)  then begin
    exit MZString.NSStringWithMonoString(^MonoString(lItem));
  end;
  var lTmp := &type.alloc();
  exit id(lTmp).initWithMonoInstance(lItem);
end;

method MZArray.objectAtIndexedSubscript(aIndex: Integer): id;
begin
  var lItem := elements[aIndex];
  if lItem = nil then exit nil;
  if &type = typeOf(NSString)  then begin
    exit MZString.NSStringWithMonoString(^MonoString(lItem));
  end;
  var lTmp := &type.alloc();
  exit id(lTmp).initWithMonoInstance(lItem);
end;

method MZArray.setObject(aObject: NSObject) atIndexedSubscript(aValue: Integer);
begin
  if &type = typeOf(NSString) then
    elements[aValue] := MZString.stringWithNSString(NSString(aObject)):__instance
  else begin
    var lInst := MZObject(aObject):__instance;
    elements[aValue] := lInst;
  end;
end;

method MZArray.NSArray: NSArray;
begin
  if fNSArray = nil then begin
    var lTmp := new NSMutableArray withCapacity(count);
    var lElements := elements;
    if &type = typeOf(String) then begin
      for i: Integer := 0 to count -1 do
        lTmp[i] := MZString.NSStringWithMonoString(^MonoString(lElements[i]));
    end
    else begin
      for i: Integer := 0 to count -1 do
        lTmp[i] := id(&type.alloc()).initWithMonoInstance(lElements[i]);
    end;
    fNSArray := lTmp;
  end;
  result := fNSArray;
end;

method MZArray.countByEnumeratingWithState(state: ^NSFastEnumerationState) objects(buffer: ^id) count(len: NSUInteger): NSUInteger;
begin
  result := NSArray.countByEnumeratingWithState(state) objects(buffer) count(len);
end;

{ MZObjectList }

constructor MZObjectList withNSArray(aNSArray: NSArray);
begin
  fNSArray := aNSArray;
end;

constructor MZObjectList withObject(aObject: id);
begin
  fNSArray := Foundation.NSArray.arrayWithObject(aObject);
end;

constructor MZObjectList withMonoInstance(aInst: ^MonoObject) elementType(aType: &Class);
begin
  self := inherited initWithMonoInstance(aInst);
  if assigned(self) then begin
    &type := aType;
  end;
  result := self;
end;

method MZObjectList.clear;
begin
  if fItems = nil then MZObjectListInitFields(self); // global methods optimize better.
  if (fItems^ <> fLastItems) or (fArray = nil) then MZObjectListLoadArray(self);
  for i: Integer := count -1 downto 0 do // just unset the objects and release them.
    fArray.setObject(nil) atIndexedSubscript(i);
  fSize^ := 0;
end;

method MZObjectList.objectAtIndex(aIndex: Integer): id;
begin
  if fItems = nil then MZObjectListInitFields(self); // global methods optimize better.
  if (fItems^ <> fLastItems) or (fArray = nil) then MZObjectListLoadArray(self);
  exit fArray[aIndex];
end;

method MZObjectList.objectAtIndexedSubscript(aIndex: Integer): id;
begin
  if fItems = nil then MZObjectListInitFields(self); // global methods optimize better.
  if (fItems^ <> fLastItems) or (fArray = nil) then MZObjectListLoadArray(self);
  exit fArray[aIndex];
end;

method MZObjectList.countByEnumeratingWithState(state: ^NSFastEnumerationState) objects(buffer: ^id) count(len: NSUInteger): NSUInteger;
begin
  result := NSArray.countByEnumeratingWithState(state) objects(buffer) count(len);
end;

method MZObjectList.get_count: NSUInteger;
begin
  if fItems = nil then MZObjectListInitFields(self);
  exit fSize^;
end;

method MZObjectList.NSArray: NSArray;
begin
  if fNSArray = nil then begin
    if fItems = nil then MZObjectListInitFields(self);
    if (fArray = nil) then MZObjectListLoadArray(self);
    var lTmp := new NSMutableArray withCapacity(count);
    for i: Integer := 0 to count-1 do
      lTmp[i] := fArray[i];
    fNSArray := lTmp;
  end;
  result := fNSArray;
end;

method MZObjectListInitFields(aInst: MZObjectList);
begin
  if MZObjectList.fSizeField = nil then begin
    var lClass := mono_object_get_class(aInst.__instance);
    MZObjectList.fSizeField := mono_class_get_field_from_name(lClass, '_size');
    MZObjectList.fItemsField := mono_class_get_field_from_name(lClass, '_items');
  end;

  aInst.fSize := ^Int32(^Byte(aInst.__instance) + mono_field_get_offset(MZObjectList.fSizeField));
  aInst.fItems := ^^MonoArray(^Byte(aInst.__instance) + mono_field_get_offset(MZObjectList.fItemsField));
end;

method MZObjectListLoadArray(aInst: MZObjectList);
begin
  var lItems := aInst.fItems^;
  aInst.fLastItems := lItems;
  if lItems = nil then begin
    aInst.fArray := nil;
    exit;
  end;
  aInst.fArray := new MZArray withMonoInstance(^MonoObject(lItems));
  aInst.fArray.type := aInst.type;
end;

end.