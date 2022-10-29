#ILGILI KUTUPHANENIN SISTEMIMIZDE OLUP OLMADIGINI KONTROL ETMEKTEDIR.
Get-Module MicrosoftPowerBIMgmt* -ListAvailable


#YEREL CIHAZ ICIN KULLANICILAR ADINA YURUTME POLITIKALARINI KALDIRMAKTADIR.
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope LocalMachine


<#
POWER BI KUTUPHANEMIZI YUKLEMEK ICIN KULLANILMAKTADIR.
YEREL CIHAZINIZDAKI POWERSHELL ARABIRIMINDE ILGILI KODU CALISTIRMANIZ GEREKMEKTEDIR.
#>
Install-Module -Name MicrosoftPowerBIMgmt


<#
POWER BI SERVISINE BAGLANMAK ICIN KULLANILMAKTADIR.
CALISTIRILDIGINDA POWER BI SERVICE TARAFINDAN KULLANICI ADI VE PAROLA SORGU EKRANI GELMEKTEDIR.
BAGLANTI INAKTIF EDILENE KADAR ILGILI EKRAN TEKRAR KULLANICI ADI VE PAROLA SORGULAMASI TALEP ETMEMEKTEDIR.
#>
Connect-PowerBIServiceAccount


#POWER BI SERVICE BAGLANTIMIZI INAKTIF ETMEK ICIN KULLANILMAKTADIR.
Disconnect-PowerBIServiceAccount


#POWER BI SERVICE UZERINDEKI CALISMA ALANLARINA AIT BILGILER ICIN KULLANILMAKTADIR.
Get-PowerBIWorkspace


#POWER BI SERVICE UZERINDEKI YONETICIYE AIT TUM CALISMA ALANLARINA YONELIK BILGILER ICIN KULLANILMAKTADIR.
Get-PowerBIWorkspace -All


#POWER BI SERVICE UZERINDEKI ORGANIZASYON SEVIYESINDEKI TUM CALISMA ALANLARINA AIT BILGILER ICIN KULLANILMAKTADIR.
Get-PowerBIWorkspace -Scope Organization -All


#POWER BI SERVICE UZERINDEKI TUM RAPORLARA AIT BILGILER ICIN KULLANILMAKTADIR.
Get-PowerBIReport


#POWER BI SERVICE UZERINDEKI ORGANIZASYON SEVIYESINDEKI TUM RAPORLARA AIT BILGILER ICIN KULLANILMAKTADIR.
Get-PowerBIReport -Scope Organization


#POWER BI SERVICE UZERINDEKI TUM PANOLARA AIT BILGILER ICIN KULLANILMAKTADIR.
Get-PowerBIDashboard


#POWER BI SERVICE UZERINDEKI ORGANIZASYON SEVIYESINDEKI TUM PANOLARA AIT BILGILER ICIN KULLANILMAKTADIR.
Get-PowerBIDashboard -Scope Organization


#POWER BI SERVICE UZERINDEKI TUM VERI KAYNAKLARINA AIT BILGILER ICIN KULLANILMAKTADIR.
Get-PowerBIDataset


<#
ADMIN TUM CALISMA ALANI SAYISI
ORGANIZASYON TUM CALISMA ALANI SAYISI
#>
$tumAdminCalismaAlanlari = Get-PowerBIWorkspace -All
$tumOrganizasyonCalismaAlanlari = Get-PowerBIWorkspace -Scope Organization -All


#CALISMA ALANLARI DEGERLERI;
$tumAdminCalismaAlanlari = Get-PowerBIWorkspace -All
$tumAdminCalismaAlanlari.Count
$tumAdminCalismaAlanlari.Id.Count

$tumOrganizasyonCalismaAlanlari = Get-PowerBIWorkspace -All
$tumOrganizasyonCalismaAlanlari.Count
$tumOrganizasyonCalismaAlanlari.Id.Count


#RAPOR DEGERLERI;
$tumAdminRaporlari = Get-PowerBIReport
$tumAdminRaporlari.Count
$tumAdminRaporlari.Id.Count

$tumOrganizasyonRaporlari = Get-PowerBIReport -Scope Organization
$tumOrganizasyonRaporlari.Count
$tumOrganizasyonRaporlari.Id.Count


#PANO DEGERLERI;
$tumAdminPanolari = Get-PowerBIDashboard
$tumAdminPanolari.Count
$tumAdminPanolari.Id.Count

$tumOrganizasyonPanolari = Get-PowerBIDashboard -Scope Organization
$tumOrganizasyonPanolari.Count
$tumOrganizasyonPanolari.Id.Count


#VERI KAYNAGI DEGERLERI;
$tumAdminVeriKaynaklari = Get-PowerBIDataset
$tumAdminVeriKaynaklari.Count
$tumAdminVeriKaynaklari.Id.Count

$tumOrganizasyonVeriKaynaklari = Get-PowerBIDataset -Scope Organization
$tumOrganizasyonVeriKaynaklari.Count
$tumOrganizasyonVeriKaynaklari.Id.Count

#GENEL OZET;
"Admin Calisma Alani Sayisi: " + $tumAdminCalismaAlanlari.Id.Count
"Organizasyon Calisma Alani Sayisi: " + $tumOrganizasyonCalismaAlanlari.Id.Count
"Admin Rapor Sayisi: " + $tumAdminRaporlari.Id.Count
"Organizasyon Rapor Sayisi: " + $tumOrganizasyonRaporlari.Id.Count
"Admin Pano Sayisi: " + $tumAdminPanolari.Id.Count
"Organizasyon Pano Sayisi: " + $tumOrganizasyonPanolari.Id.Count
"Admin Veri Kaynagi Sayisi: " + $tumAdminVeriKaynaklari.Id.Count
"Organizasyon Veri Kaynagi Sayisi: " + $tumOrganizasyonVeriKaynaklari.Id.Count