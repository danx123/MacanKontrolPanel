@echo off
title Restore Macan Module
color 0C
echo ♻️ Mengembalikan setting tambahan...

:: Kembalikan Large System Cache
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /f

:: Reset pagefile
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True

:: Aktifkan kembali Cortana
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f

:: Xbox Services kembali enabled
sc config XblAuthManager start=demand
sc config XblGameSave start=demand

:: Aktifkan layanan sistem
sc config DiagTrack start=auto
sc config dmwappushservice start=auto

echo ✅ Module restore selesai. Silakan restart!
pause
