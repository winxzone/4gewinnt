unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    PaintBox1: TPaintBox;
    Button2: TButton;
    LCurrentPlayer: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    CurrentPlayer: Integer;
    Feld: array[0..6, 0..5] of Integer;
    procedure NewGame;
    procedure CirclePaint(x, y: Integer);
    procedure LCurrentPlayerUpdate;
    procedure SwitchPlayer(var Player: Integer);

    function CheckWin(x, y, Player : Integer) : Boolean;


  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  NewGame;
end;

procedure TForm1.NewGame;
var x, y: Integer;
begin
  PaintBox1.Invalidate;

  for x := 0 to 6 do
    for y := 0 to 5 do
      Feld[x, y] := 0;

  // Settings CurrentPlayer + Random
  CurrentPlayer := Random(2) + 1 ; // 1 oder 2
  LCurrentPlayerUpdate;


end;

// Label Aktueller Spieler
procedure TForm1.LCurrentPlayerUpdate();
begin
  LCurrentPlayer.Caption := 'Player ' + IntToStr(CurrentPlayer);
  if CurrentPlayer = 1 then
    LCurrentPlayer.Font.Color := clRed
  else
    LCurrentPlayer.Font.Color := clBlue;

  LCurrentPlayer.Update;

end;


procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var _x, _y: Integer;
begin
  _x := (X div (PaintBox1.Width div 7));

  for _y := 5 downto 0 do
    begin
      if Feld[_x, _y] = 0 then
        begin
          Feld[_x, _y] := CurrentPlayer;

          CheckWin(_x, _y, CurrentPlayer);

          SwitchPlayer(CurrentPlayer);
          LCurrentPlayerUpdate;

          PaintBox1.Invalidate;

          Exit;
        end;
//        ShowMessage('Column=' + IntToStr(Column) +', ' + 'Row=' + IntToStr(Row));
    end;
end;

// var = kopie von CurrentPlayer
procedure TForm1.SwitchPlayer(var Player: Integer);
begin
  if Player = 1 then
  begin
    Player := 2;

  end
  else
    Player := 1;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var x, y: Integer;
begin
    PaintBox1.Canvas.Brush.Color := clWhite;

    for x := 0 to 6 do
    for y := 0 to 5 do
      CirclePaint(x, y);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  NewGame;
end;

procedure TForm1.CirclePaint(x, y: Integer);
var
  radius, cx, cy: Integer;
  CellWidth, CellHeight: Integer;
  R: TRect;
begin

  CellWidth := PaintBox1.Width div 7;
  CellHeight := PaintBox1.Height div 6;

  cx := x * CellWidth + CellWidth div 2;
  cy := y * CellHeight + CellHeight div 2;

  radius := 25;

  R := Rect(cx - radius, cy - radius, cx + radius, cy + radius);
  PaintBox1.Canvas.Brush.Color := clWhite;

  case Feld[x, y] of
    0: PaintBox1.Canvas.Brush.Color := clWhite;
    1: PaintBox1.Canvas.Brush.Color := clRed;
    2: PaintBox1.Canvas.Brush.Color := clBlue;
  end;

  PaintBox1.Canvas.Pen.Color := clBlack;
  PaintBox1.Canvas.Pen.Width := 2;
  PaintBox1.Canvas.Ellipse(R);
end;

function TForm1.CheckWin(x, y, Player : Integer) : Boolean;
var i, counter: Integer;
begin
  Result := False;
  counter := 1;

  if (x >= 0) and (x < 7) and (y >= 0) and (y <= 5) then
  begin

    i := x - 1;
    while (i >= 0) and (Feld[i, y] = Player) do
    begin
       counter := counter + 1;
       i := i - 1;
    end;

    i := x + 1;
    while (i < 7) and (Feld[i, y] = Player) do
    begin
      counter := counter + 1;
      i := i + 1;
    end;

//    ShowMessage('Count=' + inttostr(counter));

    if counter = 4 then
    begin
      Result := True;
      Exit;
      ShowMessage('Player ' + IntToStr(Player) + ' hat gewonnen!!!');
    end;

  end;

end;

end.
