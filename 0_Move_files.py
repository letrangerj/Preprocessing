## Remove files contain certain string in the name to a new folder
## create a new folder if dest_folder does not exist
## src_folder: source folder

import os
import shutil

def remove_files_contain_string(src_folder, string):
    dest_folder = src_folder + "/" + string
    if not os.path.exists(dest_folder):
        os.makedirs(dest_folder)
    for root, dirs, files in os.walk(src_folder):
        for file in files:
            if string in file and file[-4:] == ".tif":
                shutil.move(os.path.join(root, file), dest_folder)
                
src_folder = "4i_round1_20240330"
string = "WT"
remove_files_contain_string(src_folder, string)