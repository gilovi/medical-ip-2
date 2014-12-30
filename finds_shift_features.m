
% the code here is based on the example in:
% http://www.mathworks.com/help/vision/examples/find-image-rotation-and-scale-using-automated-feature-matching.html 
im1 = (imread('brain1.tif'));
im2 = (imread('brain2.tif'));

im2_seg = imread('brain2_seg.tif');

load points.mat

[tform, inlier1, inlier2] = estimateGeometricTransform(RC2, RC1, 'similarity');

% Tinv  = tform.invert.T;
% 
% ss = Tinv(2,1);
% sc = Tinv(1,1);
% tx = Tinv (3,1);
% ty = Tinv(3,2);
% scaleRecovered = sqrt(ss*ss + sc*sc);
% thetaRecovered = atan2(ss,sc)*180/pi;

outputView = imref2d(size(im1));
recovered  = imwarp(im2,tform,'OutputView',outputView);
%figure, imshowpair(im1,recovered,'montage')

seg2 = imwarp(im2_seg,tform,'OutputView',outputView);
im_overl = im1;
im_overl(cat(3, seg2>0,seg2>0,seg2>0)) = 1;
figure, imshow(im_overl);