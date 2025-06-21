@echo off
title Modul Boost Loreng
color 0E
echo 🔧 Mengaktifkan Macan Boost Module...

:: Pagefile manual (1-4GB)
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=1024,MaximumSize=4096

:: Disable Cortana
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

:: Disable Xbox & tracking services
sc stop XblAuthManager & sc config XblAuthManager start=disabled
sc stop XblGameSave & sc config XblGameSave start=disabled
sc stop DiagTrack & sc config DiagTrack start=disabled
sc stop dmwappushservice & sc config dmwappushservice start=disabled

:: Clean prefetch & update download
del /q /f /s C:\Windows\Prefetch\*
del /q /f /s C:\Windows\SoftwareDistribution\Download\*

echo ✅ Boost aktif! Restart recommended bro.
pause
