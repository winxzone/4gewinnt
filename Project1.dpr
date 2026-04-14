program Project1;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  uLang in 'uLang.pas',
  uGameController in 'uGameController.pas',
  uSettings in 'uSettings.pas' {Settings};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSettings, Settings);
  Application.Run;
end.
