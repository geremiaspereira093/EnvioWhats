object FormWhats: TFormWhats
  Left = 0
  Top = 0
  Caption = 'Enviar Mensagem'
  ClientHeight = 295
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 10
    Top = 14
    Width = 41
    Height = 13
    Caption = 'Numero:'
  end
  object MemoText: TMemo
    Left = 8
    Top = 75
    Width = 308
    Height = 136
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object EdtNumero: TEdit
    Left = 10
    Top = 33
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object BtnEnviar: TButton
    Left = 8
    Top = 230
    Width = 308
    Height = 47
    Caption = 'Enviar'
    TabOrder = 2
    OnClick = BtnEnviarClick
  end
  object OpenDialog1: TOpenDialog
    Left = 215
    Top = 25
  end
end
