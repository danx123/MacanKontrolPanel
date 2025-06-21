@echo off
title Restore Default Windows
color 0C
echo ♻️ Mengembalikan pengaturan default...

:: Power Plan ke Balanced
powercfg /s SCHEME_BALANCED

:: Visual Effect ke Let Windows choose
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /f
reg delete "HKCU\Control Panel\Desktop" /v DragFullWindows /f

:: Aktifkan kembali indexing
sc config "WSearch" start=delayed-auto
sc start "WSearch"

:: Aktifkan Telemetry (Default Windows)
reg delete "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f

:: Matikan Game Mode
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f

:: Reset GPU HAGS
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /f

echo ✅ Sistem dikembalikan ke default. Silakan restart!
pause
