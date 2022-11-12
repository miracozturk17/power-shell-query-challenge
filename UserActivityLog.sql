USE [PowerBIServiceLog]
GO

/****** Object:  Table [dbo].[UserActivityLog]    Script Date: 12.11.2022 19:18:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserActivityLog](
	[Id] [nvarchar](250) NULL,
	[UserType] [nvarchar](250) NULL,
	[UserKey] [nvarchar](250) NULL,
	[Workload] [nvarchar](250) NULL,
	[UserId] [nvarchar](250) NULL,
	[Activity] [nvarchar](250) NULL,
	[ItemName] [nvarchar](250) NULL,
	[CreationTime] [nvarchar](250) NULL,
	[CreationTimeUTC] [nvarchar](250) NULL,
	[RecordType] [nvarchar](250) NULL,
	[Operation] [nvarchar](250) NULL,
	[OrganizationId] [nvarchar](250) NULL,
	[ClientIP] [nvarchar](250) NULL,
	[UserAgent] [nvarchar](max) NULL,
	[WorkSpaceName] [nvarchar](250) NULL,
	[DashboardName] [nvarchar](250) NULL,
	[DatasetName] [nvarchar](250) NULL,
	[ReportName] [nvarchar](250) NULL,
	[WorkspaceId] [nvarchar](250) NULL,
	[ObjectId] [nvarchar](250) NULL,
	[DashboardId] [nvarchar](250) NULL,
	[DatasetId] [nvarchar](250) NULL,
	[OrgAppPermission] [nvarchar](250) NULL,
	[CapacityId] [nvarchar](250) NULL,
	[CapacityName] [nvarchar](250) NULL,
	[AppName] [nvarchar](250) NULL,
	[IsSuccess] [nvarchar](250) NULL,
	[ReportType] [nvarchar](250) NULL,
	[ReportId] [nvarchar](250) NULL,
	[RequestId] [nvarchar](250) NULL,
	[ActivityId] [nvarchar](250) NULL,
	[AppReportId] [nvarchar](250) NULL,
	[DistributionMethod] [nvarchar](250) NULL,
	[ConsumptionMethod] [nvarchar](250) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


