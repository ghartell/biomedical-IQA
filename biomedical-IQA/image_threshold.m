function output = image_threshold(img, T)

[row col] = size(img);
output = zeros(row,col);

for i = 1:row
    for j = 1:col      
        if img(i,j) == T || img(i,j) > T
            output(i,j) = 1;
        elseif img(i,j) < T
            output(i,j) = 0;
        end
    end
end 

end

