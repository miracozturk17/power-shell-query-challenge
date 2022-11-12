
$PBIAdminUPN=" ORGANIZASYON YONETICI KULLANICINIZ          "
$PBIAdminPW =" ORGANIZASYON YONETICI KULLANICISI PAROLANIZ "

$Security     = ConvertTo-SecureString $PBIAdminPW -AsPlainText -Force
$Credential   = New-Object System.Management.Automation.PSCredential($PBIAdminUPN,$Security)

Connect-PowerBIServiceAccount -Credential $Credential

$StartDate = Get-Date
$StartDate = $StartDate.AddDays(-1)

$StartDateYearStr  = $StartDate.ToString('yyyy')
$StartDateMonthStr = $StartDate.ToString('MM')
$StartDateDayStr   = $StartDate.ToString('dd')

$StartLogDate = $StartDateYearStr + '-' + $StartDateMonthStr + '-' + $StartDateDayStr + 'T00:00:00.000'
$EndLogDate   = $StartDateYearStr + '-' + $StartDateMonthStr + '-' + $StartDateDayStr + 'T23:59:59.999'


$serverName                  = " SUNUCU ADINIZ     "
$databaseName                = " ILGILI VERITABANI "
$tableName                   = " ILGILI TABLO      "
$Connection                  = New-Object System.Data.SQLClient.SQLConnection
$Connection.ConnectionString = "server='$serverName';database='$databaseName';trusted_connection=true;"
$Connection.Open()
$Command                     = New-Object System.Data.SQLClient.SQLCommand
$Command.Connection          = $Connection


$ActivityLogs = Get-PowerBIActivityEvent -StartDateTime $StartLogDate -EndDateTime $EndLogDate | ConvertFrom-Json
$MaxValue     = $ActivityLogs.Count


for($i = 0; $i -lt $MaxValue; $i++)
{
        foreach($item in $ActivityLogs[$i]){
                $Id=$item.Id
                $UserType=$item.UserType
                $UserKey=$item.UserKey
                $Workload=$item.Workload
                $UserId=$item.UserId
                $Activity=$item.Activity
                $ItemName=$item.ItemName
                $CreationTime=$item.CreationTime
                $CreationTimeUTC=$item.CreationTimeUTC
                $RecordType=$item.RecordType
                $Operation=$item.Operation
                $OrganizationId=$item.OrganizationId
                $ClientIP=$item.ClientIP
                $UserAgent=$item.UserAgent
                $WorkSpaceName=$item.WorkSpaceName
                $DashboardName=$item.DashboardName
                $DatasetName=$item.DatasetName
                $ReportName=$item.ReportName
                $WorkspaceId=$item.WorkspaceId
                $ObjectId=$item.ObjectId
                $DashboardId=$item.DashboardId
                $DatasetId=$item.DatasetId
                $OrgAppPermission=$item.OrgAppPermission
                $CapacityId=$item.CapacityId
                $CapacityName=$item.CapacityName
                $AppName=$item.AppName
                $IsSuccess=$item.IsSuccess
                $ReportType=$item.ReportType
                $ReportId=$item.ReportId
                $RequestId=$item.RequestId
                $ActivityId=$item.ActivityId
                $AppReportId=$item.AppReportId
                $DistributionMethod=$item.DistributionMethod
                $ConsumptionMethod=$item.ConsumptionMethod

      $insertquery="
      INSERT INTO $tableName
          (
           [Id],
           [UserType],
           [UserKey],
           [Workload],
           [UserId],
           [Activity],
           [ItemName],
           [CreationTime],
           [CreationTimeUTC],
           [RecordType],
           [Operation],
           [OrganizationId],
           [ClientIP],
           [UserAgent],
           [WorkSpaceName],
           [DashboardName],
           [DatasetName],
           [ReportName],
           [WorkspaceId],
           [ObjectId],
           [DashboardId],
           [DatasetId],
           [OrgAppPermission],
           [CapacityId],
           [CapacityName],
           [AppName],
           [IsSuccess],
           [ReportType],
           [ReportId],
           [RequestId],
           [ActivityId],
           [AppReportId],
           [DistributionMethod],
           [ConsumptionMethod]
          )
        VALUES
          (
            '$Id',
            '$UserType',
            '$UserKey',
            '$Workload',
            '$UserId',
            '$Activity',
            '$ItemName',
            '$CreationTime',
            '$CreationTimeUTC',
            '$RecordType',
            '$Operation',
            '$OrganizationId',
            '$ClientIP',
            '$UserAgent',
            '$WorkSpaceName',
            '$DashboardName',
            '$DatasetName',
            '$ReportName',
            '$WorkspaceId',
            '$ObjectId',
            '$DashboardId',
            '$DatasetId',
            '$OrgAppPermission',
            '$CapacityId',
            '$CapacityName',
            '$AppName',
            '$IsSuccess',
            '$ReportType',
            '$ReportId',
            '$RequestId',
            '$ActivityId',
            '$AppReportId',
            '$DistributionMethod',
            '$ConsumptionMethod'
           )"
      $Command.CommandText = $insertquery
      $Command.ExecuteNonQuery()
    }
}
    $Connection.Close();