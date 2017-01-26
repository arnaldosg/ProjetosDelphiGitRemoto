unit uControllerCliente;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, ClienteVo;

type
  TControllerCliente = class
  protected
  public
    function Consulta(pCliente: TClienteVo): TClienteVo;
    function Insert(pClinte: TClienteVo): Boolean;
    function Delete(pClinte: TClienteVo): Boolean;
    function Update(pClinte: TClienteVo): Boolean;
 end;

implementation

uses UDM;

var
  ComandoSql: string;
  QueryDin: TSQLQuery;

{ ControllerCliente }

function TControllerCliente.Consulta(pCliente: TClienteVo): TClienteVo;
var
  ResultSet: TClienteVo;  // cria objeto tipo TClienteVo
begin
  try
    ComandoSql := 'SELECT * FROM CLIENTE WHERE ID = '+IntToStr(pCliente.ID);
    QueryDin := TSQLQuery.Create(nil);
    QueryDin.SQLConnection := DM.SQLConnection1;

    QueryDin.sql.Text := ComandoSql;
    QueryDin.Open;

    pCliente.ID       := QueryDin.fieldByName('ID').AsInteger;
    pCliente.CLIENTE  := QueryDin.fieldByName('CLIENTE').AsString;
    pCliente.ENDERECO := QueryDin.fieldByName('ENDERECO').AsString;

    result := pCliente;
  except
    result := nil;
  end;
end;

function TControllerCliente.Delete(pClinte: TClienteVo):Boolean;
begin
  ComandoSql := 'DELETE FROM CLIENTE WHERE ID=:pID';
  try
    try
      QueryDin := TSQLQuery.Create(nil);
      QueryDin.SQLConnection := DM.SQLConnection1;
      QueryDin.sql.Text := ComandoSql;
      QueryDin.ParamByName('pID').AsInteger := pClinte.ID;
      QueryDin.ExecSQL();
      result := true;
    except
      result := false;
    end;
  finally
    QueryDin.Free;
  end;

end;

function TControllerCliente.Insert(pClinte: TClienteVo):Boolean;
begin
  ComandoSql := 'INSERT INTO CLIENTE ('+
                        'CLIENTE,'      +
                        'ENDERECO) '    +
                'VALUES ('+
                        ':pCLIENTE,'+
                        ':pENDERECO)';
  try
    try
      QueryDin := TSQLQuery.Create(nil);
      QueryDin.SQLConnection := DM.SQLConnection1;
      QueryDin.sql.Text := ComandoSql;
      QueryDin.ParamByName('pCLIENTE').AsString  := pClinte.CLIENTE;
      QueryDin.ParamByName('pENDERECO').AsString := pClinte.ENDERECO;
      QueryDin.ExecSQL();

      result := true;
    except
      result := false;
    end;
  finally
    QueryDin.Free;
  end;
end;

function TControllerCliente.Update(pClinte: TClienteVo):Boolean;
begin
  ComandoSql := 'UPDATE CLIENTE SET '          +
                        'CLIENTE  =:pCLIENTE,' +
                        'ENDERECO =:pENDERECO '+
                'WHERE ID =:pID';
  try
    try
      QueryDin := TSQLQuery.Create(nil);
      QueryDin.SQLConnection := DM.SQLConnection1;
      QueryDin.sql.Text := ComandoSql;

      QueryDin.ParamByName('pCLIENTE').AsString  := pClinte.CLIENTE;
      QueryDin.ParamByName('pENDERECO').AsString := pClinte.ENDERECO;
      QueryDin.ParamByName('pID').AsInteger      := pClinte.ID;  // parametro 
      QueryDin.ExecSQL();

      result := true;
    except
      result := false;
    end;
  finally
    QueryDin.Free;
  end;

end;

end.
