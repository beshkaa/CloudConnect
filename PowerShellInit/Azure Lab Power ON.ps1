workflow PowerOnVM {

$account=Login-AzureRmAccount
$Subscription = Get-AzureRmSubscription
Select-AzureRmSubscription -Subscription $Subscription
$RGName=Get-AzureRmResourceGroup
$RGName=$RGName[0].ResourceGroupName
$RGName

$VMNames=(Get-AzureRMVM -ResourceGroupName $RGName | Where-Object {$_.Name -like '*CC*'}).Name

ForEach -Parallel ($VMName in $VMNames) {

if ((Get-AzureRmVM -ResourceGroupName $RGName -Name $VMName -Status).Statuses[1].Code -eq "PowerState/deallocated") 
    { 
       Write-Output ($VMName,"OK")
       Start-AzureRmVM -ResourceGroupName $RGName -Name $VMName -DefaultProfile $account
    }

    }
 }

 PowerONVM