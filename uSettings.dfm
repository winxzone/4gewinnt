object Settings: TSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 308
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 243
    Height = 308
    Align = alClient
    Color = clCornflowerblue
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 19
      Width = 47
      Height = 15
      Caption = 'Spieler 1 '
    end
    object Label2: TLabel
      Left = 24
      Top = 67
      Width = 44
      Height = 15
      Caption = 'Spieler 2'
    end
    object Label3: TLabel
      Left = 24
      Top = 137
      Width = 42
      Height = 15
      Caption = 'Sprache'
    end
    object ePlayerName1: TEdit
      Left = 24
      Top = 40
      Width = 193
      Height = 23
      MaxLength = 14
      TabOrder = 0
    end
    object ePlayerName2: TEdit
      Left = 24
      Top = 88
      Width = 193
      Height = 23
      MaxLength = 14
      TabOrder = 1
    end
    object Button1: TButton
      Left = 64
      Top = 248
      Width = 113
      Height = 33
      Caption = 'Speichern'
      TabOrder = 2
      OnClick = Button1Click
    end
    object cbLanguage: TComboBox
      Left = 24
      Top = 158
      Width = 129
      Height = 23
      TabOrder = 3
      Text = 'cbLanguage'
      OnChange = cbLanguageChange
    end
  end
end
