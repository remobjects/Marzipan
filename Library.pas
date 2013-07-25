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
    class var fLength: method(aInstance: ^MonoObject; aEx: ^^MonoException): Integer;
    class var fType: MZType := MZMonoRuntime.sharedInstance.getCoreType('System.String');
  public
    class method getType: MZType; override;
    class method stringWithNSString(s: NSString): MZString;

    property length: Integer read get_length;
    method NSString: NSString;
  end;

  MZArray = public class(MZObject)
  private
  public
    constructor withMonoInstance(aInst: ^MonoObject) elementType(aType: &Class);
    property &type: &Class := typeOf(MZObject);
    property elements: ^^MonoObject read ^^MonoObject(mono_array_addr_with_size(^MonoArray(instance), sizeOf(^MonoObject), 0));
    property count: NSUInteger read mono_array_length(^MonoArray(instance));
    method objectAtIndex(aIndex: Integer): id;
    method objectAtIndexedSubscript(aIndex: Integer): id;
    method setObject(aObject: MZObject) atIndexedSubscript(aValue: Integer);
    method toNSArray: NSArray;
  end;

  MZObjectList = public class(MZObject)
  assembly
    fSize: ^Int32;
    fItems: ^^MonoArray;
    fLastItems: ^MonoArray;
    fArray: MZArray;

    class var fSizeField: ^MonoClassField;
    class var fItemsField: ^MonoClassField;
    method count: NSUInteger;
  public
    property &type: &Class := typeOf(MZObject);
    constructor withMonoInstance(aInst: ^MonoObject) elementType(aType: &Class);
    method clear;
    property count: NSUInteger read count;
    method objectAtIndex(aIndex: Integer): id;
    method objectAtIndexedSubscript(aIndex: Integer): id;
  end;

implementation


class method MZString.getType: MZType;
begin
  exit fType;
end;

method MZString.get_length: Integer;
begin
  if fLength = nil then 
    ^^Void(@fLength)^ := fType.getMethodThunk(':get_Length()');
  var ex: ^MonoException := nil;
  result := fLength(instance, @ex);
  if ex <> nil then raiseException(ex);
end;

class method MZString.stringWithNSString(s: NSString): MZString;
begin
  if s = nil then exit nil;
  exit new MZString withMonoInstance(^MonoObject(mono_string_from_utf16(^mono_unichar2(s.cStringUsingEncoding(NSStringEncoding.NSUnicodeStringEncoding)))));
end;

method MZString.NSString: NSString;
begin
  exit NSString.stringWithCharacters(^unichar(mono_string_chars(^MonoString(instance)))) length(mono_string_length(^MonoString(instance)));
end;

method MZArray.objectAtIndex(aIndex: Integer): id;
begin
  var lItem := elements[aIndex];
  if lItem = nil then exit nil;
  var lTmp := &type.alloc();
  exit id(lTmp).initWithMonoInstance(lItem);
end;

method MZArray.objectAtIndexedSubscript(aIndex: Integer): id;
begin
  var lItem := elements[aIndex];
  if lItem = nil then exit nil;
  var lTmp := &type.alloc();
  exit id(lTmp).initWithMonoInstance(lItem);
end;

method MZArray.setObject(aObject: MZObject) atIndexedSubscript(aValue: Integer);
begin
  var lInst := aObject:instance;
  elements[aValue] := lInst;
end;

method MZArray.toNSArray: NSArray;
begin
  var lTmp := new NSMutableArray(count);
  var lElements := elements;
  for i: Integer := 0 to count -1 do begin
    lTmp[i] := id(&type.alloc()).initWithMonoInstance(lElements[i]);
  end;

  exit lTmp;
end;

constructor MZArray withMonoInstance(aInst: ^MonoObject) elementType(aType: &Class);
begin
  self := inherited initWithMonoInstance(aInst);
  result := self;
  &type := aType;
end;


method MZObjectListInitFields(aInst: MZObjectList);
begin
  if MZObjectList.fSizeField = nil then begin
    var lClass := mono_object_get_class(aInst.instance);
    MZObjectList.fSizeField := mono_class_get_field_from_name(lClass, '_size');
    MZObjectList.fItemsField := mono_class_get_field_from_name(lClass, '_items');
  end;
  
  aInst.fSize := ^Int32(^Byte(aInst.instance) + mono_field_get_offset(MZObjectList.fSizeField));
  aInst.fItems := ^^MonoArray(^Byte(aInst.instance) + mono_field_get_offset(MZObjectList.fItemsField));
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

constructor MZObjectList withMonoInstance(aInst: ^MonoObject) elementType(aType: &Class);
begin
  self := inherited initWithMonoInstance(aInst);
  result := self;
  &type := aType;
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

method MZObjectList.count: NSUInteger;
begin
  if fItems = nil then MZObjectListInitFields(self);
  exit fSize^;
end;

end.
