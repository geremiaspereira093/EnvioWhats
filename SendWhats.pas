unit SendWhats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,ShellApi, Data.DB,
  Datasnap.DBClient, Data.Win.ADODB, Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TFormWhats = class(TForm)
    MemoText: TMemo;
    EdtNumero: TEdit;
    Label2: TLabel;
    BtnEnviar: TButton;
    OpenDialog1: TOpenDialog;
    BtnAddImagem: TButton;
    Img: TImage;
    procedure BtnEnviarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAddImagemClick(Sender: TObject);
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

procedure TFormWhats.BtnAddImagemClick(Sender: TObject);
var
	Caminho: String;
begin
	OpenDialog1.Execute();
	Caminho :=  OpenDialog1.FileName;
  Img.Picture.LoadFromFile(Caminho);
end;

procedure TFormWhats.BtnEnviarClick(Sender: TObject);
const
	Link1: String = 'https://web.whatsapp.com/send?phone=';
 	Link2: String = '&text= ';
 	Traco: String = '__________________________________';
  QuebraLinha: String = '%0A';
  Cabecalho: String = 'Pedido de Compra';
  Titulo: String = 'Produtos;Quantidade';
var
	Resultado: String;
  Arquivo: TPicture;
  Cotacao: String;
  Retorno: String;
begin
	Cotacao := 'https://cotacao.desoft7.com.br/?B45387D80CB125C618BFBBA0E52C2077D675E86093B92DBC68E979A2EF1C150B0D';

	Retorno:= OpenDialog1.FileName;

	Resultado := Link1 + QuebraLinha + '55' + EdtNumero.Text + QuebraLinha +  Link2 + QuebraLinha + Cabecalho +
  QuebraLinha + Titulo + QuebraLinha + Traco +  QuebraLinha + MemoText.Lines.Text + QuebraLinha +Cotacao+ QuebraLinha+
  Traco + QuebraLinha + Pchar(Retorno);

  ShowMessage(Resultado);

	if ( ( EdtNumero.Text = '' ) or ( MemoText.Lines.Text = '' ) ) then
   begin
    ShowMessage('Preencha os Campos !');
    abort
   end;

	ShellExecute(Handle,'print',Pchar(Retorno),nil,nil, SW_SHOWMAXIMIZED);

  LimpaDados;
end;

procedure TFormWhats.FormCreate(Sender: TObject);
begin
	MemoText.Lines.Text := '';
end;

procedure TFormWhats.LimpaDados;
begin
	EdtNumero.Text  := '';
  MemoText.Lines.Text := '';
end;

end.
