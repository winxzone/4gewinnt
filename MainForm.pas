unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uLang;

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


    FCurrentPlayer: Integer;
    FBoard: array[0..6, 0..5] of Integer;
    FGameOver: Boolean;
    procedure NewGame;
    procedure CirclePaint(x, y: Integer);
    procedure UpdateCurrentPlayer;
    procedure SwitchPlayer(var ACurrentPlayer: Integer);

    function CheckWin(x, y, ACurrentPlayer: Integer) : Boolean;
    function IsBoardFull : Boolean;

  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
          { TODO : Oshistit' architekturu GUI Engine }

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
  NewGame;



end;

procedure TForm1.NewGame;
var x, y: Integer;
begin
  FGameOver := False;
  pbBoard.Invalidate;

  for x := 0 to 6 do
    for y := 0 to 5 do
      FBoard[x, y] := 0;

  // Settings CurrentPlayer + Random
  FCurrentPlayer := Random(2) + 1 ; // 1 oder 2
  UpdateCurrentPlayer;


end;

// Label Aktueller Spieler
procedure TForm1.UpdateCurrentPlayer();
begin
  lblCurrentPlayer.Caption := MsgCurrentPlayer(FCurrentPlayer);
  if FCurrentPlayer = 1 then
    lblCurrentPlayer.Font.Color := clRed
  else
    lblCurrentPlayer.Font.Color := clYellow;

end;


procedure TForm1.pbBoardMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var _x, _y: Integer;
begin
  if FGameOver then
    Exit;
  _x := (X div (pbBoard.Width div 7));

  for _y := 5 downto 0 do
    begin
      if FBoard[_x, _y] = 0 then
        begin
          FBoard[_x, _y] := FCurrentPlayer;

          pbBoard.Invalidate;

          if CheckWin(_x, _y, FCurrentPlayer) then
          begin
            FGameOver := True;
            pbBoard.Invalidate;
            Exit;
          end;

          if (IsBoardFull) then
          begin
            ShowMessage(MsgDraw);
            pbBoard.Invalidate;
            Exit;
          end;

          SwitchPlayer(FCurrentPlayer);
          UpdateCurrentPlayer;

          Exit;
        end;
//        ShowMessage('Column=' + IntToStr(Column) +', ' + 'Row=' + IntToStr(Row));
    end;
end;

// var = kopie von CurrentPlayer
procedure TForm1.SwitchPlayer(var ACurrentPlayer: Integer);
begin
  if ACurrentPlayer = 1 then
  begin
    ACurrentPlayer := 2;

  end
  else
    ACurrentPlayer := 1;
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
  NewGame;
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

  case FBoard[x, y] of
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
  lblCurrentPlayer.Caption := MsgCurrentPlayer(FCurrentPlayer);
end;

function TForm1.CheckWin(x, y, ACurrentPlayer : Integer) : Boolean;
var i, j, counterH, counterV, counterD1, counterD2: Integer;
begin
  Result := False;
  counterH := 1;
  counterV := 1;
  counterD1 := 1;
  counterD2 := 1;

  if (x >= 0) and (x <= 6) and (y >= 0) and (y <= 5) then
  begin

    // Horizontal
    i := x - 1;
    while (i >= 0) and (FBoard[i, y] = ACurrentPlayer) do
    begin
       counterH := counterH + 1;
       i := i - 1;
    end;

    i := x + 1;
    while (i <= 6) and (FBoard[i, y] = ACurrentPlayer) do
    begin
      counterH := counterH + 1;
      i := i + 1;
    end;

    // Vertikal
    j := y - 1;
    while (j >= 0) and (FBoard[x, j] = ACurrentPlayer) do
    begin
       counterV := counterV + 1;
       j := j - 1;
    end;

    j := y + 1;
    while (j <= 5) and (FBoard[x, j] = ACurrentPlayer) do
    begin
      counterV := counterV + 1;
      j := j + 1;
    end;

    // X
    i := x - 1;
    j := y - 1;
    while (i >= 0) and (j >= 0) and (FBoard[i, j] = ACurrentPlayer) do
    begin
      counterD1 := counterD1 + 1;
      i := i - 1;
      j := j - 1;
    end;

    i := x + 1;
    j := y + 1;
    while (j <= 5) and (i <= 6) and (FBoard[i, j] = ACurrentPlayer) do
    begin
      counterD1 := counterD1 + 1;
      i := i + 1;
      j := j + 1;
    end;

//  -------------------------------------------------
//  von links nach rechts, von rechts nach links
    i := x + 1;
    j := y - 1;
    while (i <= 6) and (j >= 0) and (FBoard[i, j] = ACurrentPlayer) do
    begin
      counterD2 := counterD2 + 1;
      i := i + 1;
      j := j - 1;
    end;

    i := x - 1;
    j := y + 1;
    while (i >= 0) and (j <= 5) and (FBoard[i, j] = ACurrentPlayer) do
    begin
      counterD2 := counterD2 + 1;
      i := i - 1;
      j := j + 1;
    end;

     OutputDebugString(PChar('CounterH=' + IntToStr(counterH) + ' ' + 'CounterV=' + IntToStr(counterV) + ' ' + 'CounterD1=' + IntToStr(counterD1) + ' ' + 'CounterD2=' + IntToStr(counterD2)));

//    ShowMessage('CounterH=' + IntToStr(counterH) + ' ' + 'CounterV=' + IntToStr(counterV) + ' ' + 'CounterD1=' + IntToStr(counterD1) + ' ' + 'CounterD2=' + IntToStr(counterD2));
    if (counterH >= 4) or (counterV >= 4) or (counterD1 >= 4) or (counterD2 >= 4) then
    begin
      Result := True;
      ShowMessage(MsgPlayerWon(ACurrentPlayer));
      Exit;
    end;

  end;


end;

function TForm1.IsBoardFull : Boolean;
var x : Integer;
begin
  Result := True;
  for x := 0 to 6 do
  begin
    if FBoard[x, 0] = 0 then
    begin
      Result := False;
      Exit;
    end;
  end;

end;

end.
