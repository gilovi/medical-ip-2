im1 = rgb2gray(imread('brain1.tif'));
im2 = rgb2gray(imread('brain2.tif'));
figure; imshow(im1);
figure; imshow(im2);
brains = {im1,im2};


figure;
r1 = zeros(1,10);
c1 = r;
r2 = r1;
c2 = c1;

R = {r1,r2};
C  = {c1,c2};

for i=1:10
    j = i*2-1;
place = mod(i,2)+1;
imshow(brains{place})
[tr ,tc] = getpts;
R{place}(j:j+1) = tr;
C{place}(j:j+1) = tc;

end