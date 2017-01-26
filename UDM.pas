unit UDM;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr;

type
  TDM = class(TDataModule)
    SQLConnection1: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

end.
