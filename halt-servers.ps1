gc C:\scr\powershell\servers-halt.txt | 
where {Test-Connection $_ -quiet -count 2}| 
foreach { 
Write-Host "Shuting down $_" -fore "Green" 
Stop-Computer $_ -force -whatif} 
