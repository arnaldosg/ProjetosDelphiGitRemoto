object FrmPrincipal: TFrmPrincipal
  Left = 230
  Top = 143
  Width = 696
  Height = 459
  Caption = 'FrmPrincipal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 56
    Width = 14
    Height = 13
    Caption = 'ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 112
    Width = 40
    Height = 13
    Caption = 'Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 32
    Top = 176
    Width = 55
    Height = 13
    Caption = 'Endereco'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Alterar: TButton
    Left = 208
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Alterar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = AlterarClick
  end
  object Excluir: TButton
    Left = 296
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Excluir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = ExcluirClick
  end
  object edtID: TEdit
    Left = 32
    Top = 80
    Width = 33
    Height = 21
    MaxLength = 6
    TabOrder = 2
  end
  object EdtCliente: TEdit
    Left = 32
    Top = 136
    Width = 361
    Height = 21
    MaxLength = 60
    TabOrder = 3
  end
  object EdtEndereco: TEdit
    Left = 32
    Top = 200
    Width = 361
    Height = 21
    MaxLength = 60
    TabOrder = 4
  end
  object Consultar: TButton
    Left = 193
    Top = 13
    Width = 75
    Height = 25
    Caption = 'Consultar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = ConsultarClick
  end
  object Salvar: TButton
    Left = 120
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Salvar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = SalvarClick
  end
  object Novo: TButton
    Left = 32
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Novo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = NovoClick
  end
  object Combo1: TComboBox
    Left = 32
    Top = 16
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 8
  end
end
