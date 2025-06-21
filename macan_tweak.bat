@echo off
title Modul Tambahan - Macan Boost Stack
color 0E
echo 🔧 Mengaktifkan fitur tambahan Macan Loreng...

:: Aktifkan Large System Cache
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f

:: Optimalkan pagefile (RAM ≥ 16GB)
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=1024,MaximumSize=4096

:: Disable Cortana
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

:: Disable Xbox Services
sc stop XblAuthManager
sc config XblAuthManager start=disabled
sc stop XblGameSave
sc config XblGameSave start=disabled

:: Matikan services tidak penting
sc config DiagTrack start=disabled
sc config dmwappushservice start=disabled

:: Bersihkan prefetch & delivery optimization
del /q /f /s C:\Windows\Prefetch\*
del /q /f /s C:\Windows\SoftwareDistribution\Download\*

echo ✅ Boost module selesai! Silakan restart untuk efek penuh.
pause
