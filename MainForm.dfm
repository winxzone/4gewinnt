object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = '4 Gewinnt'
  ClientHeight = 567
  ClientWidth = 868
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pbBoard: TPaintBox
    Left = 151
    Top = 0
    Width = 714
    Height = 573
    Align = alCustom
    Color = clWhite
    ParentColor = False
    OnMouseDown = pbBoardMouseDown
    OnPaint = pbBoardPaint
  end
  object pnlNavigation: TPanel
    Left = -8
    Top = -5
    Width = 161
    Height = 578
    Color = clCornflowerblue
    ParentBackground = False
    TabOrder = 0
    object lblCurrentPlayer: TLabel
      Left = 24
      Top = 16
      Width = 50
      Height = 31
      Caption = 'text'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Elephant'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object rgGameMode: TRadioGroup
      Left = 16
      Top = 360
      Width = 140
      Height = 64
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      DefaultHeaderFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clHighlight
      HeaderFont.Height = -12
      HeaderFont.Name = 'Segoe UI'
      HeaderFont.Style = []
      Items.Strings = (
        'Player vs Player'
        'Easy')
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnClick = rgGameModeClick
    end
    object bNewGame: TButton
      Left = 16
      Top = 467
      Width = 137
      Height = 33
      Caption = 'Neues Spiel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = bNewGameClick
    end
    object rgSizeBoard: TRadioGroup
      Left = 16
      Top = 248
      Width = 137
      Height = 97
      Items.Strings = (
        '7x6'
        '8x7'
        '9x8')
      TabOrder = 2
      OnClick = rgSizeBoardClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 184
    Top = 32
    object N1: TMenuItem
      Caption = 'New Game'
      OnClick = N1Click
    end
    object Settings1: TMenuItem
      Caption = 'Settings'
      OnClick = Settings1Click
    end
  end
end
