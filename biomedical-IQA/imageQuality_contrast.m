function [output] = imageQuality_contrast(in_img)

in_img = double(in_img);
[M, N] = size(in_img);

%Initialize average filter
avg_filter = (1/331)*[1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1];

%Apply average filter to smooth the image
in_img_avg = spatial_filter(in_img, avg_filter);

%Apply bilateral filter to smooth image further while preserving edges
in_img_avg = imbilatfilt(in_img_avg);

%Apply contrast stretch
in_img_stretch = contrast_stretch(in_img_avg, 255);

%Apply histogram equalization
% in_img_eq = histogramEqLocal(cast(in_img_stretch,'uint8'), ceil(sqrt(M)), ceil(sqrt(N)));
in_img_eq = histogramEqualization(cast(in_img_stretch,'uint8'), 255);

%Plotting
figure
subplot(221)
imshow(in_img_avg, []);
colorbar;
title('Averaged Input Image')
subplot(222)
[binsRef freqRef] = intensityHistogram(in_img, 200);
title('Original Image Histogram')
subplot(223)
imshow(in_img_eq, [])
colorbar
title('Applied Histogram Equalization and Stretch')
subplot(224)
[binsEq freqEq] = intensityHistogram(in_img_eq, 200);
title('Histogram of Equalized Image')

%Find regular entropy via histograms
ent_img_arr = binsRef .* log10(binsRef) ./ log(2);
ent_img = (-1)*sum(ent_img_arr); %Cross entropy with equalized img as reference
ent_ref_arr = binsEq .* log10(binsEq) ./ log(2);
ent_ref = (-1)*sum(ent_ref_arr); %Cross entropy with original img as reference

%Find cross-entropy via histograms
ent_ref2img_arr = binsRef .* log10(binsEq) ./ log(2);
ent_ref2img = (-1)*sum(ent_ref2img_arr); %Cross entropy with equalized img as reference
ent_img2ref_arr = binsEq .* log10(binsRef) ./ log(2);
ent_img2ref = (-1)*sum(ent_img2ref_arr); %Cross entropy with original img as reference

%Find difference in cross entropies and regular entropies
ent_reg_diff = ent_img - ent_ref;
ent_cross_diff = ent_ref2img - ent_img2ref;
%Get ratio of the two
ent_ratio = real(ent_cross_diff / ent_reg_diff);

%Final ouput: Difference between the real component of the Cross-Entropy ratio to SSIM.
output = ent_ratio;


end