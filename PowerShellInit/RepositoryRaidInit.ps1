$RemoteHost="cc-repository02"
$PoolName="Pool01"

Invoke-Command -ComputerName $RemoteHost -ScriptBlock {

param($RemoteHost, $PoolName)

New-StoragePool -FriendlyName $PoolName -PhysicalDisks (Get-PhysicalDisk -CanPool $true) -StorageSubSystemFriendlyName (Get-StorageSubSystem).FriendlyName

#Uncomment if want to Use Simple+ReFS
# New-VirtualDisk -StoragePoolFriendlyName $PoolName -FriendlyName BackupData -UseMaximumSize -ResiliencySettingName Parity
# Get-Disk |
# Where partitionstyle -eq 'raw' |
# Initialize-Disk -PartitionStyle GPT -PassThru |
# New-Partition -AssignDriveLetter -UseMaximumSize |
# Format-Volume -FileSystem ReFS -AllocationUnitSize 65536 -NewFileSystemLabel "CCBackup01" -SetIntegrityStreams $true -Confirm:$false 


#Uncomment if want to Use Parity+ReFS+IntegrationStreams
New-VirtualDisk -StoragePoolFriendlyName $PoolName -FriendlyName BackupData -UseMaximumSize -ResiliencySettingName Parity
Get-Disk |
Where partitionstyle -eq 'raw' |
Initialize-Disk -PartitionStyle GPT -PassThru |
New-Partition -AssignDriveLetter -UseMaximumSize |
Format-Volume -FileSystem ReFS -AllocationUnitSize 65536 -NewFileSystemLabel "CCBackup01" -SetIntegrityStreams $true -Confirm:$false 

} -ArgumentList $RemoteHost, $PoolName