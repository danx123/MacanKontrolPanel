@echo off
title MACAN INSIGHT HYBRID 🧠🐅
color 0A

set "LOGFOLDER=%~dp0LOG_MACAN"
if not exist "%LOGFOLDER%" mkdir "%LOGFOLDER%"

for /f "tokens=1-3 delims=/ " %%a in ("%date%") do set DATE=%%c-%%a-%%b
set TIME=%time:~0,2%%time:~3,2%%time:~6,2%
set STAMP=%DATE%_%TIME%
set LOGFILE=macan_log_%STAMP%.csv
set CSVPATH=%LOGFOLDER%\%LOGFILE%

:: === Header CSV ===
echo Timestamp,Hostname,CPU Load,Free RAM (MB),Total RAM (MB),Disk C Free (GB),Public IP > "%CSVPATH%"

:: === Call PowerShell to collect data and append to CSV ===
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ts = '%STAMP%';" ^
    "$host = $env:COMPUTERNAME;" ^
    "$cpu = [math]::Round((Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue,1);" ^
    "$os = Get-CimInstance Win32_OperatingSystem;" ^
    "$freeRAM = [math]::Round($os.FreePhysicalMemory / 1024, 1);" ^
    "$totalRAM = [math]::Round($os.TotalVisibleMemorySize / 1024, 1);" ^
    "$disk = Get-CimInstance Win32_LogicalDisk -Filter \"DeviceID='C:'\";" ^
    "$diskFree = [math]::Round($disk.FreeSpace / 1GB, 1);" ^
    "try { $ip = (Invoke-RestMethod -Uri 'https://api.ipify.org') } catch { $ip = 'N/A' };" ^
    "Add-Content -Encoding UTF8 '%CSVPATH%' \"$ts,$host,$cpu,$freeRAM,$totalRAM,$diskFree,$ip\""

echo ✅ Log snapshot tersimpan: %CSVPATH%
echo.

:: === Start live monitor ===
powershell -ExecutionPolicy Bypass -Command "& {
  Clear-Host;
  Write-Host 'MACAN LIVE MONITOR 🧠🐅' -ForegroundColor Cyan;
  while ($true) {
    $cpu = Get-Counter '\Processor(_Total)\% Processor Time';
    $mem = Get-CimInstance Win32_OperatingSystem;
    $disk = Get-CimInstance Win32_LogicalDisk -Filter \"DeviceID='C:'\";
    $cpuLoad = [math]::Round($cpu.CounterSamples.CookedValue,1);
    $used = [math]::Round(($mem.TotalVisibleMemorySize - $mem.FreePhysicalMemory)/1024,1);
    $total = [math]::Round($mem.TotalVisibleMemorySize/1024,1);
    $freeC = [math]::Round($disk.FreeSpace/1GB,1);
    Clear-Host;
    Write-Host \"🧠 CPU Load  : $cpuLoad %%\";
    Write-Host \"💾 RAM Used : $used / $total MB\";
    Write-Host \"📀 Disk C    : $freeC GB Free\";
    Start-Sleep -Seconds 5;
  }
}"
