function [ mask ] = circ( img, radius )
%creates a round/sphere mask in an image
rs = size(img,1);
cs = size(img,2);
vs = size(img,3);

rm = round(rs/2);
cm = round(cs/2);
vm = round(vs/2);

[rr, cc, vv] = meshgrid(1:rs, 1:cs, 1:vs);
mask = sqrt((rr-rm).^2 + (cc-cm).^2 + (vv-vm).^2 ) <= radius;


end

