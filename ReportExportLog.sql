USE [PowerBIServiceLog]
GO

/****** Object:  Table [dbo].[ReportExportLog]    Script Date: 23.11.2022 15:15:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ReportExportLog](
	[DateTime] [datetime] NULL,
	[ProcessStatus] [nvarchar](50) NULL,
	[Workspace] [nvarchar](150) NULL,
	[ReportName] [nvarchar](150) NULL,
	[ExportUser] [nvarchar](150) NULL,
	[SystemUser] [nvarchar](150) NULL
) ON [PRIMARY]
GO