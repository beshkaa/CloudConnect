##AzurePS initialization 

Install-Module Azure
Import-Module Azure
Install-Module AzureRM
Import-Module AzureRM

Login-AzureRmAccount
$Subscription = Get-AzureRmSubscription

Select-AzureRmSubscription -Subscription $Subscription
Get-AzureRmSubscription

$ResourceGroup = Get-AzureRmSubscription


$RGName="APhilippov-CloudConnect-Webinar"
$VMName=(Get-AzureRMVM -ResourceGroupName $RGName | Where-Object {$_.Name -like '*CC*'}).Name
$VMName


ForEach ($VMNameUnit in $VMName) {

if ((Get-AzureRmVM -ResourceGroupName $RGName -Name $VMNameUnit -Status).Statuses[1].Code -eq "PowerState/deallocated") 
    { 
        Write-Output ($VMNameunit,"OK")
       # Start-AzureRmVM -ResourceGroupName $RGName -Name $VMName
    }

 }

$VCC-Server = Get-AzureVM -ServiceName "ContosoService03" -Name "DatabaseServer"
