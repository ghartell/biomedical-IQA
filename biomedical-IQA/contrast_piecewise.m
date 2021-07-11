function [out_img] = contrast_piecewise(img, a, b)

img = double(img);%Cast into double datatype 
[row, col] = size(img);%Define size of image
out_img = zeros(row, col);%Initialize output

%Calculate slope of each region
s1 = a(2)/a(1);
s2 = (b(2)-a(2))/(b(1)-a(1)); 
s3 = (255-b(2))/(255-b(1));

%Compute output image
for i = 1:row
    for j = 1:col
        if img(i,j) < a(1)
            out_img(i,j) = img(i,j).*s1;
        elseif img(i,j) > a(1) && img(i,j) <= b(1)
            out_img(i,j) = (img(i,j)-a(1)).*s2 + a(2);
        elseif img(i,j) > b(1) && img(i,j) <= 255
            out_img(i,j) = (img(i,j)-b(1)).*s3 + b(2);
        end
    end
end

end

