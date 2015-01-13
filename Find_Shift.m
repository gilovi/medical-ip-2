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
padarray(image1, padsize);

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
    %di(1,di(2,:) > S) = -inf; 
    [~,m] = max(di,[],2);
    
    %
    di%
    %
    
    if m ~= 2
        c = di(1,m(1));
        curr = di(2,m(1));
    %else
        %lst = curr - ceil(abs(curr-lst)/2);
        
    end
    dist = ceil(dist/2);
end

% %fine tunning
% sft = ones(1,21)*-inf;
% for i=1:length(sft)
%    sft(i) = method(circshift(image1, curr-(i-round(length(sft)/2))),image2);
% end


parfor i= 1:size(image1,dimNum)
     sft(i) = method(circshift(image1,(direction*i)-hlf),image2) ; 
     if mod(i,50)== 0
        figure ; imshowpair(circshift(image1,(direction*i)-hlf),image2) 
     end
end
[~,shift] = max(sft);
shift = curr-(shift-round(length(sft)/2));
plot (-hlf:hlf,sft)

% im1 = im2double(image1(:));
% im2 = im2double(image2(:));
% 
% avr1 = mean2(im1);
% avr2 = mean2(im2);
% 
% 
% f = im1 - avr1;
% g = im2 - avr2;
% 
% ifft2(fft2(f)*conj(fft2(g)))
% 
% 
% grade = (im1 - avr1)'*(im2 - avr2)  / (((sum((im1(:)-avr1).^2)).^(1/2)) * ((sum((im2(:)-avr2).^2)).^(1/2)) );
end

