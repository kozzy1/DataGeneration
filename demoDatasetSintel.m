addpath('toolkit')
DownloadDatasetSintel;
flow_fmt = '.pfm';
% uncomment to generate flow in flo format 
% flow_fmt = '.flo';
GenerateNewDatasetSintel(flow_fmt);