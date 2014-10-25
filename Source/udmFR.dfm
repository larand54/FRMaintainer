object dmFR: TdmFR
  OldCreateOrder = False
  Height = 322
  Width = 215
  object tblDBProps: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'dbProps'
    CatalogName = 'vis_vida'
    TableName = 'dbProps'
    Left = 48
    Top = 24
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
    Left = 144
    Top = 32
  end
  object qryFastReports: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT [ReportNo]'
      '      ,[DocType]'
      '      ,[ReportName]'
      '      ,[Beskrivning]'
      '      ,[StoredProcName]'
      '      ,[DatasetUserName]'
      '  FROM [vis_vida].[dbo].[FastReportNames]')
    Left = 40
    Top = 80
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
    object qryFastReportsReportName: TStringField
      FieldName = 'ReportName'
      Origin = 'ReportName'
      Size = 100
    end
    object qryFastReportsBeskrivning: TStringField
      FieldName = 'Beskrivning'
      Origin = 'Beskrivning'
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
      '  FROM [vis_vida].[dbo].[FastSubReportNames]')
    Left = 48
    Top = 128
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
  object qryParam: TFDQuery
    Connection = FDConnection1
    Left = 32
    Top = 176
  end
  object qryParamSR: TFDQuery
    Connection = FDConnection1
    Left = 32
    Top = 232
  end
  object qryParamInfo: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select PARAMETER_NAME, DATA_TYPE from information_schema.paramet' +
        'ers'
      'where specific_name=:SP_NAME')
    Left = 136
    Top = 216
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
end
