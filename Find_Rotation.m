function [ rot ] = Find_Rotation(image1,image2,methodNum,dimNum  )
%
im1Correlation = Normalized_Cross_Correlation(image1,image1');
im1norm = double(image1)-im1Correlation*double(image1');

Xcorrelation = Normalized_Cross_Correlation(im1norm, image2);
Ycorrelation = Normalized_Cross_Correlation(im1norm', image2);

rot=atan2d(Ycorrelation, Xcorrelation);


end

