function DownloadDatasetSintel()
command_wget = 'wget';
if ispc
    command_wget = '"toolkit_win/wget"';
end

system([command_wget ' -c http://files.is.tue.mpg.de/jwulff/sintel/MPI-Sintel-stereo-training-20150305.zip']);
mkdir DatasetSintel;
cd DatasetSintel;
unzip ../MPI-Sintel-stereo-training-20150305.zip;
cd ..
end