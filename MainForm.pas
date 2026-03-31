unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uLang, uGameController;

type
  TForm1 = class(TForm)
    pnlNavigation: TPanel;
    bNewGame: TButton;
    pbBoard: TPaintBox;
    rgGameMode: TRadioGroup;
    rbPlayerVsPlayer: TRadioButton;
    cbLanguage: TComboBox;
    lblCurrentPlayer: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bNewGameClick(Sender: TObject);
    procedure pbBoardPaint(Sender: TObject);
    procedure pbBoardMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbLanguageChange(Sender: TObject);
  private
    FGame: TGameController;

    FGameOver: Boolean;
    procedure CirclePaint(x, y: Integer);
    procedure UpdateCurrentPlayer;

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  cbLanguage.Items.Clear;
  cbLanguage.Items.Add('Deutsch');
  cbLanguage.Items.Add('English');
  cbLanguage.Items.Add('Ruskij');
  cbLanguage.Style := csDropDownList;

  cbLanguage.ItemIndex := 0;
  CurrentLang := de;

  Randomize;
  FGame := TGameController.Create;
  FGame.NewGame;
  UpdateCurrentPlayer;
end;

// Label Aktueller Spieler
procedure TForm1.UpdateCurrentPlayer;
var Player: Integer;
begin
  Player := FGame.GetCurrentPlayer;
  lblCurrentPlayer.Caption := MsgCurrentPlayer(Player);
  if Player = 1 then
    lblCurrentPlayer.Font.Color := clRed
  else
    lblCurrentPlayer.Font.Color := clYellow;

end;


procedure TForm1.pbBoardMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var _x, Player : Integer;
begin
Player := FGame.GetCurrentPlayer;
  _x := (X div (pbBoard.Width div 7));

  FGame.MakeMove(_x);
  UpdateCurrentPlayer;
  pbBoard.Invalidate;

  if FGame.IsBoardFull then
  begin
    ShowMessage(MsgDraw);
  end
  else if FGame.IsGameOver then
  begin
    ShowMessage(MsgPlayerWon(Player));
  end;


end;

procedure TForm1.pbBoardPaint(Sender: TObject);
var x, y: Integer;
begin
    pbBoard.Canvas.Brush.Color := clHighlight;
    pbBoard.Canvas.FillRect(pbBoard.ClientRect);

    for x := 0 to 6 do
    for y := 0 to 5 do
      CirclePaint(x, y);
end;

procedure TForm1.bNewGameClick(Sender: TObject);
begin
  FGame.NewGame;
  UpdateCurrentPlayer;
  pbBoard.Invalidate;
end;

procedure TForm1.CirclePaint(x, y: Integer);
var
  radius, cx, cy: Integer;
  CellWidth, CellHeight: Integer;
  R: TRect;
begin

  CellWidth := pbBoard.Width div 7;
  CellHeight := pbBoard.Height div 6;

  cx := x * CellWidth + CellWidth div 2;
  cy := y * CellHeight + CellHeight div 2;

  radius := 35;

  R := Rect(cx - radius, cy - radius, cx + radius, cy + radius);

  case FGame.Cells[x, y] of
    0: pbBoard.Canvas.Brush.Color := clWhite;
    1: pbBoard.Canvas.Brush.Color := clRed;
    2: pbBoard.Canvas.Brush.Color := clYellow;
  end;

  pbBoard.Canvas.Pen.Color := clBlack;
  pbBoard.Canvas.Pen.Width := 3;
  pbBoard.Canvas.Ellipse(R);
end;

procedure TForm1.cbLanguageChange(Sender: TObject);
begin
  case cbLanguage.ItemIndex of
    0: CurrentLang := de;
    1: CurrentLang := en;
    2: CurrentLang := ru;
  end;

  bNewGame.Caption := CaptionNewGame;
  lblCurrentPlayer.Caption := MsgCurrentPlayer(FGame.GetCurrentPlayer);
end;

end.
