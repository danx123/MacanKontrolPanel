@echo off
color 0A
title 🧹 Auto Clean Temp Macan

echo [🧹] Membersihkan folder TEMP...
del /s /f /q %TEMP%\*.* >nul
for /d %%i in (%TEMP%\*) do rd /s /q "%%i"

echo [🧹] Membersihkan folder Windows\Temp...
del /s /f /q C:\Windows\Temp\*.* >nul
for /d %%i in (C:\Windows\Temp\*) do rd /s /q "%%i"

echo [✅] Selesai! Temp sudah dibersihkan.
pause
