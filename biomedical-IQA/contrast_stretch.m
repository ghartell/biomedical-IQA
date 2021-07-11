function [out_img] = contrast_stretch(img, scaleFactor)

img = double(img); %Cast into double datatype 
img(img==0) = nan; %Suppress background of image (nan == not a number)

temp = min(img); %Min row
rmin = min(temp); %Smallest from row

temp = max(img); %Max row
rmax = max(temp); %Largest from row

out_img = scaleFactor*(((1./(rmax-rmin))*img - (rmin./(rmax - rmin))));

end

