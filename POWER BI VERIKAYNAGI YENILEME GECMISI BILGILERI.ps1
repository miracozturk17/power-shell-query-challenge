Connect-PowerBIServiceAccount
$Workspaces = Get-PowerBIWorkspace

$serverName   = "SUNUCU ADINIZ    "
$databaseName = "ILGILI VERITABANI"
$tableName    = "ILGILI TABLO     "

$Connection                  = New-Object System.Data.SQLClient.SQLConnection
$Connection.ConnectionString = "server='$serverName';database='$databaseName';trusted_connection=true;"

$Connection.Open()

$Command             = New-Object System.Data.SQLClient.SQLCommand
$Command.Connection  = $Connection

foreach($workspace in $Workspaces)
{
    
    $DataSets = Get-PowerBIDataset -WorkspaceId $workspace.Id
    foreach($dataset in $DataSets)
    {
        $URL = "groups/" + $workspace.id + "/datasets/" + $dataset.id + "/refreshes"
        $Results = Invoke-PowerBIRestMethod -Url $URL -Method Get | ConvertFrom-Json
        foreach($result in $Results.value)
        {

            $errorDetails = $result.serviceExceptionJson | ConvertFrom-Json -ErrorAction SilentlyContinue
            $column= New-Object psobject
            $column| Add-Member -Name "Workspace"        -Value $workspace.Name                -MemberType NoteProperty
            $column| Add-Member -Name "Dataset"          -Value $dataset.Name                  -MemberType NoteProperty
            $column| Add-Member -Name "refreshType"      -Value $result.refreshType            -MemberType NoteProperty
            $column| Add-Member -Name "startTime"        -Value $result.startTime              -MemberType NoteProperty
            $column| Add-Member -Name "endTime"          -Value $result.endTime                -MemberType NoteProperty
            $column| Add-Member -Name "status"           -Value $result.status                 -MemberType NoteProperty
            $column| Add-Member -Name "errorCode"        -Value $errorDetails.errorCode        -MemberType NoteProperty
            $column| Add-Member -Name "errorDescription" -Value $errorDetails.errorDescription -MemberType NoteProperty

            $Workspace1       =$column.Workspace
            $Dataset1         =$column.Dataset
            $RefreshType1     =$column.refreshType
            $StartTime1       =$column.startTime
            $EndTime1         =$column.endTime
            $Status1          =$column.status
            $Status1          =$column.errorCode
            $ErrorDescription1=$column.errorDescription

            $insertquery="
                  INSERT INTO 
                  $tableName
                  (
                   [Workspace]
                  ,[Dataset]
                  ,[RefreshType]
                  ,[StartTime]
                  ,[EndTime]
                  ,[Status]
                  ,[ErrorCode]
                  ,[ErrorDescription]
                  )
                  VALUES
                  (
                  '$Workspace1',
                  '$Dataset1',
                  '$RefreshType1',
                  '$StartTime1',
                  '$EndTime1',
                  '$Status1',
                  '$ErrorCode1',
                  '$ErrorDescription1'
                  )"
                  $Command.CommandText = $insertquery
                  $Command.ExecuteNonQuery()  
        }
        $Connection.Close()
    }
}