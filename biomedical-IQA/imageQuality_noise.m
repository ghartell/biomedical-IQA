function [quality] = imageQuality_noise(in_img)

[M, N] = size(in_img);

%Initialize average filter
avg_filter = (1/331)*[1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1];

%Initialize laplacian coefficients
H =[1 -2 1; -2 4 -2; 1 -2 1];

%Apply average filter
in_img_avg = spatial_filter(in_img, avg_filter);

%Apply Sobel Kernel in X and Y directions
sobel_x = derivative_kernel(in_img_avg, 'sobel', 'x');
sobel_y = derivative_kernel(in_img_avg, 'sobel', 'y');

%Compute gradient magnitude
sobel_grad = sqrt(sobel_x.^2 + sobel_y.^2);

%Determine optimal threshold
[T] = automatic_thresholding(sobel_grad);
automatic_thresh = image_threshold(sobel_grad, T);

%Apply Laplacian filter
L_transform = abs(conv2(in_img, H));

%Remove edges anywhere the edge map is 
for i = 1:M
    for j = 1:N
        if automatic_thresh(i,j) == 1
            edges_removed(i,j) = 0;
        else
            edges_removed(i,j) = L_transform(i,j);
        end
    end
end

%Sum the Laplacian
sum_edges_removed = sum(sum(edges_removed));

%Calculate noise variance
quality = sum_edges_removed*sqrt(pi/2)*(1/(6*(M-2)*(N-2)));

%Plotting
figure
subplot(321)
imshow(in_img_avg, []);
colorbar;
title('Averaged Input Image')
subplot(322)
imshow(sobel_grad, []);
colorbar;
title('Sobel Gradient Magnitude')
subplot(323)
imshow(automatic_thresh, [])
colorbar
title('Thresholded Edge Map')
subplot(324)
imshow(L_transform, [])
colorbar
title('Laplace Transform')
subplot(325)
imshow(edges_removed, [])
colorbar
title('Edges Removed')

end