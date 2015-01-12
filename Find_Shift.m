function [ shift ] = Find_Shift( image1,image2,methodNum,dimNum )
%
% padsize = zeros(1,3 );
% padsize(dimNum) = ceil(size(image1,dimNum)/2);
% padarray(image1,padsize )
% 
% parfor i=1:
im1 = im2double(image1(:));
im2 = im2double(image2(:));

avr1 = mean2(im1);
avr2 = mean2(im2);


f = im1 - avr1;
g = im2 - avr2;

ifft2(fft2(f)*conj(fft2(g)))


grade = (im1 - avr1)'*(im2 - avr2)  / (((sum((im1(:)-avr1).^2)).^(1/2)) * ((sum((im2(:)-avr2).^2)).^(1/2)) );
end

