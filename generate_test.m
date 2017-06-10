clear;close all;
%% settings
folder = 'Test';
savepath = 'test.h5';
size_input_h = 59; size_input_w = 67;
size_label_h = 51; size_label_w = 51;
stride = 14 ;

%% initialization
data = zeros(size_input_w, size_input_h, 1, 1);
label = zeros(size_label_w, size_label_h, 1, 1);
padding_h = abs(size_input_h - size_label_h)/2; padding_w = abs(size_input_w - size_label_w)/2;
count = 0;

%% generate data
filepaths = dir(fullfile(folder,'*'));
    
for i = 3 : length(filepaths)
    
    image = imread(fullfile(folder,filepaths(i).name));
    if size(image, 3) == 3,
            image = rgb2ycbcr(image);
    end
    image = im2double(image(:, :, 1));
    
    im_label = image;
    [hei,wid] = size(im_label);
   noise=random('norm',0,0.02,1,wid);
     im_input=image+repmat(noise,hei,1);

    for x = 1 : stride : hei-size_input_h+1
        for y = 1 :stride : wid-size_input_w+1
            
            subim_input = im_input(x : x+size_input_h-1, y : y+size_input_w-1);
            subim_label = im_label(x+padding_h : x+padding_h+size_label_h-1, y+padding_w : y+padding_w+size_label_w-1);

            count=count+1;
            data(:, :, 1, count) = subim_input';
            label(:, :, 1, count) = subim_label';
        end
    end
end

order = randperm(count);
data = data(:, :, 1, order);
label = label(:, :, 1, order); 

%% writing to HDF5
chunksz = 2;
created_flag = false;
totalct = 0;

for batchno = 1:floor(count/chunksz)
    last_read=(batchno-1)*chunksz;
    batchdata = data(:,:,1,last_read+1:last_read+chunksz); 
    batchlabs = label(:,:,1,last_read+1:last_read+chunksz);

    startloc = struct('dat',[1,1,1,totalct+1], 'lab', [1,1,1,totalct+1]);
    curr_dat_sz = store2hdf5(savepath, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
    created_flag = true;
    totalct = curr_dat_sz(end);
end
h5disp(savepath);
