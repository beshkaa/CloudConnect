Invoke-Command -ComputerName 10.0.5.10 -ScriptBlock {

# Move CD-Drive to Z:

Get-WmiObject -Class Win32_volume -Filter "DriveLetter = 'E:'" |Set-WmiInstance -Arguments @{DriveLetter='Z:'}

# Initialize data disk
Initialize-Disk -Number 2
 
# Create a volume on disk
New-Volume -DiskNumber 2 -FriendlyName Data -FileSystem NTFS -DriveLetter E
 
# Install DNS and ADDS features
Install-windowsfeature -name AD-Domain-Services, DNS -IncludeManagementTools
 
Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false `
                   -DatabasePath "E:\NTDS" `
                   -DomainMode "WinThreshold" `
                   -DomainName "VeeamCloud.local" `
                   -DomainNetbiosName "VEEAMCLOUD" `
                   -ForestMode "WinThreshold" `
                   -InstallDns:$true `
                   -LogPath "E:\NTDS" `
                   -NoRebootOnCompletion:$false `
                   -SysvolPath "E:\SYSVOL" `
                   -Force:$true


}