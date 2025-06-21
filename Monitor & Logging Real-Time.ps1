Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | Out-File "C:\Logs\top_cpu.txt"
