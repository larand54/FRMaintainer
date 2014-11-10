object dmFR: TdmFR
  OldCreateOrder = False
  Height = 283
  Width = 623
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
  object siLang1: TsiLang
    Version = '7.2'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    LangDispatcher = siLangDispatcher1
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Swedish')
    Language = 'English'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields'
      'SQL'
      'DeleteSQL'
      'UpdateSQL'
      'ModifySQL'
      'KeyFields'
      'LookupKeyFields'
      'LookupResultField'
      'DataField'
      'KeyField'
      'ListField')
    Left = 400
    Top = 88
    TranslationData = {
      73007400430061007000740069006F006E0073005F0055006E00690063006F00
      640065000D000A0073007400480069006E00740073005F0055006E0069006300
      6F00640065000D000A007300740044006900730070006C00610079004C006100
      620065006C0073005F0055006E00690063006F00640065000D000A0074006200
      6C0044004200500072006F007000730046006100730074005000610074006800
      010046006100730074005000610074006800010001000D000A00710072007900
      46006100730074005200650070006F007200740073005200650070006F007200
      74004E006F0001005200650070006F00720074004E006F00010001000D000A00
      71007200790046006100730074005200650070006F0072007400730044006F00
      63005400790070006500010044006F0063005400790070006500010001000D00
      0A0071007200790046006100730074005200650070006F007200740073004400
      650073006300720069007000740069006F006E00010044006500730063007200
      69007000740069006F006E00010001000D000A00710072007900460061007300
      74005200650070006F007200740073005200650070006F00720074004E006100
      6D00650001005200650070006F00720074004E0061006D006500010001000D00
      0A0071007200790046006100730074005200650070006F007200740073005300
      74006F00720065006400500072006F0063004E0061006D006500010053007400
      6F00720065006400500072006F0063004E0061006D006500010001000D000A00
      71007200790046006100730074005200650070006F0072007400730044006100
      7400610073006500740055007300650072004E0061006D006500010044006100
      7400610073006500740055007300650072004E0061006D006500010001000D00
      0A007100720079005300750062007200650070006F0072007400730052006500
      70006F00720074004E006F0001005200650070006F00720074004E006F000100
      01000D000A007100720079005300750062007200650070006F00720074007300
      5300750062005200650070006F00720074004E0061006D006500010053007500
      62005200650070006F00720074004E0061006D006500010001000D000A007100
      720079005300750062007200650070006F00720074007300530074006F007200
      65006400500072006F0063004E0061006D0065000100530074006F0072006500
      6400500072006F0063004E0061006D006500010001000D000A00710072007900
      5300750062007200650070006F00720074007300440061007400610073006500
      740055007300650072004E0061006D0065000100440061007400610073006500
      740055007300650072004E0061006D006500010001000D000A00710072007900
      5300750062007200650070006F00720074007300440065007300630072006900
      7000740069006F006E0001004400650073006300720069007000740069006F00
      6E00010001000D000A0071007200790050006100720061006D0049006E006600
      6F0050004100520041004D0045005400450052005F004E0041004D0045000100
      50004100520041004D0045005400450052005F004E0041004D00450001000100
      0D000A0071007200790050006100720061006D0049006E0066006F0044004100
      540041005F005400590050004500010044004100540041005F00540059005000
      4500010001000D000A00740062006C0044004200500072006F00700073004C00
      61006E006700500061007400680001004C0061006E0067005000610074006800
      010001000D000A007300740046006F006E00740073005F0055006E0069006300
      6F00640065000D000A00730074004D0075006C00740069004C0069006E006500
      73005F0055006E00690063006F00640065000D000A004600440043006F006E00
      6E0065006300740069006F006E0031002E0050006100720061006D0073000100
      5300650072007600650072003D004300410052004D0041004B002D0046004100
      53005400450052005C00530051004C0045005800500052004500530053002C00
      440061007400610062006100730065003D007600690073005F00760069006400
      61002C004F005300410075007400680065006E0074003D004E006F002C004D00
      65007400610044006500660043006100740061006C006F0067003D0076006900
      73005F0076006900640061002C004D0065007400610044006500660053006300
      680065006D0061003D00640062006F002C0055007300650072005F004E006100
      6D0065003D00730061002C00500061007300730077006F00720064003D007700
      6F006F006400730032003000310031002C004400720069007600650072004900
      44003D004D005300530051004C00010001000D000A007300740044006C006700
      7300430061007000740069006F006E0073005F0055006E00690063006F006400
      65000D000A005700610072006E0069006E00670001005700610072006E006900
      6E006700010001000D000A004500720072006F00720001004500720072006F00
      7200010001000D000A0049006E0066006F0072006D006100740069006F006E00
      010049006E0066006F0072006D006100740069006F006E00010001000D000A00
      43006F006E006600690072006D00010043006F006E006600690072006D000100
      01000D000A0059006500730001002600590065007300010001000D000A004E00
      6F00010026004E006F00010001000D000A004F004B0001004F004B0001000100
      0D000A00430061006E00630065006C000100430061006E00630065006C000100
      01000D000A00410062006F007200740001002600410062006F00720074000100
      01000D000A005200650074007200790001002600520065007400720079000100
      01000D000A00490067006E006F007200650001002600490067006E006F007200
      6500010001000D000A0041006C006C000100260041006C006C00010001000D00
      0A004E006F00200054006F00200041006C006C0001004E0026006F0020007400
      6F00200041006C006C00010001000D000A00590065007300200054006F002000
      41006C006C000100590065007300200074006F002000260041006C006C000100
      01000D000A00480065006C00700001002600480065006C007000010001000D00
      0A007300740053007400720069006E00670073005F0055006E00690063006F00
      640065000D000A004900440053005F0030000100440061007400610074007900
      7000650020006900730020006E006F00740020006E0075006D00650072006900
      63002100010001000D000A004900440053005F003100010043006F0075006C00
      640020006E006F00740020006300720065006100740065002000720065007000
      6F00720074002100200020002D002D002D002000430061007500730065003A00
      010001000D000A004900440053005F0032000100520065007100750065007300
      74006500640020007200650070006F007200740020006E0075006D0062006500
      72003A002000010001000D000A004900440053005F0033000100200077006100
      730020006E006F007400200066006F0075006E006400200069006E0020007400
      680065002000640061007400610062006100730065002100010001000D000A00
      730074004F00740068006500720053007400720069006E00670073005F005500
      6E00690063006F00640065000D000A00740062006C0044004200500072006F00
      700073002E0043006100740061006C006F0067004E0061006D00650001007600
      690073005F007600690064006100010001000D000A00740062006C0044004200
      500072006F00700073002E0043006F006E006E0065006300740069006F006E00
      4E0061006D006500010046006100730074005200650070006F00720074004300
      6F006E006E0065006300740069006F006E00010001000D000A00740062006C00
      44004200500072006F0070007300460061007300740050006100740068002E00
      4F0072006900670069006E000100460061007300740050006100740068000100
      01000D000A004600440043006F006E006E0065006300740069006F006E003100
      2E0043006F006E006E0065006300740069006F006E004E0061006D0065000100
      46006100730074005200650070006F007200740043006F006E006E0065006300
      740069006F006E00010001000D000A004600440043006F006E006E0065006300
      740069006F006E0031002E004400720069007600650072004E0061006D006500
      01004D005300530051004C00010001000D000A00710072007900460061007300
      74005200650070006F007200740073002E0043006F006E006E00650063007400
      69006F006E004E0061006D006500010046006100730074005200650070006F00
      7200740043006F006E006E0065006300740069006F006E00010001000D000A00
      71007200790046006100730074005200650070006F0072007400730052006500
      70006F00720074004E006F002E004F0072006900670069006E00010052006500
      70006F00720074004E006F00010001000D000A00710072007900460061007300
      74005200650070006F0072007400730044006F00630054007900700065002E00
      4F0072006900670069006E00010044006F006300540079007000650001000100
      0D000A0071007200790046006100730074005200650070006F00720074007300
      4400650073006300720069007000740069006F006E002E004F00720069006700
      69006E0001004400650073006300720069007000740069006F006E0001000100
      0D000A0071007200790046006100730074005200650070006F00720074007300
      5200650070006F00720074004E0061006D0065002E004F007200690067006900
      6E0001005200650070006F00720074004E0061006D006500010001000D000A00
      71007200790046006100730074005200650070006F0072007400730053007400
      6F00720065006400500072006F0063004E0061006D0065002E004F0072006900
      670069006E000100530074006F00720065006400500072006F0063004E006100
      6D006500010001000D000A007100720079004600610073007400520065007000
      6F00720074007300440061007400610073006500740055007300650072004E00
      61006D0065002E004F0072006900670069006E00010044006100740061007300
      6500740055007300650072004E0061006D006500010001000D000A0071007200
      79005300750062007200650070006F007200740073002E0043006F006E006E00
      65006300740069006F006E004E0061006D006500010046006100730074005200
      650070006F007200740043006F006E006E0065006300740069006F006E000100
      01000D000A007100720079005300750062007200650070006F00720074007300
      5200650070006F00720074004E006F002E004F0072006900670069006E000100
      5200650070006F00720074004E006F00010001000D000A007100720079005300
      750062007200650070006F007200740073005300750062005200650070006F00
      720074004E0061006D0065002E004F0072006900670069006E00010053007500
      62005200650070006F00720074004E0061006D006500010001000D000A007100
      720079005300750062007200650070006F00720074007300530074006F007200
      65006400500072006F0063004E0061006D0065002E004F007200690067006900
      6E000100530074006F00720065006400500072006F0063004E0061006D006500
      010001000D000A007100720079005300750062007200650070006F0072007400
      7300440061007400610073006500740055007300650072004E0061006D006500
      2E004F0072006900670069006E00010044006100740061007300650074005500
      7300650072004E0061006D006500010001000D000A0071007200790053007500
      62007200650070006F0072007400730044006500730063007200690070007400
      69006F006E002E004F0072006900670069006E00010044006500730063007200
      69007000740069006F006E00010001000D000A00710072007900500061007200
      61006D0049006E0066006F002E0043006F006E006E0065006300740069006F00
      6E004E0061006D006500010046006100730074005200650070006F0072007400
      43006F006E006E0065006300740069006F006E00010001000D000A0071007200
      790050006100720061006D0049006E0066006F0050004100520041004D004500
      5400450052005F004E0041004D0045002E004F0072006900670069006E000100
      50004100520041004D0045005400450052005F004E0041004D00450001000100
      0D000A0071007200790050006100720061006D0049006E0066006F0044004100
      540041005F0054005900500045002E004F0072006900670069006E0001004400
      4100540041005F005400590050004500010001000D000A007100720079004600
      6100730074005200650070006F00720074002E0043006F006E006E0065006300
      740069006F006E004E0061006D00650001004600610073007400520065007000
      6F007200740043006F006E006E0065006300740069006F006E00010001000D00
      0A006600720078005000440046004500780070006F007200740031002E004100
      7500740068006F007200010046006100730074005200650070006F0072007400
      010001000D000A006600720078005000440046004500780070006F0072007400
      31002E005300750062006A006500630074000100460061007300740052006500
      70006F0072007400200050004400460020006500780070006F00720074000100
      01000D000A0071007200790049006E0073006500720074004600610073007400
      5200650070006F00720074002E0043006F006E006E0065006300740069006F00
      6E004E0061006D006500010046006100730074005200650070006F0072007400
      43006F006E006E0065006300740069006F006E00010001000D000A0073007000
      4700650074004E006500780074005200650070006F00720074004E0075006D00
      6200650072002E0043006F006E006E0065006300740069006F006E004E006100
      6D006500010046006100730074005200650070006F007200740043006F006E00
      6E0065006300740069006F006E00010001000D000A0073007000470065007400
      4E006500780074005200650070006F00720074004E0075006D00620065007200
      2E0053006300680065006D0061004E0061006D0065000100640062006F000100
      01000D000A00730070004700650074004E006500780074005200650070006F00
      720074004E0075006D006200650072002E00530074006F007200650064005000
      72006F0063004E0061006D006500010056006900640061005F00470065007400
      4D00610078004E006F00010001000D000A007100720079005300750062005200
      650070006F00720074002E0043006F006E006E0065006300740069006F006E00
      4E0061006D006500010046006100730074005200650070006F00720074004300
      6F006E006E0065006300740069006F006E00010001000D000A00710072007900
      55007000640061007400650046006100730074005200650070006F0072007400
      2E0043006F006E006E0065006300740069006F006E004E0061006D0065000100
      46006100730074005200650070006F007200740043006F006E006E0065006300
      740069006F006E00010001000D000A0071007200790049006E00730065007200
      74005300750062005200650070006F00720074002E0043006F006E006E006500
      6300740069006F006E004E0061006D0065000100460061007300740052006500
      70006F007200740043006F006E006E0065006300740069006F006E0001000100
      0D000A0071007200790055007000640061007400650053007500620052006500
      70006F00720074002E0043006F006E006E0065006300740069006F006E004E00
      61006D006500010046006100730074005200650070006F007200740043006F00
      6E006E0065006300740069006F006E00010001000D000A007100720079004400
      65006C006500740065005200650070006F00720074002E0043006F006E006E00
      65006300740069006F006E004E0061006D006500010046006100730074005200
      650070006F007200740043006F006E006E0065006300740069006F006E000100
      01000D000A00710072007900440065006C006500740065005300750062007200
      650070006F00720074002E0043006F006E006E0065006300740069006F006E00
      4E0061006D006500010046006100730074005200650070006F00720074004300
      6F006E006E0065006300740069006F006E00010001000D000A00710072007900
      440065006C006500740065005300750062007200650070006F00720074007300
      2E0043006F006E006E0065006300740069006F006E004E0061006D0065000100
      46006100730074005200650070006F007200740043006F006E006E0065006300
      740069006F006E00010001000D000A00740062006C0044004200500072006F00
      700073004C0061006E00670050006100740068002E004F007200690067006900
      6E0001004C0061006E0067005000610074006800010001000D000A0073007400
      4C006F00630061006C00650073005F0055006E00690063006F00640065000D00
      0A007300740043006F006C006C0065006300740069006F006E0073005F005500
      6E00690063006F00640065000D000A0073007400430068006100720053006500
      740073005F0055006E00690063006F00640065000D000A00}
  end
  object siLangDispatcher1: TsiLangDispatcher
    ActiveLanguage = 1
    NumOfLanguages = 2
    LangNames.Strings = (
      'English'
      'Swedish')
    Language = 'English'
    Left = 464
    Top = 88
  end
end
