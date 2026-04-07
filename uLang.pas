unit uLang;

interface

uses
  System.SysUtils;

type
  TLanguage = (de, en, ru);

var CurrentLang: TLanguage;

function MsgPlayerWon(APlayer: String): String;
function MsgDraw: String;
function CaptionNewGame: String;
function MsgCurrentPlayer(APlayer: String): String;
function MsgComputerWon: String;
function MsgComputerCaption: String;
function CaptionSettings: String;
function CaptionGameMode(AIndex: Integer): String;
function CaptionPlayer1: String;
function CaptionPlayer2: String;
function CaptionLanguage: String;
function CaptionSave: String;

implementation

function MsgPlayerWon(APlayer: String): String;
begin
  case CurrentLang of
    en: Result := APlayer + ' has won!';
    de: Result := APlayer + ' hat gewonnen!';
    ru: Result := APlayer + ' pobedil!';
  end;
end;

function MsgComputerWon : String;
begin
  case CurrentLang of
    en: Result := 'Computer has won!';
    de: Result := 'Computer hat gewonnen!';
    ru: Result := 'Computer podebil tebya! Poprobuy snova';
  end;
end;

function MsgDraw: String;
begin
  case CurrentLang of
    en: Result := 'No one has won.';
    de: Result := 'Niemand hat gewonnen.';
    ru: Result := 'Nikto ne pobedil. Loxi'
  end;
end;

function CaptionNewGame: String;
begin
  case CurrentLang of
    en: Result := 'New Game';
    de: Result := 'Neues Spiel';
    ru: Result := 'Novaja Igra';
  end;
end;

function CaptionSettings: String;
begin
  case CurrentLang of
    en: Result := 'Settings';
    de: Result := 'Einstellungen';
    ru: Result := 'Nastroyki';
  end;
end;

function CaptionPlayer1: String;
begin
 case CurrentLang of
    en: Result := 'Player 1';
    de: Result := 'Spieler 1';
    ru: Result := 'Igorek 1';
  end;
end;

function CaptionPlayer2: String;
begin
 case CurrentLang of
    en: Result := 'Player 2';
    de: Result := 'Spieler 2';
    ru: Result := 'Igorek 2';
  end;
end;

function CaptionLanguage: String;
begin
   case CurrentLang of
    en: Result := 'Language';
    de: Result := 'Sprache';
    ru: Result := 'Yazuk';
  end;
end;

function CaptionSave: String;
begin
   case CurrentLang of
    en: Result := 'Save';
    de: Result := 'Speichern';
    ru: Result := 'Sochranit';
  end;
end;

function CaptionGameMode(AIndex: Integer): String;
begin
  case AIndex of
    0: case CurrentLang of
      en: Result := 'Player vs Player';
      de: Result := 'Spieler vs Spieler';
      ru: Result := 'Igrok vs Igrok';
    end;
    1: case CurrentLang of
      en: Result := 'Player vs Computer';
      de: Result := 'Spieler vs Computer';
      ru: Result := 'Igrok vs Komputer';
    end;
  end;
end;

function MsgCurrentPlayer(APlayer: String): String;
begin
  case CurrentLang of
    en: Result := APlayer;
    de: Result := APlayer;
    ru: Result := APlayer;
  end;
end;

function MsgComputerCaption: String;
begin
  case CurrentLang of
    en: Result := 'Computer';
    de: Result := 'Computer';
    ru: Result := 'Komputer';
  end;
end;


end.
