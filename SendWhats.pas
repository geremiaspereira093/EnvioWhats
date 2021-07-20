unit SendWhats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,ShellApi, Data.DB,
  Datasnap.DBClient, Data.Win.ADODB, Vcl.ExtCtrls, Vcl.Imaging.jpeg, NetEncoding;

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
//  Img.Picture.LoadFromFile(Caminho);
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
  Arquivo: String;
  Cotacao: String;
  Retorno: String;
	Memoria : TMemoryStream;
  Base64: TBase64Encoding;
begin
	Cotacao := 'https://cotacao.desoft7.com.br/?B45387D80CB125C618BFBBA0E52C2077D675E86093B92DBC68E979A2EF1C150B0D';
  Memoria := TMemoryStream.Create;
  Base64 := TBase64Encoding.Create;
  try
  	Memoria.LoadFromFile(OpenDialog1.FileName);
    Arquivo := Base64.EncodeBytesToString(Memoria.Memory,Memoria.Size);
  finally
  	Memoria.Free;
    Base64.Free;
  end;


	Resultado := Link1 + QuebraLinha + '55' + EdtNumero.Text + QuebraLinha +  Link2 + QuebraLinha + Cabecalho +
  QuebraLinha + Titulo + QuebraLinha + Traco +  QuebraLinha + MemoText.Lines.Text + QuebraLinha +Cotacao+ QuebraLinha+
  Traco + QuebraLinha +  Pchar(Arquivo);

  ShowMessage(Resultado);

	if ( ( EdtNumero.Text = '' ) or ( MemoText.Lines.Text = '' ) ) then
   begin
    ShowMessage('Preencha os Campos !');
    abort
   end;

	ShellExecute(Handle,'open',Pchar(Resultado),nil,nil, SW_SHOWMAXIMIZED);

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
