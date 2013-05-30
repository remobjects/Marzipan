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

end.
