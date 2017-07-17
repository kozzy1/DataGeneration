% This manuscript generates flow from disparity for Sintel Dataset
function GenerateNewDatasetSintel(flow_fmt)

switch flow_fmt
    case '.pfm'
        write_flow = @write_pfm;
    case '.flo'
        write_flow = @write_flo;
    otherwise
        warning('Unexpected file format')
end

% sdk for read disparity 
addpath('./DatasetSintel/sdk/matlab');
read_disp = @disparity_read;


all_data_dir = './DatasetSintel/training/';
cg_list = {'clean', 'final'};

list = dir([all_data_dir 'clean_left/']);
isub = [list(:).isdir]; %# returns logical vector
video_list = {list(isub).name};
video_list(ismember(video_list,{'.','..'})) = [];

for cg = cg_list    
    left_new_dir = [all_data_dir cg{1} '_left_new/'];
    right_new_dir = [all_data_dir cg{1} '_right_new/'];
    mkdir(left_new_dir);
    mkdir(right_new_dir);
     
    for video = video_list
        mkdir([left_new_dir video{1} '/']);
        mkdir([right_new_dir video{1} '/']);
    end
end

disp_new_dir = [all_data_dir 'flow_new/'];
mkdir(disp_new_dir);
for video = video_list
    mkdir([disp_new_dir video{1} '/']);
end



for video = video_list
    list = dir([all_data_dir 'clean_left/' video{1} '/*.png']);
    frame_list = {list.name};
    for frame = frame_list
        disp_file = [all_data_dir 'disparities/' video{1} '/' frame{1}];
        [~,name,~] = fileparts(frame{1});

        flow_new_file = [all_data_dir 'flow_new/' video{1} '/' name flow_fmt];
        
        xdisp = -read_disp(disp_file);
%         xrange = max(abs(xdisp(:)));
%         xrange

        [h, w, ~] = size(xdisp);
        yrange = h / 100.0;
        ydisp = (rand(round(h/100), round(w/100)) - 0.5) * yrange;
        ydisp = imresize(ydisp, [h w], 'bilinear');
        
        [x, y] = meshgrid(1:w, 1:h);
        y2 = y + ydisp;
        y2(y2 > h) = h;
        y2(y2 < 1) = 1;
        
        xdisp2 = interp2_multi(xdisp, x, y2, 'nearest');
        
        flow = cat(3, xdisp2, ydisp);
        write_flow(flow, flow_new_file);
        
        for cg = cg_list
            left_file = [all_data_dir cg{1} '_left/' video{1} '/' frame{1}];
            right_file = [all_data_dir cg{1} '_right/' video{1} '/' frame{1}];
            
            left = im2double(imread(left_file));
            left2 = interp2_multi(left, x, y2, 'linear');
            
            left_new_file = [all_data_dir cg{1} '_left_new/' video{1} '/' frame{1}];
            right_new_file = [all_data_dir cg{1} '_right_new/' video{1} '/' frame{1}];

            imwrite(left2, left_new_file);
            copyfile(right_file, right_new_file);
        end
    end
end
end
