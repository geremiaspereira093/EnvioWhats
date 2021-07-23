unit SendWhats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,ShellApi, Data.DB,
  Datasnap.DBClient, Data.Win.ADODB, Vcl.ExtCtrls, Vcl.Imaging.jpeg, NetEncoding,Idcoder
  ,IdCoderMime, typinfo;

type
	TSendFile_Image = ( Tsf_Jpg=0, Tsf_Jpeg=1, Tsf_Tif=2, Tsf_Ico=3, Tsf_Bmp=4, Tsf_Png=5, Tsf_Raw=6);
	TSendFile_Audio  = (Tsf_Mp3=0);
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
    Function StrExtFile_Base64Type(PFileName: String): String;
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
	Link1: String = 'https://api.whatsapp.com/send?phone=';
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
  Base64:  TBase64Encoding;
  Arquivo2: String;
  Formato: String;
begin
	Cotacao := 'https://cotacao.desoft7.com.br/?B45387D80CB125C618BFBBA0E52C2077D675E86093B92DBC68E979A2EF1C150B0D';
  Formato := Copy( ExtractFileExt( OpenDialog1.FileName ),2,5 );
  Memoria := TMemoryStream.Create;
  Base64 := TBase64Encoding.Create;
  try
  	Memoria.LoadFromFile( OpenDialog1.FileName );
    Arquivo := Base64.EncodeBytesToString( Memoria.Memory,Memoria.Size );
 		Arquivo := StrExtFile_Base64Type( OpenDialog1.FileName ) + Arquivo;
  finally
  	Memoria.Free;
    Base64.Free;
  end;

	Resultado := Link1 + QuebraLinha + '55' + EdtNumero.Text + QuebraLinha +  Link2 + QuebraLinha + Cabecalho +
  QuebraLinha + Titulo + QuebraLinha + Traco +  QuebraLinha + MemoText.Lines.Text + QuebraLinha +Cotacao+ QuebraLinha+
  Traco + QuebraLinha + Arquivo + Formato ;

  ShowMessage(Resultado);

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

function TFormWhats.StrExtFile_Base64Type( PFileName: String ): String;
var
	I: Integer;
  Ext: String;
  Temp: String;
begin
	Ext := Copy( ExtractFileExt( OpenDialog1.FileName ),2,50 );
  REsult := 'data:application.';
  try

    for I := 0 to 6 do
    begin
    	temp := LowerCase( Copy( GetEnumName( TypeInfo( TSendFile_Image ), ord( TSendFile_Image( i ) ) ), 3, 50) );
      if pos( Ext, Temp ) > 0 Then
      Begin
        Result := 'data:image.';
        Exit;
      end
    end;

    for I := 0 to 0 do
    begin
    	Temp := LowerCase( Copy ( GetEnumName( TypeInfo ( TSendFile_Audio ), ord( TSendFile_Audio( i ) ) ), 3, 50 ) );
      if pos( Ext, Temp ) > 0 Then
      Begin
        Result := 'data:audio.';
        Exit;
      end
    end;


  finally
  	Result := Result + Ext + ';base64,';
  end;


end;

end.
