function [T] = automatic_thresholding(in_img)

[row col] = size(in_img);

%Compute local stdv of entire image
J = stdfilt(in_img);

%Compute mean local stdv of entire image
y = zeros(1,'like',J);
for i = 2:row-1
    for j = 2:col-1
        y = y + J(i,j);
    end
end
mean_stdv_global = y/numel(J);

%Let edges be 16x greater than the mean_stdv_global
edge_level = mean_stdv_global;

%For values of J > mean_stdv_global, log the intensity value
k=1;
for i = 2:row-1
    for j = 2:col-1
        if J(i,j) > edge_level 
            mean_int_count(k) = in_img(i,j);
            k = k+1;
        end
    end
end
T = mean(mean_int_count);

end