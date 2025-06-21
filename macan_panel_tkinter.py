import tkinter as tk
import subprocess
import os
import webbrowser
import psutil


assets_path = os.path.dirname(os.path.abspath(__file__))

# --- Aksi tombol ---
def start_vpn():
    subprocess.Popen([os.path.join(assets_path, 'openvpn-gui.exe')])

def remote_access():
    subprocess.Popen('mstsc')

def macan_tweak():
    tweak_script = os.path.join(assets_path, "macan_tweak.bat")
    boost_script = os.path.join(assets_path, "macan_boost_module.bat")
    merged_script = os.path.join(assets_path, "macan_tweak_combo_temp.bat")

    # Gabungkan tweak + boost ke satu file temporer
    with open(merged_script, 'w') as f:
        f.write(f'@echo off\n"{tweak_script}"\n"{boost_script}"\n')

    # Jalankan dengan hak admin via powershell
    subprocess.Popen([
        'powershell', '-Command',
        f'Start-Process "{merged_script}" -Verb RunAs'
    ])

def macan_restore():
    tweak_script = os.path.join(assets_path, "macan_restore_all.bat")
    boost_script = os.path.join(assets_path, "macan_restore_module.bat")
    merged_script = os.path.join(assets_path, "macan_tweak_combo_temp.bat")

    # Gabungkan tweak + boost ke satu file temporer
    with open(merged_script, 'w') as f:
        f.write(f'@echo off\n"{tweak_script}"\n"{boost_script}"\n')

    # Jalankan dengan hak admin via powershell
    subprocess.Popen([
        'powershell', '-Command',
        f'Start-Process "{merged_script}" -Verb RunAs'
    ])
def file_server():
    subprocess.Popen(['explorer', os.path.join(assets_path, 'ServerFiles')])

def monitor_system():
    subprocess.Popen(['cmd', '/c', 'start', '', 'taskmgr'])

def loreng_insight():
    insight_path = os.path.join(assets_path, "macan_insight_allinone.bat")
    if os.path.exists(insight_path):
        subprocess.Popen([
            'powershell', '-Command',
            f'Start-Process "{insight_path}" -Verb RunAs'
        ])
    else:
        tk.messagebox.showwarning("Module Tidak Ditemukan", "⚠️ File macan_insight_allinone.bat belum tersedia!\nSilakan download module Loreng Insight dulu.")


def open_log_reader():
    reader_path = os.path.join(assets_path, "macan_log_reader_tkinter.py")
    if os.path.exists(reader_path):
        subprocess.Popen(["python", reader_path], cwd=assets_path)
    else:
        tk.messagebox.showwarning("Module Tidak Ditemukan", "⚠️ macan_log_reader_tkinter.py belum ditemukan!")

def update_usage():
    cpu = psutil.cpu_percent(interval=0.5)
    ram = psutil.virtual_memory()
    ram_used = ram.used // (1024 * 1024)
    ram_total = ram.total // (1024 * 1024)
    usage_label.config(text=f"🧠 CPU: {cpu}%   💾 RAM: {ram_used}/{ram_total}MB")
    root.after(1000, update_usage)  # refresh tiap 1 detik
    
def exit_panel():
    root.destroy()

# --- Setup GUI ---
root = tk.Tk()
root.title("🐅 MACAN KONTROL PANEL by DANX")
root.geometry()
root.config(bg="#000000")  # latar belakang gelap cyberpunk

# Font & warna tombol
BUTTON_COLOR = "#00f5ff"    # biru neon
BUTTON_BG = "#1a1a1a"
FONT_HEADER = ("Consolas", 17, "bold")
FONT_BUTTON = ("Consolas", 11)

# --- Header ---
title = tk.Label(root, text="🐅 MACAN KONTROL PANEL", fg=BUTTON_COLOR, bg="#0d0d0d", font=FONT_HEADER)
title.pack(pady=(20, 10))

# --- Tombol & Layout ---
def create_button(text, command):
    return tk.Button(root, text=text, command=command, font=FONT_BUTTON,
                     width=22, height=2, bg=BUTTON_BG, fg=BUTTON_COLOR, activebackground="#292929", bd=1)

# === Rakit Panel ====
plugin_frame = tk.Frame(root, bg="#0d0d0d")
plugin_frame.pack(pady=(12, 10))

plugin_label = tk.Label(plugin_frame, text="📦 MODUL LENGKAP MACAN", fg="white", bg="#0d0d0d", font=("Consolas", 10))
plugin_label.pack()


def run_plugin(file):
    path = os.path.join(assets_path, "MOD_MACAN", file)
    if file.endswith('.ps1'):
        subprocess.Popen(['powershell', '-ExecutionPolicy', 'Bypass', '-File', path])
    else:
        subprocess.Popen(['cmd', '/c', path])

def load_plugins():
    for file in os.listdir(os.path.join(assets_path, "MOD_MACAN")):
        if file.endswith(('.bat', '.ps1')):
            btn = tk.Button(plugin_frame, text=f"⚡ {file}", command=lambda f=file: run_plugin(f),
                            bg="#1a1a1a", fg="cyan", font=("Consolas", 10))
            btn.pack(pady=3)

load_plugins()

# === Status CPU/RAM (atas) ===
usage_label = tk.Label(root, text="", fg="#00f5ff", bg="#0d0d0d", font=("Consolas", 11))
usage_label.pack(pady=(8, 0))
update_usage()

# === Frame tombol utama (tempat .grid) ===
button_frame = tk.Frame(root, bg="#0d0d0d")
button_frame.pack(pady=(10, 20))

# === Buat ulang semua tombol di konteks button_frame ===
btn1 = create_button("🚀 Start VPN", start_vpn)
btn2 = create_button("🖥️ Remote Access", remote_access)
btn3 = create_button("🛠️ Macan Tweak", macan_tweak)
btn4 = create_button("📁 File Server", file_server)
btn5 = create_button("📊 Monitor System", monitor_system)
btn6 = create_button("🌀 Restore", macan_restore)
btn_insight = create_button("📊 Loreng Insight", loreng_insight)
btn_log = create_button("🗂️ Lihat Log", open_log_reader)

# === Grid 2 kolom rapi ===
btn1.grid(row=0, column=0, padx=10, pady=6, in_=button_frame)
btn2.grid(row=0, column=1, padx=10, pady=6, in_=button_frame)
btn3.grid(row=1, column=0, padx=10, pady=6, in_=button_frame)
btn4.grid(row=1, column=1, padx=10, pady=6, in_=button_frame)
btn_insight.grid(row=2, column=0, padx=10, pady=6, in_=button_frame)
btn_log.grid(row=2, column=1, padx=10, pady=6, in_=button_frame)
btn5.grid(row=3, column=0, padx=10, pady=6, in_=button_frame)
btn6.grid(row=3, column=1, padx=10, pady=6, in_=button_frame)


# --- Run ---
root.mainloop()
