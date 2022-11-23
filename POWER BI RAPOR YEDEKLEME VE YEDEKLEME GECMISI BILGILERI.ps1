
$PBIAdminUPN=" ERISIMI OLAN ORGANIZASYON YONETICI KULLANICINIZ "
$PBIAdminPW =" ORGANIZASYON YONETICI KULLANICISI PAROLANIZ     "

$Security     = ConvertTo-SecureString $PBIAdminPW -AsPlainText -Force
$Credential   = New-Object System.Management.Automation.PSCredential($PBIAdminUPN,$Security)

Connect-PowerBIServiceAccount -Credential $Credential

$serverName                  = " SUNUCU ADINIZ     "
$databaseName                = " ILGILI VERITABANI "
$tableName                   = " ILGILI TABLO      "
$Connection                  = New-Object System.Data.SQLClient.SQLConnection
$Connection.ConnectionString = "server='$serverName';database='$databaseName';trusted_connection=true;"
$Command                     = New-Object System.Data.SQLClient.SQLCommand
$Command.Connection          = $Connection


$OutPutPath =   "C:\PowerBI_Report_BackUp\" 

$PBIWorkspace = Get-PowerBIWorkspace  
 
ForEach($Workspace in $PBIWorkspace)
{
	$PBIReports = Get-PowerBIReport –WorkspaceId $Workspace.Id 	
	
    #$PBIReports	
	
	ForEach($Report in $PBIReports)
		{
			$FileName   = $Workspace.name + " : " + $Report.name 
			
            $OutputFile = $OutPutPath + $Report.name + ".pbix"	
            
            $OutputFile		
			
                if (Test-Path $OutputFile)
				    {
				      Remove-Item $OutputFile
				    }
                try 
                    {
                      Export-PowerBIReport –WorkspaceId $Workspace.ID –Id $Report.ID –OutFile $OutputFile -ea stop
                      $Report.Name + ": "+ "Başarılı"
                      
                      $ProcessStatus = "Başarılı"

                      WriteLogMsSQL $Workspace.name $Report.Name $ProcessStatus $PBIAdminUPN
                    }
                catch
                    {
                      $Report.Name + ": "+ "Başarısız"

                      $ProcessStatus="Başarısız"

                      WriteLogMsSQL $Workspace.name $Report.Name $ProcessStatus $PBIAdminUPN
                    }
		}
}

function WriteLogMsSQL
{
       Param
       (
        [string] $Workspace,
        [string] $ReportName,
        [string] $ProcessStatus,
        [string] $ExportUser
        ) 

    $DateTime   = Get-Date
    $SystemUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

    $Connection.Open()
    $insertquery="
        INSERT INTO $tableName
          (
           [DateTime],
           [ProcessStatus],
           [Workspace],
           [ReportName],
           [ExportUser],
           [SystemUser]
          )
        VALUES
          (
            '$DateTime',
            '$ProcessStatus',
            '$Workspace',
            '$ReportName',
            '$ExportUser',
            '$SystemUser'
           )"
    $Command.CommandText = $insertquery
    $Command.ExecuteNonQuery()
    $Connection.Close();
}
Disconnect-PowerBIServiceAccount 