namespace RemObjects.CodeGenerator;

interface
uses
  System.Collections.Generic;

type
  CGLanguage = public enum (Oxygene, Hydrogene, Objc);
  Generator = public class
  private
    fTypes: List<CGNamedType> := new List<CGNamedType>;
    fUsesList : List<String> := new List<String>;
  protected
  public
    constructor; empty;
    property Language: CGLanguage;
    property UsesList: List<String> read fUsesList;
    property TargetNamespace: String;
    property Types: List<CGNamedType> read fTypes;
  end;
  
implementation

end.
