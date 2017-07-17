function DownloadDatasetSintel()
command_wget = 'wget';
command_unzip = 'unzip';
if ispc
    command_wget = '"toolkit_win/wget"';
    command_unzip = '"toolkit_win/unzip"';
end

system([command_wget ' -c http://files.is.tue.mpg.de/jwulff/sintel/MPI-Sintel-stereo-training-20150305.zip']);
mkdir DatasetSintel;
cd DatasetSintel;
system([command_unzip '../MPI-Sintel-stereo-training-20150305.zip']);
cd ..
end