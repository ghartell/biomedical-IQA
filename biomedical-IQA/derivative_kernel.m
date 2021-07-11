%DERIVATIVE_KERNEL Performs spatial filtering with derivative kernels
%   [out_img] = derivative_kernel(img, filter, direction) applies derivative kernel
%   'filter' to img in the desired direction (x or y)
%   
%   'filter' accepts the name of a derivative filter in string format.
%   Choose from:
%       'central' = central difference kernel
%       'forward' = forward difference kernel
%       'prewitt' = prewitt kernel
%       'sobel' = sobel kernel
%   
%   'direction' accepts 'x' or 'y' as an input

function [out_img] = derivative_kernel(img, filter, direction)

switch filter
    case 'central'
        h = [1 0 -1];
    case 'forward' 
        h = [0 1 -1];
    case 'prewitt' 
        h = [1 0 -1; 1 0 -1; 1 0 -1];
    case 'sobel'
        h = [1 0 -1; 2 0 -2; 1 0 -1];
end

if direction == 'y'
    h = h.';
end

out_img = spatial_filter(img, h);

end

