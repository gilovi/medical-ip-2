
disp('calculating c1...')
brain1 = load_untouch_nii('brainMRI1.nii');
brain1 = brain1.img;

brain2 = load_untouch_nii('brainMRI2.nii');
brain2 = brain2.img;

brain2seg = load_untouch_nii('brainMRI2_seg.nii');
brain2seg = brain2seg.img;


%shift find:
SHIFT= zeros(1,3);
for i = 1:3
    SHIFT(i) = Find_Shift(brain2,brain1,1,i);
end
p = ['x','y','z']'
[shift,axis] = max(SHIFT);
axis = p(axis)
shift


