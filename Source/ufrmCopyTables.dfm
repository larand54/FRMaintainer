object frmCopyTables: TfrmCopyTables
  Left = 0
  Top = 0
  Caption = 'Copy Database tables'
  ClientHeight = 290
  ClientWidth = 554
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
    Left = 35
    Top = 248
    Width = 454
    Height = 13
  end
  object rgDest: TRadioGroup
    Left = 24
    Top = 127
    Width = 185
    Height = 90
    Caption = 'Destination server'
    Items.Strings = (
      'Alvesql01'
      'Alvesql03'
      'AlvesqlTest01')
    TabOrder = 0
    OnClick = rgDestClick
  end
  object rgSource: TRadioGroup
    Left = 24
    Top = 15
    Width = 185
    Height = 90
    Caption = 'Source server'
    Items.Strings = (
      'Alvesql01'
      'Alvesql03'
      'AlvesqlTest01')
    TabOrder = 1
    OnClick = rgSourceClick
  end
  object rgDBTable: TRadioGroup
    Left = 215
    Top = 15
    Width = 185
    Height = 90
    Caption = 'Table to copy'
    Items.Strings = (
      'FastReportNames'
      'FastSubReportNames')
    TabOrder = 2
    OnClick = rgDBTableClick
  end
  object BitBtn1: TBitBtn
    Left = 248
    Top = 152
    Width = 152
    Height = 65
    Caption = 'Copy'
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BatchMove1: TBatchMove
    Destination = tblDest
    Mode = batAppendUpdate
    Source = tblSource
    Left = 496
    Top = 112
  end
  object tblSource: TTable
    Left = 432
    Top = 8
  end
  object tblDest: TTable
    AfterPost = tblDestAfterPost
    Left = 432
    Top = 56
  end
  object destConnection: TFDConnection
    Params.Strings = (
      'Database=vis_vida'
      'User_Name=Lars'
      'Password=woods2011'
      'OSAuthent=No'
      'Server=alvesql03'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 496
    Top = 56
  end
  object srcConnection: TFDConnection
    Params.Strings = (
      'Database=vis_vida'
      'User_Name=Lars'
      'Password=woods2011'
      'Server=alvesql03'
      'OSAuthent=No'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 496
    Top = 8
  end
end
