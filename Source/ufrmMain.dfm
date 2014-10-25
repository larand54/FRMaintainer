object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Fast Report Mainteenance'
  ClientHeight = 598
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 37
    Width = 112
    Height = 13
    Caption = 'List of available reports'
  end
  object GroupBox1: TGroupBox
    Left = 432
    Top = 40
    Width = 145
    Height = 265
    Caption = 'Reports'
    TabOrder = 0
    object Button4: TButton
      Left = 38
      Top = 208
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 0
    end
    object Button3: TButton
      Left = 38
      Top = 152
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 1
    end
    object Button2: TButton
      Left = 38
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Edit'
      TabOrder = 2
    end
    object Button1: TButton
      Left = 38
      Top = 40
      Width = 75
      Height = 25
      Caption = 'New'
      TabOrder = 3
    end
  end
  object ReportTree: TTreeView
    Left = 40
    Top = 56
    Width = 265
    Height = 489
    Indent = 19
    TabOrder = 1
  end
  object FDQuery1: TFDQuery
    Left = 368
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 312
    Top = 16
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 248
    Top = 16
  end
end
