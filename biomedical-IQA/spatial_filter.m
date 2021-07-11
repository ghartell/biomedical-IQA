function [out_img] = spatial_filter(img, h)

%If 'img' is a colour image, convert to grayscale
if size(img, 3) > 1
    img = rgb2gray(img);
end

%Define size of image
[row col] = size(img);

%Define window size and padding of 'h'
[windowHeight windowLength] = size(h);
if windowHeight == 1
    PadM = 1;
else
    PadM = floor(windowHeight/2);
end

if windowLength == 1
    PadN = 1;
else
    PadN = floor(windowLength/2);
end

%Define padded image
imgPad = padarray(img,[PadM PadN], 0, 'both');

%Initialize out_img
out_img = zeros(row, col);

for j = PadM+1:col
    for i = PadN+1:row
        out_temp = imgPad(i-PadN:i+PadN, j-PadM:j+PadM).*h;
        out_img(i,j) = sum(out_temp(:));
    end
end

end

