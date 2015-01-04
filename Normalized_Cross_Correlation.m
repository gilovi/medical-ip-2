function [ grade ] = Normalized_Cross_Correlation( image1, image2 )
% ncc implemenation.
% 
im1 = im2double(image1(:));
im2 = im2double(image2(:));

avr1 = mean2(im1);
avr2 = mean2(im2);

grade = (im1 - avr1)'*(im2 - avr2)  / (((sum((im1(:)-avr1).^2)).^(1/2)) * ((sum((im2(:)-avr2).^2)).^(1/2)) );


end