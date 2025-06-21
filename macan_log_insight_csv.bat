@echo off
title Macan Log Insight to CSV
color 0A
echo 📈 Logging performa ke CSV...

setlocal EnableDelayedExpansion

:: Folder log
set "LOGFOLDER=%~dp0LOG_MACAN"
if not exist "%LOGFOLDER%" mkdir "%LOGFOLDER%"

:: Timestamp
for /f "tokens=1-4 delims=/ " %%a in ("%date%") do (
    set "MONTH=%%a"
    set "DAY=%%b"
    set "YEAR=%%c"
)
set TIMESTAMP=%YEAR%-%MONTH%-%DAY%_%time:~0,2%%time:~3,2%%time:~6,2%
set CSVFILE=%LOGFOLDER%\macan_log_%TIMESTAMP%.csv

:: Write CSV headers
echo Time,SystemName,CPU Load (%),Free RAM (MB),Total RAM (MB),Drive C Free (GB),Public IP > "%CSVFILE%"

:: Get hostname
for /f %%a in ('hostname') do set HOSTNAME=%%a

:: Get CPU usage (top process snapshot)
for /f "skip=1 tokens=2" %%a in ('wmic cpu get loadpercentage') do (
    if not "%%a"=="" set CPU=%%a
)

:: Get RAM
for /f "skip=1 tokens=2,3" %%a in ('wmic OS get FreePhysicalMemory^,TotalVisibleMemorySize') do (
    if not "%%a"=="" (
        set /a FREERAM=%%a/1024
        set /a TOTALRAM=%%b/1024
    )
)

:: Get Drive C space
for /f "skip=1 tokens=3" %%a in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace') do (
    if not "%%a"=="" set /a DISKGB=%%a/1024/1024/1024
)

:: Get public IP (if online)
for /f "delims=" %%i in ('powershell -Command "(Invoke-WebRequest -Uri 'https://api.ipify.org').Content"') do set PUBLICIP=%%i

:: Append CSV line
echo %TIMESTAMP%,%HOSTNAME%,%CPU%,%FREERAM%,%TOTALRAM%,%DISKGB%,%PUBLICIP% >> "%CSVFILE%"

echo ✅ Log selesai bro: %CSVFILE%
pause
