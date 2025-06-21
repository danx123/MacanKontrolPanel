# === Setup Folder ===
$logFolder = Join-Path $PSScriptRoot "LOG_MACAN"
if (!(Test-Path $logFolder)) { New-Item $logFolder -ItemType Directory | Out-Null }

# === Timestamp & File ===
$timestamp = Get-Date -Format "yyyy-MM-dd_HHmmss"
$csvFile = Join-Path $logFolder "macan_log_$timestamp.csv"

# === Header ===
"Timestamp,Hostname,CPU Load (%),Free RAM (MB),Total RAM (MB),Disk C Free (GB),Public IP" | Out-File -Encoding utf8 $csvFile

# === Data ===
$hostname = $env:COMPUTERNAME
$cpu = [math]::Round((Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue, 1)
$mem = Get-CimInstance Win32_OperatingSystem
$freeRAM = [math]::Round($mem.FreePhysicalMemory / 1024, 1)
$totalRAM = [math]::Round($mem.TotalVisibleMemorySize / 1024, 1)
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$freeDisk = [math]::Round($disk.FreeSpace / 1GB, 1)
$publicIP = (Invoke-RestMethod -Uri 'https://api.ipify.org')

# === Write to CSV ===
"$timestamp,$hostname,$cpu,$freeRAM,$totalRAM,$freeDisk,$publicIP" | Out-File -Append -Encoding utf8 $csvFile

Write-Host "`n✅ Log tersimpan: $csvFile`n" -ForegroundColor Green

# === Realtime Monitor ===
while ($true) {
    Clear-Host
    $cpuNow = [math]::Round((Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue, 1)
    $memNow = Get-CimInstance Win32_OperatingSystem
    $used = [math]::Round(($memNow.TotalVisibleMemorySize - $memNow.FreePhysicalMemory)/1024, 1)
    $total = [math]::Round($memNow.TotalVisibleMemorySize/1024, 1)
    $diskNow = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
    $diskGB = [math]::Round($diskNow.FreeSpace / 1GB, 1)

    Write-Host "🧠 CPU Load : $cpuNow %" -ForegroundColor Cyan
    Write-Host "💾 RAM Used : $used / $total MB"
    Write-Host "📀 Disk C:   $diskGB GB Free`n"
    Start-Sleep -Seconds 5
}
