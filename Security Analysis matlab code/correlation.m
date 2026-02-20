% Correlation

function [y]=correlation(P,C)

%its Karl Pearson Correlation Coefficient formula
y=(length(P)*sum(P.*C)-sum(P)*sum(C))/(sqrt(length(P)*sum(P.^2)-(sum(P)^2))*sqrt(length(C)*sum(C.^2)-(sum(C)^2)));

end