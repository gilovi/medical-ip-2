function [ rot ] = Find_Rotation(image1,image2,methodNum,dimNum)
%
if dimNum == 1 % arround x 
    per = [1,3,2];
elseif dimNum == 2 % arround y
    per = [3,2,1];
else
    per = [1,2,3];
end

    image1 = permute(image1,per);
    image2 = permute(image2,per);

    
if methodNum == 1
    method = @Normalized_Cross_Correlation;
else 
    method = @Mutual_information;
end


% %throwing edges effects
% radius = min(size(image1,1),size(image1,2))/3;
% image1 = circ(image1,radius).* mat2gray(image1);
% image2 = circ(image2,radius).* mat2gray(image2);

incr = 13; % (the minimum for (360/J)+2J which is the max #iterations for my algo ( 51 in worst case))
ind = 0;

curr = method(image1, image2);
nxt = method(imrotate(image1,ind+incr,'crop'), image2);


if nxt-curr < 0
    incr = incr*-1;   
    nxt = method(imrotate(image1,ind+incr,'crop') ,image2);
end
%% 
search = -inf(1,360);
while nxt-curr > 0
%  
search(ind+1) = nxt;%%%for plotting
    ind = ind+incr;
    imr_n = imrotate(image1,ind+incr,'crop');
    curr = nxt;
    nxt = method(imr_n,image2);
end

cor = ones(2*abs(incr),1)*-inf ;
cor(abs(incr)) = curr;

%fine tunning
for j = 1:2*abs(incr)
    if j == incr
        continue
    end
    imr_n = imrotate(image1,j+(ind-abs(incr)),'crop');
    cor(j) = method(imr_n, image2);
end
%% brute. for plotting only!
COR = zeros(1,360);
for i=1:360
    COR(i)= method(imrotate(image1,i,'crop'), image2);
end
x = 1:360;
plot(x,COR, x+ind-abs(incr),cor, x,search ,'x')


[~,rot] = max(cor);
rot = mod(rot+(ind-abs(incr)),360);

end

