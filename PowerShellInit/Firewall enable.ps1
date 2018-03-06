## Enable Firewall rules 



Set-Item WSMan:\localhost\Client\TrustedHosts -Value "" -Force
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "10.0.5.*,CC-Gateway-2-ip,CC-Gateway-ip,cc-repository02,CC-Repository01,VCC-MarketPlace" -Force
Get-Item WSMan:\localhost\Client\TrustedHosts


$RemoteSession = New-CimSession –ComputerName 10.0.5.10
New-NetFirewallRule -DisplayName “10.0.5.0/24 allow” -Direction Inbound -RemoteAddress 10.0.5.0/24 -Action Allow –CimSession $RemoteSession -Confirm


