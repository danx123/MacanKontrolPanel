# Macan Monitor Live 🐅
Clear-Host
Write-Host "🌀 MACAN LIVE MONITOR — KLAN STATUS" -ForegroundColor Cyan
Write-Host "Tekan CTRL+C untuk keluar.`n" -ForegroundColor DarkGray

while ($true) {
    $cpu = Get-Counter '\Processor(_Total)\% Processor Time'
    $mem = Get-WmiObject Win32_OperatingSystem
    $disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"

    $cpuLoad = "{0:N1}" -f ($cpu.CounterSamples.CookedValue)
    $usedMem = [math]::Round(($mem.TotalVisibleMemorySize - $mem.FreePhysicalMemory)/1024,1)
    $totalMem = [math]::Round($mem.TotalVisibleMemorySize/1024,1)
    $diskFree = [math]::Round($disk.FreeSpace / 1GB,1)

    Write-Host "🧠 CPU Load   : $cpuLoad %"
    Write-Host "💾 RAM Used   : $usedMem MB / $totalMem MB"
    Write-Host "📀 C:\ Free    : $diskFree GB`n"

    Start-Sleep -Seconds 5
    Clear-Host
}
