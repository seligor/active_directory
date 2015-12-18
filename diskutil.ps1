Function Get-Diskutil {
          Param([string] $computername=$env:computername) 
          Process { 
                if ($_) {$computername=$_} 
                gwmi win32_logicaldisk -fi "drivetype=3" -comp $computername | 
                  Select @{Name="Computername";Expression={$_.SystemName}}, 
                  DeviceID, 
                  @{Name="SizeGB";Expression={"{0:N2}" -f ($_.Size/1GB)}}, 
                  @{Name="FreeGB";Expression={"{0:N2}" -f ($_.Freespace/1GB)}}, 
                  @{Name="UsedGB";Expression={"{0:N2}" -f (($_.Size-$_.Freespace)/1GB)}}, 
                  @{Name="PerFree";Expression={"{0:P2}" -f ($_.Freespace/$_.Size)}} 
                  } 
            } 
 #Get-Diskutil urc0504 | ft -auto 
 $cfg_file = 'c:\scr\powershell\servers.txt'
 if (Test-Path $cfg_file){
 $data=gc $cfg_file | where {Test-Connection $_ -quiet -count 2} | Get-Diskutil | Sort Computername | ConvertTo-Html -Title "Utilization" | Out-File "c:\scr\powershell\html.html" 
 $data=gc $cfg_file | where {Test-Connection $_ -quiet -count 2} | Get-Diskutil | Sort Computername | Export-Csv c:\scr\powershell\file.csv
 } else { 'please input names of servers into file ',$cfg_file } 
