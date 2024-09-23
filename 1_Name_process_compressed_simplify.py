import os
import shutil
from tkinter import filedialog

#设定源文件夹和的路径并获取所有文件名
print('please choose your file directory:')
folder_path=filedialog.askdirectory()
file_names=os.listdir(folder_path)


#获取所有的荧光通道数量
print('please input the number of the fluorecent channels:')
num_of_channels=int(input())

#这个函数完成将每组实验的细胞按照荧光通道分配到不同的文件夹中并重命名
def renamefile(target_path):
    new_files=os.listdir(target_path)
    merge_path=target_path+'/'+'Merge'
    if not os.path.exists(merge_path):
                os.makedirs(merge_path)
    for i in range(num_of_channels):
        for file in new_files:
            if file.__contains__(f'ch0{i}.png'):
                old_path=os.path.join(target_path,file)
                sub_path=target_path+'/'+f'Channel{i}'
                if not os.path.exists(sub_path):
                    os.makedirs(sub_path)
                length=len(os.listdir(sub_path))
                new_path=os.path.join(target_path+'/'+f'Channel{i}',str(length)+f'ch{i}'+'.png')
                os.rename(old_path,new_path)
            else:
                 pass

print('please input the number of cell types:')
num_cell_type=int(input())
#获取细胞种类的数量（或是这组图片想要分的组数）
for i in range(num_cell_type):
    #获取每组实验的名称，用于将图片分配到对应的路径中
    cell_type = f'-{i+1}-'
    for file_name in file_names:
        for j in range(1, 5):            
            clone_type = cell_type + f'{j}'
            if file_name.__contains__(clone_type):
                target_path=folder_path+'/'+clone_type
                if not os.path.exists(target_path):
                    os.makedirs(target_path)
                shutil.copyfile(folder_path+'/'+file_name,target_path+'/'+file_name)
                renamefile(target_path)
            else:
                continue
        else:
            pass
