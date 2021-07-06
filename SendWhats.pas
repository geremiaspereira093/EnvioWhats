unit SendWhats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,ShellApi;

type
  TFormWhats = class(TForm)
    MemoText: TMemo;
    EdtNumero: TEdit;
    Label2: TLabel;
    BtnEnviar: TButton;
    OpenDialog1: TOpenDialog;
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
	Link1: String = 'https://web.whatsapp.com/send?phone=';
 	Link2: String = '&text= ';
 	Traco: String = '__________________________________';
  QuebraLinha: String = '%0A';
  Cabecalho: String = 'Pedido de Compra';
  Titulo: String = 'Produtos;Quantidade';
var
	Resultado: String;
  Caminho : String;
begin
	Resultado := Link1 + QuebraLinha + EdtNumero.Text + QuebraLinha +  Link2 + QuebraLinha + Cabecalho +
  QuebraLinha + Titulo + QuebraLinha + Traco +  QuebraLinha + MemoText.Lines.Text + QuebraLinha + Traco;
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
