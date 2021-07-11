function [out_img] = contrast_highlight(img, a, b, I_min)

img = double(img); %Cast into double datatype 
img(img==0) = nan; %Supress background of image (nan == not a number)

[row, col] = size(img); %Set parameters for loop

for i = 1:row
    for j = 1:col
        if img(i,j) < a
            out_img(i,j) = I_min;
        elseif img(i,j) > a && img(i, j) <= b
            out_img(i,j) = img(i,j);
        elseif img(i,j) > b
            out_img(i,j) = I_min;
        end
    end
end

end

