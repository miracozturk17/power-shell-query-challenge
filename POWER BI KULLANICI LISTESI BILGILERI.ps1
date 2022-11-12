#Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope LocalMachine
#Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser

#POWER BI HIZMETINE ERISIM SAGLAMAKTADIR.
Connect-PowerBIServiceAccount
<#
YA DA ILGILI KODLARLADA ERISIM BAGLANTISI OLUSTURABILSINIZ.
Login-PowerBIServiceAccount
Login-PowerBI
#>

#Get-PowerBIWorkspace -Scope Organization -Include All -All  
#$UserList = Get-PowerBIWorkspace -Scope Organization -Include All -All  
#$UserList.Users.Identifier


#POWER BI KULLANICI BILGILERINE ERISIM SAGLAMAKTADIR.
$UniqueUserList = $UserList.Users.Identifier | Group-Object
$UniqueUserList.Name
$UniqueUserList.Name.Count
#$UserList.Users.UsersUserPrincipalName


#SUNUCU BILGILERI DERLEMEKTE VE ILGILI SUNUCUYA ERISIM SAGLAMAKTADIR.
$serverName   = " SUNUCU ADINIZ     "
$databaseName = " ILGILI VERITABANI "
$tableName    = " ILGILI TABLO      "


#SUNUCUYA YONELIK BAGLANTI OBJESI OLUSTURMAKTADIR.
$Connection                  = New-Object System.Data.SQLClient.SQLConnection
$Connection.ConnectionString = "server='$serverName';database='$databaseName';trusted_connection=true;"


#SUNUCUYA YONELIK BAGLANTIYI AKTIFLESTIRMEKTEDIR/ACMAKTADIR.
$Connection.Open()


#SUNUCUYA YONELIK ISLEM OBJESI OLUSTURMAKTADIR.
$Command            = New-Object System.Data.SQLClient.SQLCommand
$Command.Connection = $Connection


#ILGILI DEGERLERIN KAYIT ISLEMLERINI GERCEKLESTIRMEKTEDIR.
foreach($item in $UniqueUserList)
{
  $UserIdentifier      =$item.Name

  $insertquery         ="INSERT INTO $tableName([UserIdentifier])VALUES('$UserIdentifier')"
  $Command.CommandText = $insertquery
  $Command.ExecuteNonQuery()
}


#SUNUCUYA YONELIK BAGLANTIYI PASIFLESTIRMEKTEDIR/KAPATMAKTADIR.
$Connection.Close();