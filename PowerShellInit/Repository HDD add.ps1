## ADD Custom number of HDD to Azure VM 


#Change Directory to working
cd 'C:\Users\aphilippov\OneDrive\Documents\PowerShell Lib'

# Set the path in to which your profile will be saved
$Path = 'C:\Users\aphilippov\OneDrive\Documents\PowerShell Lib\AzureRmProfile.json'
$Profile = Import-AzureRmContext -Path $Path # Get the profile

# Account/VM/Disk configuration

$ResourceGroup="APhilippov-CloudConnect-Webinar"
$DiskPool ="S2D"
$VMDiskOwner ="cc-repository02"
$vm = Get-AzureRmVM -ResourceGroupName $ResourceGroup -Name $VMDiskOwner

# Disk Parameters
$DiskList = (5)
$DiskConfig = New-AzureRmDiskConfig -Location WestEurope -CreateOption Empty -DiskSizeGB 128

# New Disk and VM Generation

ForEach ($DiskNumber in $DiskList) {
        $DiskName= $VMDiskOwner+"-"+$DiskPool+"-"+$DiskNumber
        $dataDisk = New-AzureRmDisk -ResourceGroupName $ResourceGroup -DiskName $DiskName -Disk $diskConfig
        $vm = Add-AzureRmVMDataDisk -VM $vm -Name $DiskName -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun ($DiskNumber)
}


Update-AzureRmVM -ResourceGroupName $ResourceGroup -VM $vm