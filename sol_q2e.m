brain3 = load_untouch_nii('brainMRI3.nii');
brain3 = brain3.img;

brain3seg = load_untouch_nii('brainMRI3_seg.nii');
brain3seg = brain3seg.img;


ROT= zeros(1,3);
for i = 1:3
    ROT(i) = Find_Rotation(brain3,brain1,1,i);
end



[~,axis] = max(abs(ROT));
rot = ROT(axis);

if axis == 1 % arround x 
    per = [1,3,2];
elseif axis == 2 % arround y
    per = [3,2,1];
else %arround z
    per = [1,2,3];
end

vi(0.5*(mat2gray(permute(imrotate(permute(brain3seg,per),rot,'crop'),per))) )%+ mat2gray(brain1))
p = ['x','y','z']';
axis = p(axis)
rot
clear brain3 brain3seg ROT rot axis p i per
