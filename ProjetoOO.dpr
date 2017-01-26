program ProjetoOO;

uses
  Forms,
  UFormPrincipal in 'UFormPrincipal.pas' {FrmPrincipal},
  UDM in 'UDM.pas' {DM: TDataModule},
  ClienteVo in 'ClienteVo.pas',
  uControllerCliente in 'uControllerCliente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
