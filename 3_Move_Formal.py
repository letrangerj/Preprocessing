import os
import shutil
from tkinter import filedialog


def get_folders(path):
    folders = []
    for folder in os.listdir(path):
        if os.path.isdir(os.path.join(path, folder)):
            folders.append(os.path.join(path, folder))
    return folders

def copy_folders(src, dst, R, i):
    for folder in get_folders(src):
        if 'Merge' in folder:
            sub_path = dst + f'/frame_{i}'
            if not os.path.exists(sub_path):
                    os.makedirs(sub_path)
            if os.path.exists(sub_path + f'/R{R}'):
                shutil.rmtree(sub_path + f'/R{R}')
            shutil.copytree(os.path.join(src, folder), sub_path + f'/R{R}')
    return

print('please choose your source file directory:')
# eg: folder_path = 'D:/Linlab/IF/4I/4I_Formal/4i_round1_20240330/WT/WT'
folder_path = filedialog.askdirectory()

print('please choose your destination file directory:')
# eg: dst_folder = "D:/Linlab/IF/4I/4I_Formal/Analyse/WT"
dst_folder = filedialog.askdirectory()

#R = 1
R = int(input('Please input the order of the round: '))

frames = get_folders(folder_path)
for i, frame in enumerate(frames):
    copy_folders(frame, dst_folder, R, i)
