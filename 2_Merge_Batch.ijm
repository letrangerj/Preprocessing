// This script is created by Long, for displaying the images from microscope.
// The function is that: 
// 1. Batch color the images of different channels, and save the png file (blue is by default assigned to channel 0, which is usually DAPI);
// 2. Merge the channels of the same frame, save the merged image in png file.
// Note that the source images should be arraged in a certain structure, this is done by a python script, called 1_Name_process_compressed_simplify.py
// The results of this can be used for Cell Detection


var ch1 = 0
var ch2 = 0
var ch3 = 1
var ch4 = 0
var ch5 = 0
var ch6 = 0
var ch7 = 0
var Merge_Stacks = 1
var color

macro "Merge Option"{
	Dialog.create("Merge Option");
	Dialog.addCheckbox("c1 Red", ch1);
	Dialog.addCheckbox("c2 Green", ch2);
	Dialog.addCheckbox("c3 Blue", ch3);
	Dialog.addCheckbox("c4 Gray", ch4);
	Dialog.addCheckbox("c5 Cyan", ch5);
	Dialog.addCheckbox("c6 Magenta", ch6);
	Dialog.addCheckbox("c7 Yellow", ch7);
	Dialog.addCheckbox("Merge Stacks", Merge_Stacks);
	Dialog.show();
	     

	ch1=Dialog.getCheckbox();
	ch2=Dialog.getCheckbox();
	ch3=Dialog.getCheckbox();
	ch4=Dialog.getCheckbox();
	ch5=Dialog.getCheckbox();
	ch6=Dialog.getCheckbox();
	ch7=Dialog.getCheckbox();
	Merge_Stacks=Dialog.getCheckbox();
}

macro "Merge"{
  // Get user input directory

  dir = getDirectory("Choose a directory with subfolders containing image stacks");
  dirfile = getFileList(dir);
  dirnum = dirfile.length;
  setBatchMode(true); // Enable batch mode for faster processing
  c1 = ch1;
  c2 = ch2;
  c3 = ch3;
  c4 = ch4;
  c5 = ch5;
  c6 = ch6;
  c7 = ch7;


  // Loop through all subdirectories

  for (f=0; f<dirnum; f++){
    subDir = dir + "/" + dirfile[f];
    Run_Merge(subDir, c1, c2, c3, c4, c5, c6, c7); // Call function to process each subfolder
  }

  setBatchMode(false); // Disable batch mode
  print("MERGE CHANNELS FINISHED");
}

function Run_Merge(main_dir, ch1, ch2, ch3, ch4, ch5, ch6, ch7){
	dir=newArray();
	files=newArray();

	main_list=getFileList(main_dir);
	for (i=0; i<main_list.length;i++){
		if (endsWith(main_list[i],"/")){
			dir[i]=main_dir+main_list[i];
		}
	}
	outpath = dir[dir.length-1];
	Channel=dir.length-1;
	setBatchMode(true);
	Merge=newArray();
	for (i = 0; i < Channel; i++) {
		files = getFileList(dir[i]);
		fig=files.length;
		for (j = 0; j < fig; j++){
			name1=dir[i] + files[j];
			open(name1);
			//run("Brightness/Contrast...");
			run("Enhance Contrast", "saturated=0.35");
			getMinAndMax(min, max);
			setMinAndMax(min, max);
			if (i == 0)
			{
				Merge[i]="c3";
				run("Blue");
				run("RGB Color");
				saveAs("Png",outpath+"Blue"+files[j]);
				close();
			}
			else if (ch1==1)
			{
				Merge[i]="c1";
				run("Red");
				run("RGB Color");
				saveAs("Png",outpath+"Red"+files[j]);
				close();
				if (j==fig-1)
				{
					ch1=0;
				}
			}
			else if (ch2==1)
			{
				Merge[i]="c2";
				run("Green");
				run("RGB Color");
				saveAs("Png",outpath+"Green"+files[j]);
				close();
				if (j==fig-1)
				{
					ch2=0;
				}
			}
			else if (ch4==1)
			{
				Merge[i]="c4";
				run("Gray");
				run("RGB Color");
				saveAs("Png",outpath+"Gray"+files[j]);
				close();
				if (j==fig-1)
				{
					ch4=0;
				}
			}
			else if (ch5==1)
			{
				Merge[i]="c5";
				run("Cyan");
				run("RGB Color");
				saveAs("Png",outpath+"Cyan"+files[j]);
				close();
				if (j==fig-1)
				{
					ch5=0;
				}
			}
			else if (ch6==1)
			{
				Merge[i]="c6";
				run("Magenta");
				run("RGB Color");
				saveAs("Png",outpath+"Magenta"+files[j]);
				close();
				if (j==fig-1)
				{
					ch6=0;
				}
			}
			else if (ch7==1)
			{
				Merge[i]="c7";
				run("Yellow");
				run("RGB Color");
				saveAs("Png",outpath+"Yellow"+files[j]);
				close();
				if (j==fig-1)
				{
					ch7=0;
				}
			}
		}
	}
	for (j = 0; j < fig; j++){
		file=newArray();
		name=newArray();
		Merge_String="";
		for (i = 0; i < Channel; i++){
			m_files = getFileList(dir[i]);
			file[i]=m_files[j];
			name[i]=dir[i]+m_files[j];
			open(name[i]);
			//run("Brightness/Contrast...");
			run("Enhance Contrast", "saturated=0.35");
			getMinAndMax(min, max);
			setMinAndMax(min, max);
			Merge_String=Merge_String+Merge[i]+"="+file[i]+" ";
		}
		run("Merge Channels...", Merge_String+" keep");
		saveAs("Png", outpath+j);
		close();
	}
	close("*");
	if (Merge_Stacks==1){
		for (j=0; j<fig; j++){
			open(outpath+j+".png");
		}
		run("Images to Stack", "use");
		run("Z Project...", "projection=[Max Intensity]");
		saveAs("Png", main_dir+"Stacked");
		close();
	}
	close("*");

	setBatchMode(false);	
}