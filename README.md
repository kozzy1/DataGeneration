# Project1

This project synthesises flow data from stereo disparity data.
It is written under Matlab2016b and Ubuntu 16.04, and tested under Ubuntu 16.04 and Win 10.
The principle is that we add random vertical disparity on the x disparity in the stereo dataset "Sintel" and "SceneFlow".

The range of the vertical disparity is 1% of the vertical dimension of the image.


# toolkit

The directory contains some functions for the IO operations of the various file formats of the flow files and the functions of downloading and generating new data.


# toolkit_win

The directory contains some toolkits for Win.
These toolkits can be download at Ubuntu using the following command(s):

sudo apt-get install bzip2 unzip webp 


# demoDatasetSintel.m

The file downloads original color image data (clean and final) and stereo disparity data, and generate new color image data with vertical disparity and flow data.






