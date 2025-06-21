import subprocess, time, threading, os
def auto_log():
    def worker():
        while True:
            script = os.path.join(os.path.dirname(__file__), "..", "macan_insight.ps1")
            subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-File", script])
            time.sleep(3600)
    threading.Thread(target=worker, daemon=True).start()
