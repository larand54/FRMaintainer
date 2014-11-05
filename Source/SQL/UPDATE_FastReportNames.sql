UPDATE [vis_vida].[dbo].[FastReportNames]
   SET [ReportNo] = <ReportNo, int,>
      ,[DocType] = <DocType, int,>
      ,[ReportName] = <ReportName, varchar(100),>
      ,[Description] = <Description, varchar(100),>
      ,[StoredProcName] = <StoredProcName, varchar(100),>
      ,[DatasetUserName] = <DatasetUserName, varchar(50),>
 WHERE <Search Conditions,,>
GO


