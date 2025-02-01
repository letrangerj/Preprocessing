import os
import shutil

# Define the path to the folder containing the images
src_path = 'D:/Linlab/IF/4I/4I_HistoneFormal/Formal'

# Get the parent folder of the src_path
src_folder = os.path.dirname(src_path)

# Define the path to the folder containing the stitched images
Stitch_path = os.path.join(src_folder, 'Stitch')

# Get all the folders in src_path
folders = os.listdir(src_path)

def get_DAPI(folder):
    # Define the path to the folder containing the stitched images
    if not os.path.exists(os.path.join(Stitch_path, folder)):
        os.makedirs(os.path.join(Stitch_path, folder))
        
    # Get all the rounds in the folder
    Rounds = os.listdir(os.path.join(src_path, folder))
    for Round in Rounds:
        # Copy the DAPI image to the Stitch folder
        DPAI_path = os.path.join(src_path, folder, Round, '5.png')
        shutil.copy(DPAI_path, os.path.join(Stitch_path, folder, f'{Round}_DAPI.png'))
    
    return

for folder in folders:
    get_DAPI(folder)
    
print('All DAPI images have been copied to the Stitch folder.')