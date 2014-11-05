USE [vis_vida]
GO

/****** Object:  Table [dbo].[FastReportNames]    Script Date: 11/04/2014 15:50:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FastReportNames]') AND type in (N'U'))
DROP TABLE [dbo].[FastReportNames]
GO

USE [vis_vida]
GO

/****** Object:  Table [dbo].[FastReportNames]    Script Date: 11/04/2014 15:50:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[FastReportNames](
	[ReportNo] [int] NOT NULL,
	[DocType] [int] NULL,
	[ReportName] [varchar](100) NULL,
	[Description] [varchar](100) NULL,
	[StoredProcName] [varchar](100) NULL,
	[DatasetUserName] [varchar](50) NULL,
 CONSTRAINT [PK_FastReportNames] PRIMARY KEY CLUSTERED 
(
	[ReportNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


