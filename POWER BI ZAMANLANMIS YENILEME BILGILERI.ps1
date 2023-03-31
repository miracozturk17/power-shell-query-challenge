$PBIAdminUPN    = " ORGANIZASYON YONETICI KULLANICINIZ          "
$PBIAdminPW     = " ORGANIZASYON YONETICI KULLANICISI PAROLANIZ "
$SecurePassword = ConvertTo-SecureString $PBIAdminPW -AsPlainText -Force
$Credential     = New-Object System.Management.Automation.PSCredential($PBIAdminUPN,$SecurePassword)

$serverName                  = " SUNUCU ADINIZ     "
$databaseName                = " ILGILI VERITABANI "
$tableName                   = " ILGILI TABLO      "

$Connection                  = New-Object System.Data.SQLClient.SQLConnection
$Connection.ConnectionString = "server='$serverName';database='$databaseName';trusted_connection=true;"

$Connection.Open()

$Command             = New-Object System.Data.SQLClient.SQLCommand
$Command.Connection  = $Connection

Connect-PowerBIServiceAccount -Credential $Credential
 
$Workspaces = Get-PowerBIWorkspace
 
foreach($workspace in $Workspaces)
{
$DataSets = Get-PowerBIDataset -WorkspaceId $workspace.Id | where {$_.isRefreshable -eq $true}    
    foreach($dataset in $DataSets)
    {
        $URI = "groups/" + $workspace.Id + "/datasets/" + $dataset.id + "/refreshSchedule"
        
        $Results = Invoke-PowerBIRestMethod -Url $URI -Method Get | ConvertFrom-Json
        if($Results.enabled -eq $true) {
            
            $LogDate1=Get-Date -Format "dddd MM/dd/yyyy HH:mm K"
            $Workspace1=$workspace.Id
            $Dataset1=$Dataset.Name
            $Days1=$Results.days
            $Times1=$Results.times
            $Enabled1=$Results.enabled
            $NotifyOption1=$Results.notifyOption
            $LocalTimeZone1=$Results.localTimeZoneId

                  $insertquery="
                  INSERT INTO 
                  $tableName
                  (
                   [LogDate]
                  ,[WorkspaceId]
                  ,[DatasetName]
                  ,[Days]
                  ,[Times]
                  ,[Enabled]
                  ,[NotifyOption]
                  ,[LocalTimeZoneId]
                  )
                  VALUES
                  (
                  '$LogDate1',
                  '$Workspace1',
                  '$Dataset1',
                  '$Days1',
                  '$Times1',
                  '$Enabled1',
                  '$NotifyOption1',
                  '$LocalTimeZone1'
                  )"
                  $Command.CommandText = $insertquery
                  $Command.ExecuteNonQuery()  
        }
    }
}
$Connection.Close()