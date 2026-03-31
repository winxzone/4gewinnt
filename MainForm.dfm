object Form1: TForm1
  Left = 0
  Top = 0
  Caption = '4 Gewinnt'
  ClientHeight = 513
  ClientWidth = 810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object pbBoard: TPaintBox
    Left = 151
    Top = 0
    Width = 661
    Height = 518
    Align = alCustom
    Color = clWhite
    ParentColor = False
    OnMouseDown = pbBoardMouseDown
    OnPaint = pbBoardPaint
  end
  object pnlNavigation: TPanel
    Left = -8
    Top = 0
    Width = 161
    Height = 518
    Color = clHighlight
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
      Top = 160
      Width = 137
      Height = 105
      TabOrder = 0
    end
    object rbPlayerVsPlayer: TRadioButton
      Left = 24
      Top = 168
      Width = 113
      Height = 17
      Caption = 'Spieler vs Spieler'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object bNewGame: TButton
    Left = 8
    Top = 443
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
  object cbLanguage: TComboBox
    Left = 8
    Top = 482
    Width = 137
    Height = 23
    TabOrder = 2
    Text = 'cbLanguage'
    OnChange = cbLanguageChange
  end
end
