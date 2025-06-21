import tkinter as tk
from tkinter import ttk, filedialog, messagebox
import csv
import os

def load_csv(filepath):
    with open(filepath, newline='') as csvfile:
        reader = csv.reader(csvfile)
        data = list(reader)
    return data

# GUI
root = tk.Tk()
root.title("🗂️ MACAN LOG READER")
root.geometry("720x480")
root.config(bg="#0d0d0d")

style = ttk.Style()
style.configure("Treeview", background="#1a1a1a", foreground="#00f5ff", fieldbackground="#1a1a1a", font=("Consolas", 10))
style.configure("Treeview.Heading", font=("Consolas", 11, "bold"), foreground="#00ffff")
style.map("Treeview", background=[("selected", "#333333")])

# File picker
log_folder = os.path.join(os.getcwd(), "LOG_MACAN")
filetypes = [("CSV files", "*.csv")]

filename = filedialog.askopenfilename(initialdir=log_folder, title="Pilih file log", filetypes=filetypes)
if not filename:
    messagebox.showinfo("Batal", "Tidak ada file dipilih.")
    root.destroy()
    exit()

try:
    data = load_csv(filename)
except:
    messagebox.showerror("Error", "Gagal membaca file CSV.")
    root.destroy()
    exit()

headers = data[0]
rows = data[1:]

# Tabel
tree = ttk.Treeview(root, columns=headers, show="headings")
for col in headers:
    tree.heading(col, text=col)
    tree.column(col, anchor=tk.W, width=120)

for row in rows:
    tree.insert("", tk.END, values=row)


tree.pack(fill="both", expand=True, padx=10, pady=10)
root.mainloop()
