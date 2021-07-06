program EnvioWhats;

uses
  Vcl.Forms,
  SendWhats in 'SendWhats.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormWhats, FormWhats);
  Application.Run;
end.
