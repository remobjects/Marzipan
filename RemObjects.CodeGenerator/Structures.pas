namespace RemObjects.CodeGenerator;

interface
uses
  System.Collections.Generic;

type
  CGAttribute = public class
  public
    property &Type: CGTypeRef;
  end;
  
  CGTypeKind = public enum (Named, &Array, &Sequence, Pointer, Definition);

  CGTypeRef = public abstract class
  public
    class operator Implicit(a: String): CGTypeRef;
    property Kind: CGTypeKind read; abstract;
  end;
  CGSubTypeRef = public abstract class(CGTypeRef)
  public
    property SubType: CGTypeRef;
  end;

  CGArrayTypeRef = public class(CGSubTypeRef)
  public
    constructor; empty;
    constructor(aSubType: CGTypeRef);
    constructor(aSubType: CGTypeRef; aRanges: array of tuple of (Integer, nullable Integer));
    property Ranges: array of tuple of (Integer, nullable Integer);
    property Kind:  CGTypeKind read CGTypeKind.Array; override;
  end;

  CGSequenceTypeRef = public class(CGSubTypeRef)
  public
    constructor; empty;
    constructor(aSubType: CGTypeRef);
    property Kind:  CGTypeKind read CGTypeKind.Sequence; override;
  end;

  CGPointerTypeRef = public class(CGSubTypeRef)
  public
    constructor; empty;
    constructor(aSubType: CGTypeRef);
    property Kind:  CGTypeKind read CGTypeKind.Pointer; override;
  end;

  CGNamedTypeRef = public class(CGTypeRef)
  public
    constructor; empty;
    constructor(aName: String);
    property Name: String;
    property Kind: CGTypeKind read CGTypeKind.Named; override;
  end;

  CGNamedType = public class(CGMember)
  private
  public
    property Kind: CGMemberKind read CGMemberKind.Type; override;
    property Name: String;
    property &Type: CGTypeRef;
  end;

  CGTypeDefinition = public class(CGTypeRef)
  private
    fMembers : List<CGMember> := new List<CGMember>;
    fAttributes : List<CGAttribute> := new List<CGAttribute>;
  public
    property Comment: String;
    property Attributes: List<CGAttribute> read fAttributes;
    property Members: List<CGMember> read fMembers;
  end;

  
  CGAccessModifier = public enum (&Private, &Protected, &Assembly, &AssemblyOrPotected, &AssemblAndProtected, &Unit, &UnitOrProtected, &UnitAndProtected, &Public);
  CGMemberKind = public enum (Field, &Property, &Type, &Event, &Method);
  CGVirtualBits = public flags (None = 0, &Virtual = 1, &Abstract = 2, &Override = 3, Fianl = 4, &Reintroduce = 8);
  CGMember = public abstract class
  private
    fAttributes : List<CGAttribute> := new List<CGAttribute>;
  public
    property Comment: String;
    property Attributes: List<CGAttribute> read fAttributes;
    property Kind: CGMemberKind read; abstract;
  end;

  CGField = public class(CGMember)
  private
  public
    property Kind: CGMemberKind read CGMemberKind.Field; override;
    property Name: String;
    property &Static: Boolean;
    property &ReadOnly: Boolean;
    property &Type: CGTypeRef;
  end;

  CGProperty = public class(CGMember)
  private
  public
    property Kind: CGMemberKind read CGMemberKind.Property; override;
    property Name: String;
    property &Static: Boolean;
    property &ReadOnly: Boolean;
    property &Notify: String;
    property &Type: CGTypeRef;
    property &Read: CGExpression; 
    property &Write: CGExpression;
    property &Virtual: CGVirtualBits;
  end;

  CGEvent = public class(CGMember)
  private
  public
    property Kind: CGMemberKind read CGMemberKind.Event; override;
    property Name: String;
    property &Static: Boolean;
    property &Notify: String;
    property &Type: CGTypeRef;
    property &Add: CGExpression; 
    property &Remove: CGExpression;  
    property &Delegate: CGExpression;
    property &Raise: CGExpression;
    property &Virtual: CGVirtualBits;
  end;

  CGMethodKind = public enum (&Method, &Constructor, &Finalizer, &Operator);
  CGMethod = public class(CGMember)
  private
    fArguments : List<CGMethodArgument> := new List<CGMethodArgument>;
  public
    property Kind: CGMemberKind read CGMemberKind.Event; override;
    property Name: String;
    property &Static: Boolean;
    property &ResultType: CGTypeRef;
    property Arguments: List<CGMethodArgument> read fArguments;
    property Body: CGStatement;
    
    property &Virtual: CGVirtualBits;
  end;

  CGMethodArgumentModifier = public enum (None, &Var, &Out, &Params);
  CGMethodArgument = public class
  private
  public
    property Prefix: String;
    property Name: String;
    property Modifier: CGMethodArgumentModifier;
    property &Type: CGTypeRef;
    property &Default: CGExpression;
  end;

  CGStatement = public abstract class
  private
  public
  end;

  CGExpression = public abstract class
  end;


implementation

constructor CGArrayTypeRef(aSubType: CGTypeRef);
begin
  inherited constructor;
  SubType := aSubType;
end;

constructor CGArrayTypeRef(aSubType: CGTypeRef; aRanges: array of tuple of (Integer, nullable Integer));
begin
  inherited constructor;
  SubType := aSubType;
  Ranges := aRanges;
end;

constructor CGSequenceTypeRef(aSubType: CGTypeRef);
begin
  inherited constructor;
  SubType := aSubType;
end;

constructor CGPointerTypeRef(aSubType: CGTypeRef);
begin
  inherited constructor;
  SubType := aSubType;
end;

constructor CGNamedTypeRef(aName: String);
begin
  inherited constructor;
  Name := aName;
end;

class operator CGTypeRef.Implicit(a: String): CGTypeRef;
begin
  assert(a <> nil);
  exit new CGNamedTypeRef(a);
end;

end.
