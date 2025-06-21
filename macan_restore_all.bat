@echo off
title Restore Loreng Default
color 0C
echo ♻️ Restore dimulai...

:: Power Plan ke Balanced
powercfg /s SCHEME_BALANCED

:: Hapus tweak visual & indexing
reg delete "HKCU\Control Panel\Desktop" /v DragFullWindows /f
sc config WSearch start=delayed-auto
sc start WSearch

:: Reset telemetry
reg delete "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f

:: Game mode OFF
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f

:: Enable pagefile otomatis
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True

:: Enable HAGS default
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /f

:: Aktifkan kembali services & Cortana
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f
sc config XblAuthManager start=manual
sc config XblGameSave start=manual
sc config DiagTrack start=auto
sc config dmwappushservice start=auto

echo ✅ Restore selesai bro! Bisa direstart sekarang.
pause
