object frmTranslations: TfrmTranslations
  Left = 0
  Top = 0
  Caption = 'Translation maintenance   --  SERVER ALVESQL03'
  ClientHeight = 665
  ClientWidth = 947
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 947
    Height = 121
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 40
      Height = 13
      Caption = 'Text ID:'
    end
    object Label2: TLabel
      Left = 11
      Top = 37
      Width = 37
      Height = 13
      Caption = 'English:'
    end
    object Label3: TLabel
      Left = 5
      Top = 64
      Width = 43
      Height = 13
      Caption = 'Swedish:'
    end
    object lblSelectDBServer: TLabel
      Left = 278
      Top = 10
      Width = 68
      Height = 13
      Caption = 'V'#228'lj DB-server'
    end
    object edTextID: TEdit
      Left = 54
      Top = 7
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'edTextID'
      OnChange = edTextIDChange
      OnExit = edTextIDExit
    end
    object edEnglish: TEdit
      Left = 54
      Top = 34
      Width = 883
      Height = 21
      MaxLength = 120
      TabOrder = 1
      Text = 'edEnglish'
      OnExit = edEnglishExit
    end
    object edSwedish: TEdit
      Left = 54
      Top = 61
      Width = 882
      Height = 21
      MaxLength = 120
      TabOrder = 2
      Text = 'edSwedish'
      OnExit = edSwedishExit
    end
    object btnAdd: TButton
      Left = 49
      Top = 88
      Width = 75
      Height = 25
      Action = acnAdd
      TabOrder = 3
    end
    object btnExit: TButton
      Left = 130
      Top = 88
      Width = 75
      Height = 25
      Action = acnCancel
      TabOrder = 4
    end
    object btnReplicate: TButton
      Left = 376
      Top = 88
      Width = 89
      Height = 25
      Action = acnReplicateTable
      TabOrder = 5
    end
    object btnDltSelected: TButton
      Left = 211
      Top = 88
      Width = 113
      Height = 25
      Action = acnDeleteSelected
      TabOrder = 6
    end
    object cbbSelectDBServer: TComboBox
      Left = 352
      Top = 7
      Width = 145
      Height = 21
      TabOrder = 7
      Text = 'cbbSelectDBServer'
      OnChange = cbbSelectDBServerChange
      Items.Strings = (
        'vistestsql.vida.se'
        'visprodsql.vida.se')
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 127
    Width = 947
    Height = 538
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 1
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 945
      Height = 536
      Align = alClient
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnFocusedRecordChanged = cxGrid1DBTableView1FocusedRecordChanged
        DataController.DataSource = dscTranslation
        DataController.KeyFieldNames = 'TextID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        object cxGrid1DBTableView1TextID: TcxGridDBColumn
          DataBinding.FieldName = 'TextID'
          Options.AutoWidthSizable = False
          Width = 121
        end
        object cxGrid1DBTableView1English: TcxGridDBColumn
          DataBinding.FieldName = 'English'
          Options.AutoWidthSizable = False
          Width = 305
        end
        object cxGrid1DBTableView1Swedish: TcxGridDBColumn
          DataBinding.FieldName = 'Swedish'
          Options.AutoWidthSizable = False
          Width = 346
        end
        object cxGrid1DBTableView1lastChanged: TcxGridDBColumn
          DataBinding.FieldName = 'lastChanged'
          Width = 154
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
  end
  object ActionList1: TActionList
    Left = 136
    Top = 176
    object acnUpdate: TAction
      Caption = 'Update'
      OnExecute = acnUpdateExecute
    end
    object acnAdd: TAction
      Caption = 'Add'
      OnExecute = acnAddExecute
    end
    object acnCancel: TAction
      Caption = 'Cancel'
      OnExecute = acnCancelExecute
    end
    object acnExit: TAction
      Caption = 'Exit'
      OnExecute = acnExitExecute
    end
    object acnFromFile: TAction
      Caption = 'Add/Upd from file'
    end
    object acnReplicateTable: TAction
      Caption = 'ReplicateTable'
      OnExecute = acnReplicateTableExecute
    end
    object acnDeleteSelected: TAction
      Caption = 'Delete Selected'
      OnExecute = acnDeleteSelectedExecute
    end
  end
  object tblTextTranslations: TFDTable
    IndexFieldNames = 'TextID'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'TextTranslation'
    SchemaName = 'dbo'
    TableName = 'TextTranslation'
    Left = 888
    Top = 184
    object tblTextTranslationsTextID: TStringField
      FieldName = 'TextID'
      Origin = 'TextID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 30
    end
    object tblTextTranslationsEnglish: TStringField
      FieldName = 'English'
      Origin = 'English'
      Required = True
      Size = 120
    end
    object tblTextTranslationsSwedish: TStringField
      FieldName = 'Swedish'
      Origin = 'Swedish'
      Required = True
      Size = 120
    end
    object tblTextTranslationslastChanged: TSQLTimeStampField
      FieldName = 'lastChanged'
      Origin = 'lastChanged'
    end
  end
  object dscTranslation: TDataSource
    DataSet = tblTextTranslations
    Left = 888
    Top = 232
  end
  object qryExist: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM TextTranslation WHERE TextID = :TextID')
    Left = 736
    Top = 184
    ParamData = <
      item
        Name = 'TEXTID'
        DataType = ftString
        ParamType = ptInput
        Value = 'CO_LOAD'
      end>
    object qryExistTextID: TStringField
      FieldName = 'TextID'
      Origin = 'TextID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 30
    end
    object qryExistEnglish: TStringField
      FieldName = 'English'
      Origin = 'English'
      Required = True
      Size = 50
    end
    object qryExistSwedish: TStringField
      FieldName = 'Swedish'
      Origin = 'Swedish'
      Required = True
      Size = 50
    end
    object qryExistlastChanged: TSQLTimeStampField
      FieldName = 'lastChanged'
      Origin = 'lastChanged'
    end
  end
  object qryUpd: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'UPDATE [vis_vida].[dbo].[TextTranslation]'
      '   SET [English] = :ENG'
      '      ,[Swedish] = :SWE'
      '      ,[LastChanged] = GETDATE()'
      ' WHERE TextID = :TEXTID')
    Left = 776
    Top = 184
    ParamData = <
      item
        Name = 'ENG'
        DataType = ftString
        ParamType = ptInput
        Value = 'This car shall co-load'
      end
      item
        Name = 'SWE'
        DataType = ftString
        ParamType = ptInput
        Value = 'Denna bil skall samlasta'
      end
      item
        Name = 'TEXTID'
        DataType = ftString
        ParamType = ptInput
        Value = 'CO_LOAD'
      end>
  end
  object qryAdd: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO [vis_vida].[dbo].[TextTranslation]'
      '           (TextID'
      '           ,English'
      '           ,Swedish'
      '           ,LastChanged'
      ')'
      '     VALUES'
      '           (:TEXTID'
      '           ,:ENG'
      '           ,:SWE'
      '           ,GETDATE())')
    Left = 816
    Top = 184
    ParamData = <
      item
        Name = 'TEXTID'
        DataType = ftString
        ParamType = ptInput
        Value = 'CO_LOAD'
      end
      item
        Name = 'ENG'
        DataType = ftString
        ParamType = ptInput
        Value = 'This car shall co-load'
      end
      item
        Name = 'SWE'
        DataType = ftString
        ParamType = ptInput
        Value = 'Denna bil skall samlasta'
      end>
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Server=visprodsql.vida.se'
      'Database=vis_vida'
      'OSAuthent=No'
      'MetaDefCatalog=vis_vida'
      'MetaDefSchema=dbo'
      'User_Name=Lars'
      'Password=woods2011'
      'DriverID=MSSQL')
    FetchOptions.AssignedValues = [evCursorKind]
    LoginPrompt = False
    Left = 232
    Top = 176
  end
  object qryReplicateSrc: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM TextTranslation')
    Left = 568
    Top = 184
    object qryReplicateSrcTextID: TStringField
      FieldName = 'TextID'
      Origin = 'TextID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 30
    end
    object qryReplicateSrcEnglish: TStringField
      FieldName = 'English'
      Origin = 'English'
      Required = True
      Size = 50
    end
    object qryReplicateSrcSwedish: TStringField
      FieldName = 'Swedish'
      Origin = 'Swedish'
      Required = True
      Size = 50
    end
    object qryReplicateSrclastChanged: TSQLTimeStampField
      FieldName = 'lastChanged'
      Origin = 'lastChanged'
    end
  end
  object qryReplicateTarget: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO [VIS_VIDA].[dbo].[TextTranslation]'
      '           ([TextID]'
      '           ,[English]'
      '           ,[Swedish]'
      '           ,[lastChanged])'
      '     VALUES'
      '           (:TextID'
      '           ,:English'
      '           ,:Swedish'
      '           ,:lastChanged)')
    Left = 656
    Top = 184
    ParamData = <
      item
        Name = 'TEXTID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ENGLISH'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SWEDISH'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'LASTCHANGED'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryTruncTarget: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'TRUNCATE TABLE [VIS_VIDA].[dbo].[TextTranslation]')
    Left = 656
    Top = 240
  end
  object qryDelete: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'DELETE FROM [VIS_VIDA].[dbo].[TextTranslation]'
      '      WHERE TextID = :TextID')
    Left = 736
    Top = 256
    ParamData = <
      item
        Name = 'TEXTID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
