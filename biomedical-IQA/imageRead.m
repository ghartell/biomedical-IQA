function [img, info] = imageRead(imageName, fileType)
% imageRead reads in medical images of any file type
% Support .mhd/.raw, .png and .dcm file types

if strcmp (fileType, '.mhd') == 1
    [img, info] = read_mhd(imageName);
elseif strcmp (fileType, '.raw') == 1
    [img, info] = read_mhd(imageName);
elseif strcmp (fileType, '.dcm') == 1
    img = dicomread(imageName);
    info = dicominfo(imageName);
elseif strcmp (fileType, '.png') == 1
    img = imread(imageName);
    info = 0;
else
    fprintf('Invalid file type');
end 

end

