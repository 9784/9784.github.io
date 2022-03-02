<# 
#############################################################################  
# This powershell script gives FQDN, ping status, Last Boot time, Uptime,  
# for a list of servers 
#
# give input as server names
#############################################################################
### writing credits : VM ###
#$date = Get-Date
#$ccepcred = Get-Credential -UserName ccep\MYUSERID
#>
$servers = Get-Content "D:\temp\list1.txt"
@(
foreach ($server in $servers) 
{  
    <#
    #$server = $name
    #if ( Test-Connection -ComputerName "$name.fqdn.com" -Count 1 -ErrorAction SilentlyContinue )  { $server = "$name.fqdn.com"}
    #elseif ( Test-Connection -ComputerName "$name.fqdn.fqdn.com" -Count 1 -ErrorAction SilentlyContinue )  { $server =  "$name.fqdn.fqdn.com"}
    #elseif ( Test-Connection -ComputerName "$name.fqdn.fqdn.com" -Count 1 -ErrorAction SilentlyContinue )  { $server =  "$name.fqdn.fqdn.com"}
    #else{ Write-output "$name is NOT pinging !!!" }
    #Write "$server is pinging"
    #get last boot time
    #>
        $LBTime = gwmi win32_operatingsystem -comp $server | %{ $_.ConvertToDateTime($_.LastBootUpTime) }
        $uptime = (New-TimeSpan -start $LBTime -end $(get-date))
    #Write "Last reboot time of $server is: $LBTime"
    #write "uptime of $server is $uptime"
    Write "Uptime of $server is:  $($uptime.days) Days, $($uptime.hours) Hours, $($uptime.minutes) Minutes, $($uptime.seconds) Seconds"
    #Write "************" 
    $server = $null
    $LBTime = $null
    $name = $null
    $uptime = $null
}) | out-file "D:\temp\uptime-MM-after-1.csv" -Append
