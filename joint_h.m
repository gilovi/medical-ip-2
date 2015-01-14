function h=joint_h(img1,img2)
% 
% calcs the joint histogram of img1 & img2.
% 

img1 = img1(:);
img2 = img2(:);
s = numel(img1);
N = max(max(img1), max(img2))+1;

h = zeros(N,N);
    for i = 1:s
        h(img1(i)+1 , img2(i)+1) = h(img1(i)+1 , img2(i)+1) + 1;
    end

end