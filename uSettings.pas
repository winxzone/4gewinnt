unit uSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uLang, MainForm;

type
  TSettings = class(TForm)
    Panel1: TPanel;
    ePlayerName1: TEdit;
    ePlayerName2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    cbLanguage: TComboBox;
    Label3: TLabel;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbLanguageChange(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure SaveSettings;
    procedure ApplyLanguage;
  public
    { Public-Deklarationen }
    PlayerName1: String;
    PlayerName2: String;
    function GetLanguage: TLanguage;
    procedure LoadSettings;
  end;

var
  Settings: TSettings;


implementation

{$R *.dfm}
uses IniFiles;

procedure TSettings.ApplyLanguage;
begin
  Label1.Caption := CaptionPlayer1;
  Label2.Caption := CaptionPlayer2;
  Label3.Caption := CaptionLanguage;
  Button1.Caption := CaptionSave;
end;

procedure TSettings.Button1Click(Sender: TObject);
begin
  if (Trim(ePlayerName1.Text) = '') or (Trim(ePlayerName2.Text) = '') then
  begin
      ShowMessage('Bitte alle Felder ausfüllen!');
      Exit;
  end;

  SaveSettings;
  ModalResult := mrOk;
end;

procedure TSettings.cbLanguageChange(Sender: TObject);
begin
  CurrentLang := TLanguage(cbLanguage.ItemIndex);
  ApplyLanguage;
  Form1.ApplyLanguage;
end;

procedure TSettings.FormCreate(Sender: TObject);
begin
  cbLanguage.Items.Clear;
  cbLanguage.Items.Add('Deutsch');
  cbLanguage.Items.Add('English');
  cbLanguage.Items.Add('Ruski');
  cbLanguage.Style := csDropDownList;
  cbLanguage.ItemIndex := 0;

  LoadSettings;
end;

function TSettings.GetLanguage: TLanguage;
begin
  case cbLanguage.ItemIndex of
    0: Result := de;
    1: Result := en;
    2: Result := ru;
  else
    Result := de;
  end;
end;

procedure TSettings.SaveSettings;
var
  Ini: TIniFile;
  Path: String;
begin
  Path := ExtractFilePath(Application.ExeName) + 'settings.ini';
  Ini := TIniFile.Create(Path);
  try
    Ini.WriteString('Settings', 'Player_1', ePlayerName1.Text);
    Ini.WriteString('Settings', 'Player_2', ePlayerName2.Text);
    Ini.WriteInteger('Settings', 'Language', cbLanguage.ItemIndex);

    PlayerName1 := ePlayerName1.Text;
    PlayerName2 := ePlayerName2.Text;
  finally
    Ini.Free;
  end;
end;

procedure TSettings.LoadSettings;
var
  Ini: TIniFile;
  Path: String;
begin
  Path := ExtractFilePath(Application.ExeName) + 'settings.ini';
  Ini := TIniFile.Create(Path);
  try
    cbLanguage.ItemIndex := Ini.ReadInteger('Settings', 'Language', 0);
    ePlayerName1.Text := Ini.ReadString('Settings', 'Player_1', 'Player 1');
    ePlayerName2.Text := Ini.ReadString('Settings', 'Player_2', 'Player 2');

    PlayerName1 := ePlayerName1.Text;
    PlayerName2 := ePlayerName2.Text;
  finally
    Ini.Free;
  end;

  CurrentLang := TLanguage(cbLanguage.ItemIndex);
  ApplyLanguage;
  Form1.ApplyLanguage;
end;

end.
