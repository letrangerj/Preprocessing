/// This is a imageJ macro script to rotate images by a input angle, written by Wu Long
/// For the use of processing 4I results.


// Define the directory
dir = getDirectory("Choose Source Directory ");

//Define output directory
outdir = getDirectory("Choose Output Directory ");

// Input the angle to be rotated:
sigma = getNumber("Enter the angle to be rotated (clockwise):", 0);

// Get a list of all files in the directory
list = getFileList(dir);

setBatchMode(true); 
// Loop through all files in the directory
for (i=0; i<list.length; i++) {
    // Open the image
    open(dir+list[i]);
    // Rotate the image 1 degree right (clockwise)
    run("Rotate...", "angle=sigma grid=1 interpolation=Bilinear");
    // Save the rotated image with a new name
    saveAs("Png", outdir+list[i]);
    // Close the image
    close();
}
setBatchMode(false);