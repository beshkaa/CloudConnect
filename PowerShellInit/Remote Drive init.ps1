$RemoteSession = New-CimSession –ComputerName cc-repository01

Get-Disk -CimSession $RemoteSession |
Where partitionstyle -eq 'raw' |
Initialize-Disk -PartitionStyle GPT -PassThru |
New-Partition -AssignDriveLetter -UseMaximumSize |
Format-Volume -FileSystem ReFS -AllocationUnitSize 65536 -NewFileSystemLabel "CCBackup01" -SetIntegrityStreams $false -Confirm:$false 