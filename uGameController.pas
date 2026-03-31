unit uGameController;

interface

uses Vcl.Dialogs, Winapi.Windows, System.SysUtils;

type

  TGameController = class
  private
    FCurrentPlayer: Integer;
    FBoard: array[0..6, 0..5] of Integer;
    FGameOver: Boolean;
    function GetCell(x, y: Integer): Integer;
    procedure SwitchPlayer(var ACurrentPlayer: Integer);
    function CheckWin(x, y, ACurrentPlayer : Integer) : Boolean;
  public
    property Cells[x, y: Integer]: Integer read GetCell;
    procedure NewGame;
    function GetCurrentPlayer : Integer;
    procedure MakeMove(x: Integer);
    function IsGameOver : Boolean;
    function IsBoardFull : Boolean;
  end;

implementation

function TGameController.GetCell(x, y:Integer) : Integer;
begin
   Result := FBoard[x, y];
end;

procedure TGameController.NewGame;
var x, y: Integer;
begin
  FGameOver := False;

   for x := 0 to 6 do
    for y := 0 to 5 do
      FBoard[x, y] := 0;

  // Settings CurrentPlayer + Random
  FCurrentPlayer := Random(2) + 1 ; // 1 oder 2

end;

function TGameController.GetCurrentPlayer : Integer;
begin
  Result := FCurrentPlayer;
end;

procedure TGameController.SwitchPlayer(var ACurrentPlayer: Integer);
begin
if ACurrentPlayer = 1 then
  begin
    ACurrentPlayer := 2;

  end
  else
    ACurrentPlayer := 1;
end;

procedure TGameController.MakeMove(x: Integer);
var y: Integer;
begin
  if FGameOver then Exit;

  for y := 5 downto 0 do
  begin
    if FBoard[x, y] = 0 then
    begin
      FBoard[x, y] := FCurrentPlayer;

      if CheckWin(x, y, FCurrentPlayer) then
        FGameOver := True
      else if IsBoardFull then
      begin
        FGameOver := True;
      end
      else
        SwitchPlayer(FCurrentPlayer);

        Exit;
    end;

  end;
end;


function TGameController.IsGameOver : Boolean;
begin
  Result := FGameOver;
end;

function TGameController.CheckWin(x, y, ACurrentPlayer : Integer) : Boolean;
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
//      ShowMessage(MsgPlayerWon(ACurrentPlayer));
      Exit;
    end;

  end;
end;


function TGameController.IsBoardFull : Boolean;
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

