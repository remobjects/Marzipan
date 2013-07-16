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
    property &type: &Class := typeOf(MZObject);
    property elements: ^^MonoObject read ^^MonoObject(mono_array_addr_with_size(^MonoArray(instance), sizeOf(^MonoObject), 0));
    property count: NSUInteger read mono_array_length(^MonoArray(instance));
    method objectAtIndex(aIndex: Integer): MZObject;
    method objectAtIndexedSubscript(aIndex: Integer): MZObject;
    method setObject(aObject: MZObject) atIndexedSubscript(aValue: Integer);
    method toNSArray: NSArray;
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

method MZArray.objectAtIndex(aIndex: Integer): MZObject;
begin
  var lItem := elements[aIndex];
  var lTmp := &type.alloc();
  exit id(lTmp).initWithMonoInstance(lItem);
end;

method MZArray.objectAtIndexedSubscript(aIndex: Integer): MZObject;
begin
  var lItem := elements[aIndex];
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

end.
