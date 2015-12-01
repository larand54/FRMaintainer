object frmCopyTables: TfrmCopyTables
  Left = 0
  Top = 0
  Caption = 'Copy Database tables'
  ClientHeight = 552
  ClientWidth = 792
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
    Width = 3
    Height = 13
  end
  object rgDest: TRadioGroup
    Left = 24
    Top = 127
    Width = 185
    Height = 90
    Caption = 'Destination server'
    ItemIndex = 2
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
    ItemIndex = 1
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
      'FastSubReportNames'
      'DocType'
      'ClientPrefDocFR')
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
  object DBGrid1: TDBGrid
    Left = 8
    Top = 232
    Width = 776
    Height = 290
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 136
    Top = 528
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 5
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
  object qrySrc: TFDQuery
    Connection = destConnection
    Left = 496
    Top = 120
  end
  object qryDest: TFDQuery
    Connection = destConnection
    Left = 496
    Top = 176
  end
  object qryTruncTarget: TFDQuery
    Connection = destConnection
    Left = 496
    Top = 232
  end
  object tblSrc: TFDTable
    Connection = srcConnection
    Left = 416
    Top = 128
  end
  object tblDest: TFDTable
    AfterClose = tblDestAfterPost
    Connection = destConnection
    UpdateOptions.UpdateTableName = 'VIS_VIDA.dbo.DocType'
    TableName = 'VIS_VIDA.dbo.DocType'
    Left = 416
    Top = 184
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 416
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = tblDest
    Left = 32
    Top = 392
  end
end
