object dmFR: TdmFR
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 615
  Width = 1008
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
    object tblDBPropsLangPath: TStringField
      FieldName = 'LangPath'
      Origin = 'LangPath'
      Size = 255
    end
  end
  object qryFastReports: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT [ReportNo]'
      '      ,[DocType]'
      '      ,[ReportName]'
      '      ,[Description]'
      '      ,[StoredProcName]'
      '      ,[DatasetUserName],'
      'dt.Name'
      
        '  FROM [vis_vida].[dbo].[FastReportNames] frn join [vis_vida].[d' +
        'bo].[DocType] dt on dt.id = frn.DocType '
      'Order By dt.Name')
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
    object qryFastReportsName: TStringField
      FieldName = 'Name'
      Origin = 'Name'
      Size = 30
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
        Value = ''
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
      '           (:REPNO'
      '           ,:DOCTYPE'
      '           ,:TEMPLATE'
      '           ,:DESCR'
      '           ,:STPROC'
      '           ,:DATASET)'
      '')
    Left = 112
    Top = 120
    ParamData = <
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DOCTYPE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2
      end
      item
        Name = 'TEMPLATE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DESCR'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'STPROC'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATASET'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object spGetNextReportNumber: TFDStoredProc
    Connection = FDConnection1
    SchemaName = 'dbo'
    StoredProcName = 'Vida_GetMaxNo'
    Left = 464
    Top = 16
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
  object qrySubReport: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT [SubReportName]'
      '      ,[StoredProcName]'
      '      ,[DatasetUserName]'
      '  FROM [vis_vida].[dbo].[FastSubReportNames]'
      '  WHERE ReportNo = :REPNO AND'
      'SubReportName = :NAME')
    Left = 216
    Top = 64
    ParamData = <
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 105
      end
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'certWoodInv'
      end>
  end
  object qryUpdateFastReport: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'UPDATE [vis_vida].[dbo].[FastReportNames]'
      '   SET [DocType] = :DOCTYPE'
      '      ,[ReportName] = :TEMPLATE'
      '      ,[Description] = :DESCR'
      '      ,[StoredProcName] = :STPROC'
      '      ,[DatasetUserName] = :DATASET'
      ' WHERE ReportNo = :REPNO '
      '    ')
    Left = 232
    Top = 120
    ParamData = <
      item
        Name = 'DOCTYPE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 3
      end
      item
        Name = 'TEMPLATE'
        DataType = ftString
        ParamType = ptInput
        Value = 'test55'
      end
      item
        Name = 'DESCR'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'STPROC'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATASET'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2200
      end>
  end
  object qryInsertSubReport: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO [vis_vida].[dbo].[FastSubReportNames]'
      '           (ReportNo'
      '           ,SubReportName'
      '           ,Description'
      '           ,StoredProcName'
      '           ,DatasetUserName)'
      '     VALUES'
      '           (:REPNO'
      '           ,:SRNAME'
      '           ,:DESCR'
      '           ,:STPROC'
      '           ,:DATASET)')
    Left = 120
    Top = 192
    ParamData = <
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2200
      end
      item
        Name = 'SRNAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'SUBREP_no1'
      end
      item
        Name = 'DESCR'
        DataType = ftString
        ParamType = ptInput
        Value = 'My Description of a subreport'
      end
      item
        Name = 'STPROC'
        DataType = ftString
        ParamType = ptInput
        Value = 'SP1'
      end
      item
        Name = 'DATASET'
        DataType = ftString
        ParamType = ptInput
        Value = 'DS1'
      end>
  end
  object qryUpdateSubReport: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'UPDATE [vis_vida].[dbo].[FastSubReportNames]'
      '   SET [Description] = :DESCR'
      '      ,[StoredProcName] = :STPROCNAME'
      '      ,[DatasetUserName] = :DSNAME'
      ' WHERE ReportNo = :REPNO AND SubReportName = :SRNAME')
    Left = 256
    Top = 192
    ParamData = <
      item
        Name = 'DESCR'
        DataType = ftString
        ParamType = ptInput
        Value = 'Changed the description'
      end
      item
        Name = 'STPROCNAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'SPSR25'
      end
      item
        Name = 'DSNAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'DSSR25'
      end
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2200
      end
      item
        Name = 'SRNAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'SUBREPORT1'
      end>
  end
  object qryDeleteReport: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'DELETE FROM FastReportNames '
      'WHERE ReportNo = :REPNO')
    Left = 392
    Top = 144
    ParamData = <
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 3000
      end>
  end
  object qryDeleteSubreport: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'DELETE FROM FastSubreportNames '
      'WHERE ReportNo = :REPNO AND'
      '      SubReportName = :SRNAME')
    Left = 384
    Top = 208
    ParamData = <
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 3000
      end
      item
        Name = 'SRNAME'
        DataType = ftString
        ParamType = ptInput
        Value = 'SubReport1'
      end>
  end
  object qryDeleteSubreports: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'DELETE FROM FastSubReportNames'
      'WHERE ReportNo = :REPNO')
    Left = 488
    Top = 216
    ParamData = <
      item
        Name = 'REPNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 3000
      end>
  end
  object qryDocType: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT [id],[Name]'
      ' FROM [vis_vida].[dbo].[DocType]'
      'order by Name')
    Left = 312
    Top = 128
    object qryDocTypeid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      Required = True
    end
    object qryDocTypeName: TStringField
      FieldName = 'Name'
      Origin = 'Name'
    end
  end
  object qryFRByName: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT ReportNo '
      'FROM FastReportNames frn '
      'WHERE frn.ReportName = :NAME')
    Left = 288
    Top = 80
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
      end>
    object qryFRByNameReportNo: TIntegerField
      FieldName = 'ReportNo'
      Origin = 'ReportNo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object sqGetDocs: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evCache]
    SQL.Strings = (
      'Select * from dbo.ClientPrefDocFR cpd'
      'Inner Join dbo.FastReportNames rn on rn.ReportNo = cpd.ReportNo'
      'WHERE cpd.ClientNo = :ClientNo'
      'AND cpd.RoleType = :RoleType'
      'AND cpd.DocType = :DocType')
    Left = 496
    Top = 152
    ParamData = <
      item
        Name = 'CLIENTNO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ROLETYPE'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'DOCTYPE'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object sqGetDocsNoOfCopy: TIntegerField
      FieldName = 'NoOfCopy'
      Origin = 'NoOfCopy'
    end
    object sqGetDocspromptUser: TIntegerField
      FieldName = 'promptUser'
      Origin = 'promptUser'
    end
    object sqGetDocscollated: TIntegerField
      FieldName = 'collated'
      Origin = 'collated'
    end
    object sqGetDocsPrinterSetup: TIntegerField
      FieldName = 'PrinterSetup'
      Origin = 'PrinterSetup'
    end
    object sqGetDocsReportName: TStringField
      FieldName = 'ReportName'
      Origin = 'ReportName'
      Size = 100
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Server=alvesql03'
      'Database=vis_vida'
      'OSAuthent=No'
      'MetaDefCatalog=vis_vida'
      'MetaDefSchema=dbo'
      'User_Name=Lars'
      'Password=woods2011'
      'DriverID=MSSQL')
    Left = 184
    Top = 320
  end
end
