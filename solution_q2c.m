brain1 = load_untouch_nii('brainMRI1.nii');
brain1 = brain1.img;

brain2 = load_untouch_nii('brainMRI2.nii');
brain2 = brain2.img;

brain2seg = load_untouch_nii('brainMRI2_seg.nii');
brain2seg = brain2seg.img;


%shift find:
SHIFT= zeros(1,3);
for i = 1:3
    SHIFT(i) = Find_Shift(brain2,brain1,2,i);
end
p = ['x','y','z']';
[~,axis] = max(abs(SHIFT));
shift = SHIFT(axis);
vi(0.5*(mat2gray(circshift(brain2seg,shift,axis)))+mat2gray(brain1))
axis = p(axis)
shift
clear brain2 brain2seg SHIFT shift axis p i


