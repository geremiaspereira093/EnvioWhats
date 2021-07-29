object FormWhats: TFormWhats
  Left = 0
  Top = 0
  Caption = 'Enviar Mensagem'
  ClientHeight = 298
  ClientWidth = 321
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
    Left = 8
    Top = 37
    Width = 41
    Height = 13
    Caption = 'Numero:'
  end
  object EdtNumero: TEdit
    Left = 8
    Top = 65
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object BtnEnviar: TButton
    Left = 8
    Top = 252
    Width = 153
    Height = 36
    Caption = 'Enviar'
    TabOrder = 1
    OnClick = BtnEnviarClick
  end
  object MemoText: TMemo
    Left = 8
    Top = 100
    Width = 298
    Height = 136
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 31
    Align = alTop
    TabOrder = 3
    object Label1: TLabel
      Left = 89
      Top = 2
      Width = 135
      Height = 22
      Caption = 'Envio Whatsapp'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Conexao: TADOConnection
    Connected = True
    ConnectionString = 
      'FILE NAME=C:\trabalho\projetos\55 - controle loja\Execs\SoftA.ud' +
      'l'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 285
    Top = 250
  end
  object QPedidos: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'PES.DES_S,'
      #9'P.DES_S,'
      #9'PED.TOTQTDE_F,'
      #9'PED.TOTALLIQUIDO,'
      #9'E.DES_S,'
      #9'PED.DATEMI_D'
      'FROM MOVIESTOP AS PED'
      'LEFT JOIN CADPES AS PES ON PED.CODPES_I = PES.COD_I'
      'LEFT JOIN PRODMOVI AS PM ON PM.NRDOC_S = PED.NRDOC_S'
      'LEFT JOIN CADEMP AS E ON PED.CODEMP_I = E.COD_I'
      'LEFT JOIN PRODMOVIP AS MP ON MP.NRDOC_S = PED.NRDOC_S'
      'LEFT JOIN CADPRO AS P ON P.COD_I = MP.CODPRO_I'
      '')
    Left = 235
    Top = 250
    object QPedidosDES_S: TStringField
      FieldName = 'DES_S'
      Size = 60
    end
    object QPedidosDES_S_1: TStringField
      FieldName = 'DES_S_1'
      Size = 300
    end
    object QPedidosTOTQTDE_F: TFloatField
      FieldName = 'TOTQTDE_F'
    end
    object QPedidosTOTALLIQUIDO: TFloatField
      FieldName = 'TOTALLIQUIDO'
      DisplayFormat = '###.00,'
      currency = True
    end
    object QPedidosDES_S_2: TStringField
      FieldName = 'DES_S_2'
      Size = 60
    end
    object QPedidosDATEMI_D: TDateTimeField
      FieldName = 'DATEMI_D'
    end
  end
  object dsPedidos: TDataSource
    DataSet = QPedidos
    Left = 270
    Top = 45
  end
end
