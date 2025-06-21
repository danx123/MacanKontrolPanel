import psutil, tkinter as tk
def run():
    win = tk.Toplevel()
    win.title("🧠 MINI MONITOR")
    win.geometry("320x160")
    lbl = tk.Label(win, font=("Consolas", 12), fg="cyan", bg="black")
    lbl.pack(fill='both', expand=True)

    def refresh():
        cpu = psutil.cpu_percent()
        ram = psutil.virtual_memory()
        txt = f"🧠 CPU: {cpu}%\n💾 RAM: {ram.used // (1024*1024)} / {ram.total // (1024*1024)} MB"
        lbl.config(text=txt)
        win.after(1000, refresh)

    refresh()
