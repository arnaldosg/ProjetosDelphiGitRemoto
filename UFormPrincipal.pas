unit UFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmPrincipal = class(TForm)
    Alterar: TButton;
    Excluir: TButton;
    edtID: TEdit;
    EdtCliente: TEdit;
    EdtEndereco: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Consultar: TButton;
    Salvar: TButton;
    Novo: TButton;
    Combo1: TComboBox;
    procedure SalvarClick(Sender: TObject);
    procedure ExcluirClick(Sender: TObject);
    procedure ConsultarClick(Sender: TObject);
    procedure AlterarClick(Sender: TObject);
    procedure NovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure InstanciaObjetos;
    procedure PropriedaFieldVo(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  uControllerCliente, ClienteVo, Typinfo;

var
  Controller: TControllerCliente;
  Cliente: TClienteVo;

{$R *.dfm}

procedure TFrmPrincipal.InstanciaObjetos;    // instancia objetos Controller´s e Vo´s
begin
  Controller := TControllerCliente.Create;
  Cliente := TClienteVo.Create;
end;

procedure TFrmPrincipal.SalvarClick(Sender: TObject);
begin
  InstanciaObjetos;
  Cliente.CLIENTE  := EdtCliente.Text;
  Cliente.ENDERECO := EdtEndereco.Text;
  if Controller.Insert(Cliente) then
     ShowMessage('Gravado com sucesso !');
end;

procedure TFrmPrincipal.ExcluirClick(Sender: TObject);
begin
  InstanciaObjetos;
  Cliente.ID := StrToInt(edtID.Text);
  if Controller.Delete(Cliente) then
     ShowMessage('Deletado com Sucesso !');
end;

procedure TFrmPrincipal.ConsultarClick(Sender: TObject);
begin
  InstanciaObjetos;
  Cliente.ID := StrToInt(edtID.Text);  // alimenta parametro de pesquisa , ID
  Controller.Consulta(Cliente);  // passa a classe com o parametro, so com o valor do ID

  edtID.Text       := IntToStr(Cliente.ID);   // classe retornada , ja "alimentada"
  EdtCliente.Text  := Cliente.CLIENTE;
  EdtEndereco.Text := Cliente.ENDERECO;
end;

procedure TFrmPrincipal.AlterarClick(Sender: TObject);
begin
  InstanciaObjetos;
  Cliente.ID := StrToInt(edtID.Text);  // parametro
  Cliente.CLIENTE  := EdtCliente.Text;
  Cliente.ENDERECO := EdtEndereco.Text;
  if Controller.Update(Cliente) then      
     ShowMessage('Atualizado com Sucesso !');
end;

procedure TFrmPrincipal.NovoClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to ComponentCount -1 do
  begin
    if Components[i].ClassType = TEdit then
       TEdit(Components[i]).Text := '';
  end;
  EdtCliente.SetFocus;
end;

procedure TFrmPrincipal.PropriedaFieldVo(Sender: TObject);
var
  PropCount,Prop,IntValue: Integer;
  PropList: PPropList;
  PropName: string;
begin
  PropCount := GetPropList(Sender.ClassInfo, PropList) - 1;
  if PropCount > 0 then
  begin
    for Prop := 0 to PropCount do
    begin
       PropName := PropList[Prop].Name;
       Combo1.Items.Add(PropName);
    end;
  end;

end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  InstanciaObjetos;
  PropriedaFieldVo(Cliente);
end;

end.
