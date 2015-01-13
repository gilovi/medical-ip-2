function grade = Mutual_information(image1,image2)
%

P_AB = joint_h(image1,image2);
s = numel(P_AB);
P_AB = P_AB./s; 
PA = sum(P_AB , 1);
PB = sum(P_AB , 2);

%0log0 = 0 by def (log(1)=0)
%P_AB(P_AB == 0) = 1;
%PA(PA == 0) = 1;
%PB(PB == 0) = 1;

% HA = sum(PA.*(log2(PA)));
% HB = sum(PB.*(log2(PB)));
H_AB = P_AB.*(log2(P_AB));
H_AB(isnan(H_AB)) = 0;
H_AB = sum(H_AB(:)); % joint entropy

%grade =  (HA + HB) - H_AB; % Mutual information

gr = P_AB .* log2(P_AB./(PB*PA));
gr(isnan(gr)) = 0;
grade = -sum(gr(:))/H_AB;

end

