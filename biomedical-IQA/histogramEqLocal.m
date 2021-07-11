function out_img = histogramEqLocal(img, windowLength, windowHeight)

imgIn = double(img); %Cast into double datatype
out_img = zeros(size(imgIn,1),size(imgIn,2)); %Initialize the output image

% Get middle value to get padding later
middleValue=round((windowLength*windowHeight)/2); %First middle value at top-left of array. We then increment
                                              %away from it instead of constantly re-calculating the value

%Find number of rows to pad with 0's considering the size of the window
in=0;
for i=1:windowLength
    for j=1:windowHeight
        in=in+1;
        if(in==middleValue)
            PadM=i-1;
            PadN=j-1;
            break;
        end
    end
end
%PADDING THE IMAGE WITH ZERO ON ALL SIDES
imgPad=padarray(imgIn,[PadM,PadN],0);


for i= 1:size(imgPad,1)-((PadM*2)+1)
    for j=1:size(imgPad,2)-((PadN*2)+1)
        cdf=zeros(1,256);
        inc=1;
        for x=1:windowLength
            for y=1:windowHeight
  %FIND THE MIDDLE ELEMENT IN THE WINDOW          
                if(inc==middleValue)
                    middlePixel=imgPad(i+x-1,j+y-1)+1;
                end
                    pos=imgPad(i+x-1,j+y-1)+1;
                    cdf(pos)=cdf(pos)+1;
                    inc=inc+1;
            end
        end
                      
        %COMPUTE THE CDF FOR THE VALUES IN THE WINDOW
        for k=2:256
            cdf(k)=cdf(k)+cdf(k-1);
        end
        out_img(i,j)=round(cdf(middlePixel)/(windowLength*windowHeight)*255);
     end
end
end

