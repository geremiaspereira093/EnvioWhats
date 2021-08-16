unit SendWhats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,ShellApi, Data.DB,
  Datasnap.DBClient, Data.Win.ADODB, Vcl.ExtCtrls, Vcl.Imaging.jpeg, NetEncoding,Idcoder
  ,IdCoderMime, typinfo,Horse, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  REST.Authenticator.OAuth, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Response.Adapter, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  Vcl.Buttons;

type
  TFormWhats = class(TForm)
    EdtNumero: TEdit;
    Label2: TLabel;
    BtnEnviar: TButton;
    Conexao: TADOConnection;
    QPedidos: TADOQuery;
    dsPedidos: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    QPedidosNRDOC_S: TStringField;
    QPedidosDES_S: TStringField;
    QPedidosDES_S_1: TStringField;
    QPedidosTOTQTDE_F: TFloatField;
    QPedidosTOTALLIQUIDO: TFloatField;
    QPedidosDES_S_2: TStringField;
    QPedidosDATEMI_D: TDateTimeField;
    QPedidosPREUNIT_F: TFloatField;
    QPedidosQTDE_F: TFloatField;
    QPedidosDES_S_3: TStringField;
    QPedidosCEL_S: TStringField;
    Memo1: TMemo;
    QPedidosTIPOVENDA: TStringField;
    QPedidosDES_S_4: TStringField;
    QPedidosOBSINTERNA: TMemoField;
    QPedidosDES_S_5: TStringField;
    QPedidosDES_S_6: TStringField;
    QPedidosPREVENDA_F: TFloatField;
    QPedidosPRETOTALD_F: TFloatField;
    SpeedButton1: TSpeedButton;
    procedure BtnEnviarClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FormWhats: TFormWhats;
implementation

{$R *.dfm}

procedure TFormWhats.BtnEnviarClick(Sender: TObject);
const
	Link1: String = 'https://api.whatsapp.com/send?phone=';
 	Link2: String = '&text= ';
  QuebraLinha: String = '%0A';
  Titulo: String = 'Resumo do pedido';
  Emoji: String = '📌';
var
	Resultado: String;
  Cotacao: String;
  Cliente: String;
  Data: String;
  Produtos: String;
  ValorUnitario :String;
  Empresa: String;
  Unidade: String;
  QtdeUnitario: String;
  ValorTotal: String;
  I: Integer;
	FormPgto: String;
  Observacao: String;
  CondPgto: String;
begin
  ////////////////////////////// Resumo do pedido //////////////////////////////////

//	Cliente := QPedidosDES_S.AsString;
  Data := DateToStr( QPedidosDATEMI_D.AsDateTime );
  Empresa := QPedidosDES_S_2.AsString;
  ValorTotal :=  FormatFloat( '###.00', QPedidosTOTALLIQUIDO.AsFloat );
  FormPgto := QPedidosDES_S_4.AsString;
  Observacao := QPedidosOBSINTERNA.AsString;
  CondPgto := QPedidosDES_S_5.AsString;

  QPedidos.First;
  while not Qpedidos.Eof do begin
  	Memo1.Lines.Add( QPedidosDES_S_1.AsString );
    Memo1.Lines.Add( ' R$' + FormatFloat( '###.00,', QPedidosPRETOTALD_F.AsFloat ) );
    Memo1.Lines.Add(' '  + FloatToStr(  QPedidosQTDE_F.AsFloat ) );
    Memo1.Lines.Add( ' ' + QPedidosDES_S_3.AsString + QuebraLinha );
    QPedidos.Next;
  end;

	Resultado := Link1 + QuebraLinha + '55' + EdtNumero.Text + QuebraLinha +  Link2 + Emoji +
  QuebraLinha + Titulo + QuebraLinha +  QuebraLinha+ 'Olá' +' '+ Cliente +', '+ QuebraLinha +
 'Segue os dados da sua compra efetuada em ' + Data + QuebraLinha + QuebraLinha +'Produtos e Serviços'+
  QuebraLinha + Memo1.Lines.Text + QuebraLinha + 'Total' + ' ' + ValorTotal+ QuebraLinha+ 'Forma de Pagamento '
  + FormPgto +' ' + CondPgto + QuebraLinha + 'Observação: ' + Observacao+ QuebraLinha +QuebraLinha + 'Atenciosamente, '
  + Empresa+ QuebraLinha ;

	if EdtNumero.Text = '' then
  begin
  	ShowMessage('Informe um número válido !');
    abort
  end;

	ShellExecute(Handle,'open',Pchar( Resultado ),nil,nil, SW_SHOWMAXIMIZED);
	EdtNumero.Text  := '';
//  Memo1.Lines.Text := '';
end;

end.


