function [ rot ] = Find_Rotation(image1,image2,methodNum,dimNum)
%

if methodNum == 1
    method = @Normalized_Cross_Correlation;
else 
    method = @Mutual_information;
end


% %throwing edges effects
% radius = min(size(image1,1),size(image1,2))/3;
% image1 = circ(image1,radius).* mat2gray(image1);
% image2 = circ(image2,radius).* mat2gray(image2);

incr = 13; % (the minimum for (360/J)+2J which is the max #iterations for my algo ( 51 in worst case))
ind = 0;

curr = method(image1, image2);
nxt = method(imrotate(image1,ind+incr,'crop'), image2);

%cor(i) = method(image1,imrotate(image2, i,'crop'));
%cor(i+J) = method(image1, imrotate(image2,i+J,'crop'));

%sgn = 1;
%if cor(i+J)-cor(i) < 0
if nxt-curr < 0
    incr = incr*-1;
    %cor(mod(i+J,360)) = method(image1 ,imrotate(image2,i+J,'crop'));
    nxt = method(imrotate(image1,ind+incr,'crop') ,image2);
 %   sgn = -1;
end

%while cor(mod(i+J,360))-cor(i) > 0
while nxt-curr > 0
%     if (i+J>360 || i+J < 1) %means didnt find max & reached the one side. but ussually max surrounded by lower vals 
%         if switch_d % rare condition were the maximum is exactly at 180 or -180
%             brake
%         else
%             switch_d = true
%             i = 180;
%             J = J*-1;
%             cor(i+J) = method(imrotate(image1,i+J),image2);
%             cond = true;
%         end
%     end    
    ind = ind+incr;
    imr_n = imrotate(image1,ind+incr,'crop');
    %cor(mod(i+J,360)) = method(image1 ,imr_n);
    curr = nxt;
    nxt = method(imr_n,image2);
end

cor = ones(2*abs(incr),1)*-inf ;
cor(abs(incr)) = curr;

%fine tunning
%j = i-J:sgn:1+J;
%for j = mod(j(2:end-1),360)
for j = 1:2*abs(incr)
    if j == incr
        continue
    end
    imr_n = imrotate(image1,j+(ind-abs(incr)),'crop');
    cor(j) = method(imr_n, image2);
end

[~,rot] = max(cor);
rot = mod(rot+(ind-abs(incr)),360);
% l = method(imrotate(image1,(rot-0.5),'crop'), image2);
% h = method(imrotate(image1,(rot+0.5),'crop'), image2);



% im1Correlation = Normalized_Cross_Correlation(image1,image1');
% im1norm = double(image1)-im1Correlation*double(image1');
% 
% 
% 
% 
% Xcorrelation = Normalized_Cross_Correlation(im1norm, image2);
% Ycorrelation = Normalized_Cross_Correlation(im1norm', image2);
% 
% rot=atan2d(Ycorrelation, Xcorrelation);


end

