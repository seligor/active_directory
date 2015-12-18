Function Get-Diskutil {
          Param([string] $computername=$env:computername) 
          Process { 
                if ($) {$computername=$} 
                gwmi win32_logicaldisk -fi "drivetype=3" -comp $computername | 
                  Select @{Name="Computername";Expression={$.SystemName}}, 
                  DeviceID, 
                  @{Name="SizeGB";Expression={"{0:N2}" -f ($.Size/1GB)}}, 
                  @{Name="FreeGB";Expression={"{0:N2}" -f ($.Freespace/1GB)}}, 
                  @{Name="UsedGB";Expression={"{0:N2}" -f (($.Size-$.Freespace)/1GB)}}, 
                  @{Name="PerFree";Expression={"{0:P2}" -f ($.Freespace/$.Size)}} 
                  } 
            } 
 #Get-Diskutil urc0504 | ft -auto 
 $data=gc c:\scr\powershell\servers.txt | where {Test-Connection $ -quiet -count 2} | Get-Diskutil | Sort Computername | ConvertTo-Html -Title "Utilization" | Out-File "c:\scr\powershell\html.html" 
 $data=gc c:\scr\powershell\servers.txt | where {Test-Connection $_ -quiet -count 2} | Get-Diskutil | Sort Computername | Export-Csv c:\scr\powershell\file.csv
