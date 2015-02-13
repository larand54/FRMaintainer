object frmSubReportSettings: TfrmSubReportSettings
  Left = 0
  Top = 0
  Caption = 'SubReportSettings'
  ClientHeight = 163
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblTemplate_Name: TLabel
    Left = 32
    Top = 32
    Width = 81
    Height = 13
    Caption = 'Subreport name:'
  end
  object lblSP_Name: TLabel
    Left = 34
    Top = 56
    Width = 88
    Height = 13
    Caption = 'Stored procedure:'
  end
  object lblDS_Name: TLabel
    Left = 32
    Top = 81
    Width = 42
    Height = 13
    Caption = 'Dataset:'
  end
  object edName: TEdit
    Left = 128
    Top = 29
    Width = 121
    Height = 21
    TabOrder = 0
    OnExit = edNameExit
  end
  object edStoredProc: TEdit
    Left = 128
    Top = 53
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edDataset: TEdit
    Left = 128
    Top = 78
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 174
    Top = 119
    Width = 75
    Height = 25
    Caption = 'Apply'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 80
    Top = 119
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
end
