import winreg

def toggle():
    key = r'Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects'
    with winreg.OpenKey(winreg.HKEY_CURRENT_USER, key, 0, winreg.KEY_ALL_ACCESS) as reg:
        winreg.SetValueEx(reg, 'VisualFXSetting', 0, winreg.REG_DWORD, 2)  # 2 = best perf
