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
  REST.Response.Adapter, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFormWhats = class(TForm)
    EdtNumero: TEdit;
    Label2: TLabel;
    BtnEnviar: TButton;
    MemoText: TMemo;
    Conexao: TADOConnection;
    QPedidos: TADOQuery;
    dsPedidos: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    QPedidosDES_S: TStringField;
    QPedidosDES_S_1: TStringField;
    QPedidosTOTQTDE_F: TFloatField;
    QPedidosTOTALLIQUIDO: TFloatField;
    QPedidosDES_S_2: TStringField;
    QPedidosDATEMI_D: TDateTimeField;
    procedure BtnEnviarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaDados;
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
  Titulo: String = 'Resumo de pedidos';
var
	Resultado: String;
  Cotacao: String;
  Cliente: String;
  Data: String;
  Produtos: String;
  Valor :String;
  Empresa: String;

begin
  ////////////////////////////// Resumo de Pedidos //////////////////////////////////
	QPedidos.SQL.Add('WHERE NRDOC_S = :DOC');
  Qpedidos.Parameters.ParamByName('DOC').Value :=

	Cliente := QPedidosDES_S.AsString;
  Data := DateToStr( QPedidosDATEMI_D.AsDateTime );
  Produtos := QPedidosDES_S_1.AsString;
  Valor := FloatToStr( QPedidosTOTALLIQUIDO.AsFloat );
  Empresa := QPedidosDES_S_2.AsString;

	Resultado := Link1 + QuebraLinha + '55' + EdtNumero.Text + QuebraLinha +  Link2 +
  QuebraLinha + Titulo + QuebraLinha +  QuebraLinha+ MemoText.Lines.Text +' '+ Cliente +', '+ QuebraLinha +
  ' Segue os dados da sua compra efetuada em ' + Data + QuebraLinha + 'Produtos' + QuebraLinha + Produtos +
  QuebraLinha + Valor + QuebraLinha + 'Atenciosamente, ' + Empresa + QuebraLinha + Cotacao+ QuebraLinha+ QuebraLinha;

	if ( ( EdtNumero.Text = '' ) or ( MemoText.Lines.Text = '' ) ) then
   begin
    ShowMessage('Preencha os Campos !');
    abort
   end;

	ShellExecute(Handle,'open',Pchar( Resultado ),nil,nil, SW_SHOWMAXIMIZED);
  LimpaDados;
end;

procedure TFormWhats.FormCreate( Sender: TObject );
begin
	MemoText.Lines.Text := '';
end;

procedure TFormWhats.LimpaDados;
begin
	EdtNumero.Text  := '';
  MemoText.Lines.Text := '';
end;

end.


