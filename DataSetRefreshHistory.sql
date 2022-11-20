USE [PowerBIServiceLog]
GO

/****** Object:  Table [dbo].[DataSetRefreshHistory]    Script Date: 20.11.2022 19:50:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DataSetRefreshHistory](
	[Workspace] [nvarchar](500) NULL,
	[Dataset] [nvarchar](250) NULL,
	[RefreshType] [nvarchar](50) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Status] [nvarchar](250) NULL,
	[ErrorCode] [nvarchar](250) NULL,
	[ErrorDescription] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


