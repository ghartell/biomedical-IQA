function out_img = non_max_supress(img, H, W);

% where ?img? is an image of typedouble(which for edge detection will be a 
% gradient magnitude).  The?H? and ?W? arguments provide the size (height and width) 
% of the NMS filtering window

%loading image again (just for the plot)
img2 = double(img);
if size(img2, 3) > 1
    img2 = rgb2gray(img2);
end

%Define window size and padding of 'h'
if H == 1
    PadM = 1;
else
    PadM = floor(H/2);
end

if W == 1
    PadN = 1;
else
    PadN = floor(W/2);
end

%Define padded image
imgPad = padarray(img,[PadM PadN], 0, 'both');
[row col] = size(imgPad);

for i = PadM + 1 : row - PadM
    for j = PadN + 1 : col - PadN
        maxInWindow = max(max(imgPad(i-PadM:i+PadM, j-PadN:j+PadN)));
        if imgPad(i,j) ~= maxInWindow
            imgPad(i, j) = 0;
        else
            imgPad(i, j) = maxInWindow;
        end
    end
end

out_img = imgPad;

end