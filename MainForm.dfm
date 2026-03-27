object Form1: TForm1
  Left = 0
  Top = 0
  Caption = '4 Gewinnt'
  ClientHeight = 437
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object PaintBox1: TPaintBox
    Left = 151
    Top = 0
    Width = 501
    Height = 437
    Align = alCustom
    Color = clWhite
    ParentColor = False
    OnMouseDown = PaintBox1MouseDown
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = -8
    Top = 0
    Width = 161
    Height = 441
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object LCurrentPlayer: TLabel
      Left = 43
      Top = 16
      Width = 44
      Height = 23
      Caption = 'text'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object Button1: TButton
    Left = 8
    Top = 357
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
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 396
    Width = 137
    Height = 33
    Caption = 'Beenden'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
end
