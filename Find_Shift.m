function [ shift ] = Find_Shift( image1,image2,methodNum,dimNum )
%
if methodNum == 1
    method = @Normalized_Cross_Correlation;
else 
    method = @Mutual_information;
end

hlf = floor(size(image1,dimNum)/2);
S = hlf*2;
direction = zeros(1,3 );
direction(dimNum) = 1;

padsize = direction * (hlf+1);
image1 = padarray(image1, padsize);
image2 = padarray(image2, padsize);

curr = 0;
dist = S;
c = method(image1,image2);

while true
    %
    if dist <= 10
        break
    end
    
    if curr-dist < -S % dont take zones out of image.
        l=-inf;
        r = method(circshift(image1,curr+dist,dimNum),image2) ;
    else
        l = method(circshift(image1,curr-dist,dimNum),image2) ;
        if curr+dist > S
            r = -inf;
        else
            r = method(circshift(image1,curr+dist,dimNum),image2) ;  
        end
    end
    
    di = [l,c,r; curr-dist , curr , curr+dist];
    [~,m] = max(di,[],2);
   
    if m ~= 2
        c = di(1,m(1));
        curr = di(2,m(1));

    end
    dist = ceil(dist/2);
end

% %fine tunning
sft = ones(1,21)*-inf;
for i=1:length(sft)
   sft(i) = method(circshift(image1, curr-(i-round(length(sft)/2))),image2);
end

[~,shift] = max(sft);
shift = curr-(shift-round(length(sft)/2));

%plot (sft)

% % brute force all. slow. for understanding porpuses. 
% y=zeros (1,size(image1,dimNum));
% sft=y;
% for i= 1:size(image1,dimNum)
%      sft(i) = method(circshift(image1,i-S-1,dimNum),image2) ; 
%       if mod(i,120)== 0
%          %figure ; imshowpair(circshift(image1,i-S-1,dimNum),image2) 
%          y(i)= sft(i);
%       end
% end
% [~,shift] = max(sft);
% shift = shift-S-1;
% plot (sft);hold on ;plot(y) ;hold off;

end

