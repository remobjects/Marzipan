namespace Importer;

interface

uses
  System.Collections.Generic,
  System.Text;

type
  Importer = public class
  private
    fSettings: ImporterSettings;
  protected
  public
    constructor(aSettings: ImporterSettings);

    method Run;
  end;

implementation

constructor Importer(aSettings: ImporterSettings);
begin
  fSettings := aSettings;
end;

method Importer.Run;
begin

end;

end.
