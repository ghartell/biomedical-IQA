function [bins, freq] = intensityHistogram(img, numBins, normalize);

% If you need to extract the image from the data struct
if isobject(img) && isprop(img, 'data')
    img = img.data; % set the image parameter to the data struct
end

img = double(img); %Cast into double datatype 
img(img==0) = nan; %Supress background of image (nan == not a number)

% Define dimension properties
img = squeeze(img); % Remove singleton dimensions, (any dimension for which size(A,dim) = 1)
imgDims = ndims(img); % Number of array dimensions, (>2) image/volume

% Define range of intensities
imgMin = min(img(:));
imgMax = max(img(:));
intenseRange = imgMax - imgMin;

% Handle odd bin numbers (modify function - remainder after division (modulo operation))
k = intenseRange/numBins; % k (interval) is defining how many values in each of the 100 bins
if k ~= 0
    k = (intenseRange + mod(mod(intenseRange, numBins), numBins))/numBins;
end

% Define range of frequencies
temp = zeros(size(img)); %initialize
bins = zeros(1, numBins); %initialize
freq = zeros(1, numBins); %initialize

% Define frequency of occurence of each intensity
for i = 1:numBins
    floor = imgMin + k*i; %lower lim of the interval
    ceiling = imgMin + k*(i-1); % upper lim of the interval
    bins(i) = (floor + ceiling)/2; % average
    temp =  img > ceiling & img <= floor; 
    freq(i) = sum(temp(:)); %store the number of times that condition is met
end

if imgDims > 2 %3D volume plot & normalization plot
    
    if normalize ~= 1 %if normalization is not desired
        plot(bins, freq(:))
        xlabel('Intensity (Bins)')
        ylabel('Frequency')
        
    else %if normalization is desired (probability distribution function - PDF)
        numArray = numel(img); %Number of array elements.. represent pixels
        plot((bins./numArray), (freq(:)./numArray)); %Normalize
        xlabel('Intensity (Bins)')
        ylabel('Frequency')
    end
    
else %2D image plot
    bar(bins, freq(:))
    xlabel('Intensity (Bins)')
    ylabel('Frequency')
    
end

