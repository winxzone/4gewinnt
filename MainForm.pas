unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus,
  uGameController;

type
  TForm1 = class(TForm)
    pnlNavigation: TPanel;
    bNewGame: TButton;
    pbBoard: TPaintBox;
    rgGameMode: TRadioGroup;
    lblCurrentPlayer: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Settings1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure bNewGameClick(Sender: TObject);
    procedure rgGameModeClick(Sender: TObject);
    procedure pbBoardPaint(Sender: TObject);
    procedure pbBoardMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Settings1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FGame: TGameController;
    procedure CirclePaint(x, y: Integer);
    procedure UpdateCurrentPlayer;
    procedure CheckAndComputerMove;

  public
    { Public-Deklarationen }
    procedure ApplyLanguage;
  end;

var
  Form1: TForm1;

implementation

uses
  uSettings, uLang;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  FGame := TGameController.Create;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Settings.LoadSettings;
  rgGameMode.ItemIndex := 0;
  FGame.NewGame;
  UpdateCurrentPlayer;
  CheckAndComputerMove;
  pbBoard.Invalidate;
end;

procedure TForm1.ApplyLanguage;
begin
  bNewGame.Caption := CaptionNewGame;
  MainMenu1.Items[0].Caption := CaptionNewGame;
  MainMenu1.Items[1].Caption := CaptionSettings;

  rgGameMode.Items[0] := CaptionGameMode(0);
  rgGameMode.Items[1] := CaptionGameMode(1);

end;

procedure TForm1.N1Click(Sender: TObject);
begin
  FGame.NewGame;
  UpdateCurrentPlayer;
  CheckAndComputerMove;
  pbBoard.Invalidate;
end;

procedure TForm1.CheckAndComputerMove;
begin
  if rgGameMode.ItemIndex = 1 then
    if FGame.GetCurrentPlayer = 2 then
      FGame.MakeComputerMove;
end;

// Label Aktueller Spieler
procedure TForm1.UpdateCurrentPlayer;
begin
  if (FGame.GetCurrentPlayer = 2) and (rgGameMode.ItemIndex = 1) then
  begin
    lblCurrentPlayer.Font.Color := clYellow;
    lblCurrentPlayer.Caption := MsgComputerCaption;
  end
  else if (FGame.GetCurrentPlayer = 1)then
  begin
    lblCurrentPlayer.Font.Color := clRed;
    lblCurrentPlayer.Caption := MsgCurrentPlayer(PlayerName1);
  end
  else
  begin
    lblCurrentPlayer.Font.Color := clYellow;
    lblCurrentPlayer.Caption := MsgCurrentPlayer(PlayerName2);
  end;
end;

procedure TForm1.pbBoardMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var _x: Integer;
begin
  _x := (X div (pbBoard.Width div 7));

  FGame.MakeMove(_x);
  pbBoard.Invalidate;
  UpdateCurrentPlayer;

  CheckAndComputerMove;
  pbBoard.Invalidate;
  UpdateCurrentPlayer;

  if FGame.IsBoardFull then
  begin
    ShowMessage(MsgDraw);
  end
  else if FGame.IsGameOver then
  begin
    if FGame.GetCurrentPlayer = 1 then
      ShowMessage(MsgPlayerWon(PlayerName1))
    else if (rgGameMode.ItemIndex = 1) and (FGame.GetCurrentPlayer = 2) then
      ShowMessage(MsgComputerWon)
    else
      ShowMessage(MsgPlayerWon(PlayerName2));
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

procedure TForm1.rgGameModeClick(Sender: TObject);
begin
  FGame.NewGame;
  CheckAndComputerMove;
  UpdateCurrentPlayer;
  pbBoard.Invalidate;

end;

procedure TForm1.Settings1Click(Sender: TObject);
begin
  Settings.ShowModal;
end;

procedure TForm1.bNewGameClick(Sender: TObject);
begin
  FGame.NewGame;
  CheckAndComputerMove;
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

end.
