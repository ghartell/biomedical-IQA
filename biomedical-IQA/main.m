%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project -- Automated Medical Image Quality Analysis
% Author #1: Ginette Hartell, 500755250
% Author #2: Yonathan Libenzon, 500758409
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HOUSEKEEPING

clc
close all
clear
%% SET UP PATHS

pathMain = 'C:\Users\ginet\OneDrive\Documents\MATLAB\BME872\biomedical-image-analysis\Project\';

lab3DataPath1 = strcat(pathMain,'LungCT\');
lab3DataPath2 = strcat(pathMain,'BrainMRI2');

addpath(lab3DataPath1, lab3DataPath2);

%% READ IN IMAGES

%Read in MHD Lung CT files
[training_post, infoCT_training_post] = imageRead('C:\Users\ginet\OneDrive\Documents\MATLAB\BME872\biomedical-image-analysis\Project\LungCT\training_post.mhd', '.mhd');
[noise_10x_post, infoCT_noise_10x_post] = imageRead('C:\Users\ginet\OneDrive\Documents\MATLAB\BME872\biomedical-image-analysis\Project\LungCT\noise_10x_post.mhd', '.mhd');

%Define sample slices and assign variables
volCT = training_post.data;
volCT_slice75 = volCT(:,:,75);
volCT_slice80 = volCT(:,:,80);
volCTnoise10x = noise_10x_post.data;
volCT_slice75noise10x = volCTnoise10x(:,:,75);
volCT_slice80noise10x = volCTnoise10x(:,:,80);

%Load sample slices from MRI volumes
temp = load('brainMRI_1.mat');
brainMRI_1 = temp.vol(:,:,75);
temp = load('brainMRI_2.mat');
brainMRI_2 = temp.vol(:,:,75);
temp = load('brainMRI_3.mat');
brainMRI_3 = temp.vol(:,:,75);
temp = load('brainMRI_4.mat');
brainMRI_4 = temp.vol(:,:,75);
temp = load('brainMRI_5.mat');
brainMRI_5 = temp.vol(:,:,75);
temp = load('brainMRI_6.mat');
brainMRI_6 = temp.vol(:,:,75);

%% 2.1 - IMAGE NOISE QUALITY

%Compute noise level for 10 lung CT slices
lung_normal_noise = zeros(1, 10);
lung_10x_noise = zeros(1, 10);
lung_nique = zeros(1, 10);
lung_10x_nique = zeros(1, 10);
for i = 70:80
    lung_normal_noise(:, i-69) = imageQuality_noise(volCT(:,:,i));
    lung_10x_noise(:, i-69) = imageQuality_noise(volCTnoise10x(:,:,i));
    lung_nique = niqe(volCT(:,:,i));
    lung_10x_nique = niqe(volCTnoise10x(:,:,i));
end 

%Plot noise levels for each lungslice
figure
scatter(70:80, lung_normal_noise(:), '.b')
title('Noise Level for Lung Slices 70-80');
hold on
scatter(70:80, lung_10x_noise(:), '.r')
legend on
hold off

%Compute noise level for MRI Slice 75 in each dataset
brain_noise = zeros(1, 6);
brain_niqe = zeros(1, 6);
for i = 1:6
    brain_noise(:, i) = imageQuality_noise(eval(strcat('brainMRI_', num2str(i))));
    brain_niqe(:,i) = niqe(eval(strcat('brainMRI_', num2str(i))));
end

%Plot noise levels for each MRI Slice 75 in each dataset
figure
scatter(1:6, brain_noise(:))
title('Noise Level for MRI Slice 75 in each Dataset');

NOISE_QUALITY = brain_noise';

%% 2.2 - IMAGE CONTRAST QUALITY
%Simple mask for the LungCT, using original Slice 75 as a base.
%Avoids black background being perceived as part of the lung.
mask75 = imfill(volCT_slice75, 'holes');
mask75 = imbinarize(mask75);

%Comparing constrast quality accross 10 sets of lung slices from two datasets
lung_normal_contrast = zeros(1, 10);
lung_10x_contrast = zeros(1, 10);
for i = 70:80
    lung_normal_contrast(:, i-69) = imageQuality_contrast(volCT(:,:,i).*mask75);
    fprintf(['CONTRAST Quality (Normal Lung): ', num2str(lung_normal_contrast(:, i-69)), '\n ']); 
    lung_10x_contrast(:, i-69) = imageQuality_contrast(volCTnoise10x(:,:,i).*mask75);
    fprintf(['CONTRAST Quality (Noisy Lung): ', num2str(lung_10x_contrast(:, i-69)), '\n ']);
end 

%Plot constrast levels for each lungslice
figure
scatter(70:80, lung_normal_contrast(:), 300, '.b')
title('Constrast Levels for Lung Slices 70-80');
hold on
scatter(70:80, lung_10x_contrast(:), 300, '.r')
legend on
hold off

%Comparing multiple slices from brainMRI2, where CMRI1 has almost no noise, 
%CMRI3 has some noise, and CMRI6 has the most noise and as such the worst contrast quality. 
CMRI = zeros(1, 6);
for i = 1:6
    CMRI(i) = imageQuality_contrast(eval(strcat('brainMRI_', num2str(i)))); %Final result of this section.
    fprintf(['CONTRAST Quality: ', num2str(CMRI(i)), '\n ']);
end

%Plot noise levels for each MRI Slice 75 in each dataset
figure
scatter(1:6, CMRI(:))
title('Constrast Levels for MRI Slice 75 in each Dataset');

CONTRAST_QUALITY = CMRI';

%% 2.3 - IMAGE EDGE QUALITY

%Comparing edge quality accross 10 sets of lung slices from two datasets
lung_normal_edge = zeros(1, 10);
lung_10x_edge = zeros(1, 10);
for i = 70:80
    lung_normal_edge(:, i-69) = imageQuality_edge(volCT(:,:,i));
    fprintf(['EDGE Quality (Normal Lung): ', num2str(lung_normal_edge(:, i-69)), '\n ']); 
    lung_10x_edge(:, i-69) = imageQuality_edge(volCTnoise10x(:,:,i));
    fprintf(['EDGE Quality (Noisy Lung): ', num2str(lung_10x_edge(:, i-69)), '\n ']);
end 

%Plot constrast levels for each lungslice
figure
scatter(70:80, lung_normal_edge(:), '.b')
title('Edge Levels for Lung Slices 70-80');
hold on
scatter(70:80, lung_10x_edge(:), '.r')
legend on
hold off

%Comparing multiple slices from brainMRI2, where CMRI1 has almost no noise, 
%CMRI3 has some noise, and CMRI6 has the most noise and as such the worst contrast quality. 
EMRI = zeros(1, 6);
for i = 1:6
    EMRI(i) = imageQuality_edge(eval(strcat('brainMRI_', num2str(i)))); %Final result of this section.
    fprintf(['EDGE Quality: ', num2str(EMRI(i)), '\n ']);
end

%Plot noise levels for each MRI Slice 75 in each dataset
figure
scatter(1:6, EMRI(:))
title('Constrast Levels for MRI Slice 75 in each Dataset');

EDGE_QUALITY = EMRI';

%% 2.4 - QUALITY OUTPUT TABLE
MRI_LIST = ["Brain MRI #1";"Brain MRI #2";"Brain MRI #3";"Brain MRI #4";"Brain MRI #5";"Brain MRI #6"];
out_table = table(MRI_LIST, NOISE_QUALITY, CONTRAST_QUALITY, EDGE_QUALITY) 
