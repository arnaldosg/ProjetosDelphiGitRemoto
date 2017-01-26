{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do movimento.

The MIT License

Copyright: Copyright (C) 2010 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit MovimentoController;

interface

uses
  Classes, SQLExpr, SysUtils, MovimentoVO;

type
  TMovimentoController = class
  protected
  public
    Procedure Consulta;
    Function Insere(pMovimento: TMovimentoVO): Boolean;
    Function IniciaMovimento(pMovimento: TMovimentoVO): TMovimentoVO;
    procedure EncerraMovimento(pMovimento: TMovimentoVO);
    Function VerificaMovimento(): TMovimentoVO;
    Function Altera(pMovimento: TMovimentoVO): Boolean;
    Function Exclui(pId: Integer): Boolean;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

Procedure TMovimentoController.Consulta;
begin
  ConsultaSQL := 'select * from ECF_MOVIMENTO';
  FDataModule.QMovimento.sql.Text := ConsultaSQL;
  FDataModule.QMovimento.Open;
end;

Function TMovimentoController.VerificaMovimento() : TMovimentoVO;
var
  Movimento: TMovimentoVO;
begin
  ConsultaSQL := 'select M.ID, M.ID_OPERADOR, O.LOGIN, M.ID_ECF_CAIXA, M.ID_IMPRESSORA, M.DATA_HORA_ABERTURA '+
  'from ECF_MOVIMENTO M, ECF_OPERADOR O where STATUS_MOVIMENTO="A" and M.ID_OPERADOR=O.ID';
  try
    try
      FDataModule.QMovimento.sql.Text := ConsultaSQL;
      FDataModule.QMovimento.Open;

      Movimento := TMovimentoVO.Create;

      Movimento.Id := FDataModule.QMovimento.FieldByName('ID').AsInteger;
      Movimento.IdCaixa := FDataModule.QMovimento.FieldByName('ID_ECF_CAIXA').AsInteger;
      Movimento.IdOperador := FDataModule.QMovimento.FieldByName('ID_OPERADOR').AsInteger;
      Movimento.IdImpressora := FDataModule.QMovimento.FieldByName('ID_IMPRESSORA').AsInteger;
      Movimento.DataHoraAbertura := FDataModule.QMovimento.FieldByName('DATA_HORA_ABERTURA').AsString;

      FDataModule.CDSMovimento.Open;

      result := Movimento;
    except
      result := nil;
    end;
  finally
  end;
end;

procedure TMovimentoController.EncerraMovimento(pMovimento: TMovimentoVO);
begin
  ConsultaSQL :=
    'update ECF_MOVIMENTO set DATA_HORA_FECHAMENTO=:pDataHoraFechamento, STATUS_MOVIMENTO=:Status ' +
    ' where ID = :pId';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pId').AsInteger := pMovimento.Id;
      Query.ParamByName('pDataHoraFechamento').AsString := pMovimento.DataHoraFechamento;
      Query.ParamByName('Status').AsString := pMovimento.Status;
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;

end;

function TMovimentoController.Insere(pMovimento: TMovimentoVO): Boolean;
begin
  ConsultaSQL :=
    'insert into ECF_MOVIMENTO ('+
    'ID_ECF_CAIXA,'+
    'ID_OPERADOR,'+
    'ID_IMPRESSORA,'+
    'DATA_HORA_ABERTURA,'+
    'DATA_HORA_FECHAMENTO,'+
    'TOTAL_SUPRIMENTO,'+
    'TOTAL_SANGRIA,'+
    'TOTAL_NAO_FISCAL,'+
    'TOTAL_VENDA,'+
    'TOTAL_DESCONTO,'+
    'TOTAL_ACRESCIMO,'+
    'TOTAL_FINAL,'+
    'TOTAL_RECEBIDO,'+
    'TOTAL_TROCO,'+
    'TOTAL_CANCELADO,'+
    'STATUS_MOVIMENTO,'+
    'SINCRONIZADO) values ('+

    ':pCaixa,'+
    ':pOperador,'+
    ':pImpressora,'+
    ':pDataHoraAbertura,'+
    ':pDataHoraFechamento,'+
    ':pTotalSuprimento,'+
    ':pTotalSangria,'+
    ':pTotalNaoFiscal,'+
    ':pTotalVenda,'+
    ':pTotalDesconto,'+
    ':pTotalAcrescimo,'+
    ':pTotalFinal,'+
    ':pTotalRecebido,'+
    ':pTotalTroco,'+
    ':pTotalCancelado,'+
    ':pStatus,'+
    ':pSincronizado)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pCaixa').AsInteger := pMovimento.IdCaixa;
      Query.ParamByName('pOperador').AsInteger := pMovimento.IdOperador;
      Query.ParamByName('pImpressora').AsInteger := pMovimento.IdImpressora;
      Query.ParamByName('pDataHoraAbertura').AsString := pMovimento.DataHoraAbertura;
      Query.ParamByName('pDataHoraFechamento').AsString := pMovimento.DataHoraFechamento;
      Query.ParamByName('pTotalSuprimento').AsFloat := pMovimento.TotalSuprimento;
      Query.ParamByName('pTotalSangria').AsFloat := pMovimento.TotalSangria;
      Query.ParamByName('pTotalNaoFiscal').AsFloat := pMovimento.TotalNaoFiscal;
      Query.ParamByName('pTotalVenda').AsFloat := pMovimento.TotalVenda;
      Query.ParamByName('pTotalDesconto').AsFloat := pMovimento.TotalDesconto;
      Query.ParamByName('pTotalAcrescimo').AsFloat := pMovimento.TotalAcrescimo;
      Query.ParamByName('pTotalFinal').AsFloat := pMovimento.TotalFinal;
      Query.ParamByName('pTotalRecebido').AsFloat := pMovimento.TotalRecebido;
      Query.ParamByName('pTotalTroco').AsFloat := pMovimento.TotalTroco;
      Query.ParamByName('pTotalCancelado').AsFloat := pMovimento.TotalCancelado;
      Query.ParamByName('pStatus').AsString := pMovimento.Status;
      Query.ParamByName('pSincronizado').AsString := pMovimento.Sincronizado;
      Query.ExecSQL();

      result := true;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

function TMovimentoController.IniciaMovimento(pMovimento: TMovimentoVO): TMovimentoVO;
begin
  ConsultaSQL :=
    'insert into ECF_MOVIMENTO ('+
    'ID_ECF_CAIXA,'+
    'ID_OPERADOR,'+
    'ID_IMPRESSORA,'+
    'DATA_HORA_ABERTURA,'+
    'TOTAL_SUPRIMENTO,'+
    'STATUS_MOVIMENTO,'+
    'SINCRONIZADO) values ('+

    ':pCaixa,'+
    ':pOperador,'+
    ':pImpressora,'+
    ':pDataHoraAbertura,'+
    ':pTotalSuprimento,'+
    ':pStatus,'+
    ':pSincronizado)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pCaixa').AsInteger := pMovimento.IdCaixa;
      Query.ParamByName('pOperador').AsInteger := pMovimento.IdOperador;
      Query.ParamByName('pImpressora').AsInteger := pMovimento.IdImpressora;
      Query.ParamByName('pDataHoraAbertura').AsString := pMovimento.DataHoraAbertura;
      Query.ParamByName('pTotalSuprimento').AsFloat := pMovimento.TotalSuprimento;
      Query.ParamByName('pStatus').AsString := pMovimento.Status;
      Query.ParamByName('pSincronizado').AsString := pMovimento.Sincronizado;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from ECF_MOVIMENTO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      pMovimento.Id := Query.FieldByName('ID').AsInteger;
      result := pMovimento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

function TMovimentoController.Altera(pMovimento: TMovimentoVO): Boolean;
begin

  try
    try
      ConsultaSQL :=
        'update ECF_MOVIMENTO set ' +
        'ID_ECF_CAIXA=:pCaixa,'+
        'ID_OPERADOR=:pOperador,'+
        'ID_IMPRESSORA=:pImpressora,'+
        'DATA_HORA_ABERTURA=:pDataHoraAbertura,'+
        'DATA_HORA_FECHAMENTO=:pDataHoraFechamento,'+
        'TOTAL_SUPRIMENTO=:pTotalSuprimento,'+
        'TOTAL_SANGRIA=:pTotalSangria,'+
        'TOTAL_NAO_FISCAL=:pTotalNaoFiscal,'+
        'TOTAL_VENDA=:pTotalVenda,'+
        'TOTAL_DESCONTO=:pTotalDesconto,'+
        'TOTAL_ACRESCIMO=:pTotalAcrescimo,'+
        'TOTAL_FINAL=:pTotalFinal,'+
        'TOTAL_RECEBIDO=:pTotalRecebido,'+
        'TOTAL_TROCO=:pTotalTroco,'+
        'TOTAL_CANCELADO=:pTotalCancelado,'+
        'STATUS_MOVIMENTO=:pStatus,'+
        'SINCRONIZADO=:pSincronizado) ' +
        'where ID=' + IntToStr(pMovimento.Id);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pCaixa').AsInteger := pMovimento.IdCaixa;
      Query.ParamByName('pOperador').AsInteger := pMovimento.IdOperador;
      Query.ParamByName('pImpressora').AsInteger := pMovimento.IdImpressora;
      Query.ParamByName('pDataHoraAbertura').AsString := pMovimento.DataHoraAbertura;
      Query.ParamByName('pDataHoraFechamento').AsString := pMovimento.DataHoraFechamento;
      Query.ParamByName('pTotalSuprimento').AsFloat := pMovimento.TotalSuprimento;
      Query.ParamByName('pTotalSangria').AsFloat := pMovimento.TotalSangria;
      Query.ParamByName('pTotalNaoFiscal').AsFloat := pMovimento.TotalNaoFiscal;
      Query.ParamByName('pTotalVenda').AsFloat := pMovimento.TotalVenda;
      Query.ParamByName('pTotalDesconto').AsFloat := pMovimento.TotalDesconto;
      Query.ParamByName('pTotalAcrescimo').AsFloat := pMovimento.TotalAcrescimo;
      Query.ParamByName('pTotalFinal').AsFloat := pMovimento.TotalFinal;
      Query.ParamByName('pTotalRecebido').AsFloat := pMovimento.TotalRecebido;
      Query.ParamByName('pTotalTroco').AsFloat := pMovimento.TotalTroco;
      Query.ParamByName('pTotalCancelado').AsFloat := pMovimento.TotalCancelado;
      Query.ParamByName('pStatus').AsString := pMovimento.Status;
      Query.ParamByName('pSincronizado').AsString := pMovimento.Sincronizado;
      Query.ExecSQL();
      result := true;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;

end;

function TMovimentoController.Exclui(pId: Integer): Boolean;
begin

  ConsultaSQL := 'delete from ECF_MOVIMENTO where ID = ' + IntToStr(pId);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();
      result := true;
    except
      result := false;
    end;
  finally

    Query.Free;
  end;

end;

end.
