# Allow port VPN & RDP
New-NetFirewallRule -DisplayName "Allow RDP" -Direction Inbound -Protocol TCP -LocalPort 3389 -Action Allow
New-NetFirewallRule -DisplayName "Allow OpenVPN" -Direction Inbound -Protocol UDP -LocalPort 1194 -Action Allow

# Block semua koneksi asing (optional)
New-NetFirewallRule -DisplayName "Block Inbound Non-Local" -Direction Inbound -RemoteAddress Any -Action Block

# Route trafik ke VPN (OpenVPN example)
route add 0.0.0.0 mask 0.0.0.0 10.8.0.1 metric 1
