import os, subprocess, tkinter as tk
from modules import scheduler, monitor_popup, lockmode, boostmode, scanner

root = tk.Tk()
root.title("🐅 MACAN DIGITAL LAUNCHER")
root.geometry()
root.config(bg="#0d0d0d")
assets_path = os.path.dirname(__file__)

def run_plugin(file):
    path = os.path.join(assets_path, "MOD_MACAN", file)
    subprocess.Popen(['powershell', '-ExecutionPolicy', 'Bypass', path if file.endswith('.ps1') else f'Start-Process \"{path}\" -Verb RunAs'])

def load_plugins():
    for widget in plugin_frame.winfo_children():
        widget.destroy()
    for file in os.listdir(os.path.join(assets_path, "MOD_MACAN")):
        if file.endswith(('.bat', '.ps1')):
            btn = tk.Button(plugin_frame, text=f"⚡ {file}", command=lambda f=file: run_plugin(f),
                            bg="#1a1a1a", fg="cyan", font=("Consolas", 10))
            btn.pack(pady=3)

tk.Button(root, text="📊 Mini Monitor", command=monitor_popup.run, bg="black", fg="cyan").pack(pady=6)
tk.Button(root, text="🔒 Lock Mode", command=lockmode.run, bg="black", fg="orange").pack(pady=6)
tk.Button(root, text="⚙️ Boost Mode", command=boostmode.toggle, bg="black", fg="magenta").pack(pady=6)
tk.Button(root, text="🛰️ Ping & IP Scan", command=scanner.run, bg="black", fg="lightgreen").pack(pady=6)

plugin_frame = tk.Frame(root, bg="#0d0d0d")
plugin_frame.pack(pady=(12, 10))
tk.Label(plugin_frame, text="📦 Plugin Macan", fg="white", bg="#0d0d0d").pack()
load_plugins()

root.after(1000, scheduler.auto_log)
root.mainloop()
