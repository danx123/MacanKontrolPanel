Write-Host "`n🖥️ Merestart Remote Desktop Services..." -ForegroundColor Cyan
Restart-Service TermService -Force

Write-Host "`n🔐 Memastikan firewall rule RDP aktif..."
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "`n✅ Remote Desktop Services telah di-reset."
Start-Sleep -Seconds 2
