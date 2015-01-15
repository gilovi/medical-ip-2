function [ shift ] = Find_Shift( image1,image2,methodNum,dimNum )
%
DIST = 7;

if methodNum == 1
    method = @Normalized_Cross_Correlation;
else 
    method = @Mutual_information;
end

hlf = floor(size(image1,dimNum)/2);
S = hlf*2-1;
direction = zeros(1,3 );
direction(dimNum) = 1;

padsize = direction * (hlf+1);
image1 = padarray(image1, padsize);
image2 = padarray(image2, padsize);

curr = 0;
dist = S;
c = method(image1,image2);

%% this will do kind of binari search
%binsearch = ones(1,size(image1,dimNum))*-inf; %%%for plotting
while true
    %
    if dist <= DIST
        break
    end
    
    if curr-dist < -S % dont take zones out of image.
        l=-inf;
        r = method(circshift(image1,curr+dist,dimNum),image2) ;
%        binsearch(curr+dist+S+1)=r;%%%%for plotting
        
    else
        l = method(circshift(image1,curr-dist,dimNum),image2) ;
%       binsearch(curr-dist+S+1)=l;%%%%for plotting
        if curr+dist > S
            r = -inf;
        else
            r = method(circshift(image1,curr+dist,dimNum),image2) ;  
%            binsearch(curr+dist+S+1)=r;%%%%for plotting
        end
    end
    
    di = [l,c,r; curr-dist , curr , curr+dist];
    [~,m] = max(di,[],2);
   
    
    if m(1) ~= 2
        c = di(1,m(1));
        curr = di(2,m(1));

    end
    dist = ceil(dist/2);
    
end

%% fine tunning 
sft = ones(1,DIST*2+1)*-inf;
for i=1:length(sft)
   sft(i) = method(circshift(image1, curr+(i-round(length(sft)/2)),dimNum),image2);
end

[~,shift] = max(sft);
shift = curr+(shift-round(length(sft)/2));



% % brute force all. slow. for understanding porpuses. 
% y=zeros (1,size(image1,dimNum));
% SFT=y;
% parfor i= 1:size(image1,dimNum)
%      SFT(i) = method(circshift(image1,i-S-1,dimNum),image2) ; 
% end
% [~,shift] = max(SFT);
% shift = shift-S-1;
% 
% figure;plot (1-S-1:length(SFT)-S-1,SFT);hold on %;plot(y)
% plot (1-S-1:length(SFT)-S-1,binsearch ,'xr');hold on 
% plot(curr+(1-round(length(sft)/2)):curr+(round(length(sft)/2)-1),sft,'g');

end

