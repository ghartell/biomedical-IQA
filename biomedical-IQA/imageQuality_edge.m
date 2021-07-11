function [quality] = imageQuality_edge (in_img)

in_img = double(in_img);
[M, N] = size(in_img);
figure
imshow(in_img, []);
colorbar;
title('Original Image')

%Initialize average filter
avg_filter = (1/331)*[1 4 7 4 1; 4 20 33 20 4; 7 33 55 33 7; 4 20 33 20 4; 1 4 7 4 1];

%Apply average filter
in_img_avg = spatial_filter(in_img, avg_filter);

%Apply median filter to further reduce noise
in_img_avg = medfilt2(in_img_avg);

%Apply Sobel Kernel in X and Y directions
sobel_x = derivative_kernel(in_img_avg, 'sobel', 'x');
sobel_y = derivative_kernel(in_img_avg, 'sobel', 'y');

%Compute gradient magnitude
sobel_grad = sqrt(sobel_x.^2 + sobel_y.^2);

%Determine optimal threshold via automatic thresholding
T = automatic_thresholding(sobel_grad);
automatic_thresh = image_threshold(sobel_grad, T);
figure
imshow(automatic_thresh, []);
colorbar;
title('Thresholded Edge Map')

%Mask image to get input edge information
for i = 1:M
    for j = 1:N
        if automatic_thresh(i,j) == 1
            masked_img(i,j) = in_img(i,j); %Only change if edge exists
        else
            masked_img(i,j) = 0;
        end
    end
end

%Graphing the masked image
figure
imshow(masked_img,[]);
title('Masked Image')
colorbar;

%Blur calculation
Hv = [1 1 1 1 1 1 1 1 1]/9; %Simple box blur filter
Hh = Hv'; %Transpose for the horizontal direction

inputEdge = masked_img;

B_Ver = imfilter(inputEdge,Hv); % Blur img in the vertical direction
B_Hor = imfilter(inputEdge,Hh); % Blur img in the horizontal direction

D_F_Ver = abs(inputEdge(:,1:N-1) - inputEdge(:,2:N)); % Compute original img variance in vertical direction
D_F_Hor = abs(inputEdge(1:M-1,:) - inputEdge(2:M,:)); % Compute original img variance in vertical direction

D_B_Ver = abs(B_Ver(:,1:N-1)-B_Ver(:,2:N)); % Compute blurred img variance in vertical direction
D_B_Hor = abs(B_Hor(1:M-1,:)-B_Hor(2:M,:)); % Compute blurred img  variance in horizontal direction

T_Ver = D_F_Ver - D_B_Ver; % difference between two vertical variations of 2 image (input and blured)
T_Hor = D_F_Hor - D_B_Hor; % difference between two horizontal variations of 2 image (input and blured)

%Check if there is any variation by comparing against 0
V_Ver = max(0,T_Ver); 
V_Hor = max(0,T_Hor);

%Variance in both directions for original image 
S_D_Ver = sum(sum(D_F_Ver(2:M-1,2:N-1))); 
S_D_Hor = sum(sum(D_F_Hor(2:M-1,2:N-1)));

%Variance in both directions for blurred image only if any changes exist
S_V_Ver = sum(sum(V_Ver(2:M-1,2:N-1)));
S_V_Hor = sum(sum(V_Hor(2:M-1,2:N-1)));

%Normalize the blur values for both directions
blur_F_Ver = (S_D_Ver-S_V_Ver)/S_D_Ver;
blur_F_Hor = (S_D_Hor-S_V_Hor)/S_D_Hor;

%Get quality score. Subtract from 1 because sharp edge = 0, blurry = 1.
%Multiplied blur by 4 because a max blur value > 0.25 essentially means the edges are functionally nonexistant. 
%Multiplied by 100 to get final output values of 0 to 100 for easy comparison.
quality = 100 * abs(1 - 4*max(blur_F_Ver,blur_F_Hor)); 

end