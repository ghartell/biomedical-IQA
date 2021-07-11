function out_img = histogramEqualization(img, numBins)

img = double(img); %Cast into double datatype
out_img = zeros(size(img,1),size(img,2)); %Initialize the output image
img = squeeze(img); % Remove singleton dimensions, (any dimension for which size(A,dim) = 1)

% Define range of intensities
imgMin = min(img(:));
imgMax = max(img(:));
intenseRange = imgMax - imgMin;

% Handle odd bin numbers (modify function - remainder after division (modulo operation))
k = intenseRange/numBins; % k (interval) is defining how many values in each of the 100 bins
if k ~= 0
    k = (intenseRange + mod(mod(intenseRange, numBins), numBins))/numBins;
end

% Initialize arrays
temp = zeros(size(img)); %initialize
bins = zeros(1, numBins); %initialize
freq = zeros(1, numBins); %initialize
pdf = zeros(1, numBins); %initialize

%Define frequency of occurence of each intensity
for i = 1:numBins
    floor = imgMin + k*i; %lower lim of the interval
    ceiling = imgMin + k*(i-1); % upper lim of the interval
    bins(i) = (floor + ceiling)/2; % average
    temp =  img > ceiling & img <= floor;
    freq(i) = sum(temp(:)); %store the number of times that condition is met
end

pdf = freq./sum(freq); %Get PDF
cdf = zeros(1, numBins); %Initialize
temp = 0;

%Populate CDF
for i = 1:numBins
    cdf(i)= pdf(i) + temp;
    temp = cdf(i);
end

%Transform output image
for i = 1:size(img,1)
    for j = 1:size(img,2)
        temp = img(i, j);
        [val,idx]=min(abs(bins-temp)); %Find closest bin the int value corresponds to
        out_img(i, j) = cdf(idx)*255; %Mutiply CDF index by L -1
    end
end

end

