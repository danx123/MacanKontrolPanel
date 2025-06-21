import ctypes, winsound
def run():
    winsound.PlaySound("SystemExit", winsound.SND_ALIAS)
    ctypes.windll.user32.LockWorkStation()
