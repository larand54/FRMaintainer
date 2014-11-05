USE [vis_vida]
GO

/****** Object:  Table [dbo].[FastSubReportNames]    Script Date: 11/04/2014 15:52:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FastSubReportNames]') AND type in (N'U'))
DROP TABLE [dbo].[FastSubReportNames]
GO

USE [vis_vida]
GO

/****** Object:  Table [dbo].[FastSubReportNames]    Script Date: 11/04/2014 15:52:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[FastSubReportNames](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReportNo] [int] NOT NULL,
	[SubReportName] [varchar](50) NULL,
	[StoredProcName] [varchar](100) NULL,
	[DatasetUserName] [varchar](50) NULL,
	[Description] [varchar](100) NULL,
 CONSTRAINT [PK_FastSubReportNames] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


