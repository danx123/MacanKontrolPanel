import tkinter as tk, socket, os
def run():
    win = tk.Toplevel()
    win.title("🌐 Network Scan")
    ip_local = socket.gethostbyname(socket.gethostname())
    res = os.popen(f"ping 8.8.8.8").read()
    txt = f"📡 IP Lokal: {ip_local}\n\nPing 8.8.8.8:\n{res}"
    tk.Label(win, text=txt, font=("Consolas", 9), fg="lime", bg="black", justify='left').pack(fill='both')
