setBatchMode(true);

Path = getDirectory("Choose a directory with subfolders containing image to be stitched");
Target = getDirectory("Choose a directory in which you want to save the alignment results");
subPath = getFileList(Path);
dirnum = subPath.length; 

for (i = 0; i <= dirnum-1; i++) {
    // Construct directory path
    dirPath = Path + "/" + subPath[i];
    
    // Exit loop if folder doesn't exist
    if (!File.exists(dirPath)) {
        break;
    }
    
    // Create list of image files
    imageList = "";
    for (j = 1; j <= 5; j++) {
        imageList += " r" + j + "_dapi.png";
    }
    imageList = substring(imageList, 1); // Remove leading space
    
    // Run stitching command
    run("Grid/Collection stitching", 
        "type=[Unknown position] " +
        "order=[All files in directory] " +
        "directory=" + dirPath + " " +
        "confirm_files " +
        "output_textfile_name=" + "/TileConfiguration.txt " +
        "fusion_method=[Linear Blending] " +
        "regression_threshold=0.30 " +
        "max/avg_displacement_threshold=2.50 " +
        "absolute_displacement_threshold=3.50 " +
        "computation_parameters=[Save memory (but be slower)] " +
        "image_output=[Fuse and display] " + 
        "r1_dapi.png r2_dapi.png r3_dapi.png r4_dapi.png r5_dapi.png");
    
    // Move the TileConfiguration.txt to target folder
    ori_path = dirPath + "/TileConfiguration.registered.txt";
    tg_path = Target + "/" + subPath[i] + "/TileConfiguration.registered.txt";
    File.copy(ori_path, tg_path);
    
    // Add delay and forced garbage collection
    run("Collect Garbage");
}