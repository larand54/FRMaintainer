object dmFR: TdmFR
  OldCreateOrder = False
  Height = 283
  Width = 494
  object tblDBProps: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'dbProps'
    CatalogName = 'vis_vida'
    TableName = 'dbProps'
    Left = 112
    Top = 8
    object tblDBPropsFastPath: TStringField
      FieldName = 'FastPath'
      Origin = 'FastPath'
      Size = 255
    end
  end
  object FDConnection1: TFDConnection
    ConnectionName = 'FastReportConnection'
    Params.Strings = (
      'Server=CARMAK-FASTER\SQLEXPRESS'
      'Database=vis_vida'
      'OSAuthent=No'
      'MetaDefCatalog=vis_vida'
      'MetaDefSchema=dbo'
      'User_Name=sa'
      'Password=woods2011'
      'DriverID=MSSQL')
    Connected = True
    Left = 24
    Top = 8
  end
  object qryFastReports: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT [ReportNo]'
      '      ,[DocType]'
      '      ,[ReportName]'
      '      ,[Description]'
      '      ,[StoredProcName]'
      '      ,[DatasetUserName]'
      '  FROM [vis_vida].[dbo].[FastReportNames]'
      '  ORDER BY [DocType]')
    Left = 200
    Top = 8
    object qryFastReportsReportNo: TIntegerField
      FieldName = 'ReportNo'
      Origin = 'ReportNo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryFastReportsDocType: TIntegerField
      FieldName = 'DocType'
      Origin = 'DocType'
    end
    object qryFastReportsDescription: TStringField
      FieldName = 'Description'
      Origin = 'Description'
      Size = 100
    end
    object qryFastReportsReportName: TStringField
      FieldName = 'ReportName'
      Origin = 'ReportName'
      Size = 100
    end
    object qryFastReportsStoredProcName: TStringField
      FieldName = 'StoredProcName'
      Origin = 'StoredProcName'
      Size = 100
    end
    object qryFastReportsDatasetUserName: TStringField
      FieldName = 'DatasetUserName'
      Origin = 'DatasetUserName'
      Size = 50
    end
  end
  object qrySubreports: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT [ReportNo]'
      '      ,[SubReportName]'
      '      ,[StoredProcName]'
      '      ,[DatasetUserName]'
      '      ,[Description]'
      '  FROM [vis_vida].[dbo].[FastSubReportNames]'
      'WHERE ReportNo = :REPNO')
    Left = 280
    Top = 8
    ParamData = <
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 105
      end>
    object qrySubreportsReportNo: TIntegerField
      FieldName = 'ReportNo'
      Origin = 'ReportNo'
      Required = True
    end
    object qrySubreportsSubReportName: TStringField
      FieldName = 'SubReportName'
      Origin = 'SubReportName'
      Size = 50
    end
    object qrySubreportsStoredProcName: TStringField
      FieldName = 'StoredProcName'
      Origin = 'StoredProcName'
      Size = 100
    end
    object qrySubreportsDatasetUserName: TStringField
      FieldName = 'DatasetUserName'
      Origin = 'DatasetUserName'
      Size = 50
    end
    object qrySubreportsDescription: TStringField
      FieldName = 'Description'
      Origin = 'Description'
      Size = 100
    end
  end
  object qryParamInfo: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select PARAMETER_NAME, DATA_TYPE from information_schema.paramet' +
        'ers'
      'where specific_name=:SP_NAME')
    Left = 352
    Top = 16
    ParamData = <
      item
        Name = 'SP_NAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'get_company_names_inline'
      end>
    object qryParamInfoPARAMETER_NAME: TWideStringField
      FieldName = 'PARAMETER_NAME'
      Origin = 'PARAMETER_NAME'
      Size = 128
    end
    object qryParamInfoDATA_TYPE: TWideStringField
      FieldName = 'DATA_TYPE'
      Origin = 'DATA_TYPE'
      ReadOnly = True
      Required = True
      Size = 128
    end
  end
  object qryFastReport: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT [ReportName]'
      '      ,[StoredProcName]'
      '      ,[DatasetUserName]'
      '  FROM [vis_vida].[dbo].[FastReportNames]'
      '  WHERE ReportNo = :REPNO')
    Left = 112
    Top = 64
    ParamData = <
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 105
      end>
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    CheckboxAsShape = False
    Left = 24
    Top = 88
  end
  object qryInsertFastReport: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO [vis_vida].[dbo].[FastReportNames]'
      '           (ReportNo'
      '           ,DocType'
      '           ,ReportName'
      '           ,Description'
      '           ,StoredProcName'
      '           ,DatasetUserName)'
      '     VALUES'
      '           (:ReportNo'
      '           ,:DocType'
      '           ,:ReportName'
      '           ,:Description'
      '           ,:StoredProcName'
      '           ,:DatasetUserName)'
      '')
    Left = 112
    Top = 120
    ParamData = <
      item
        Name = 'REPORTNO'
        DataType = ftString
        ParamType = ptInput
        Value = '2200'
      end
      item
        Name = 'DOCTYPE'
        DataType = ftString
        ParamType = ptInput
        Value = '2'
      end
      item
        Name = 'REPORTNAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'TestRapport'
      end
      item
        Name = 'DESCRIPTION'
        DataType = ftString
        ParamType = ptInput
        Value = 'En test att insert-sql:en fungerar'
      end
      item
        Name = 'STOREDPROCNAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'SP1_Test'
      end
      item
        Name = 'DATASETUSERNAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'Dataset 1'
      end>
  end
  object spGetNextReportNumber: TFDStoredProc
    Connection = FDConnection1
    SchemaName = 'dbo'
    StoredProcName = 'Vida_GetMaxNo'
    Left = 232
    Top = 112
    ParamData = <
      item
        Position = 1
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        ParamType = ptResult
        Value = 0
      end
      item
        Position = 2
        Name = '@TableName'
        DataType = ftString
        ParamType = ptInput
        Size = 50
        Value = 'FastReportNames'
      end
      item
        Position = 3
        Name = '@MaxNo'
        DataType = ftInteger
        ParamType = ptInputOutput
        Value = 221
      end>
  end
end
