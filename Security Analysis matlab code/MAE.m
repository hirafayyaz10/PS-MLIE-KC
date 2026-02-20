% MAE

function [y]=MAE(P,C)

[rows,colms]=size(P);

y=0;
for npi=1:1:rows
    for npj=1:1:colms
        S = abs(P(npi,npj)- C(npi,npj));
        y=S+y;       
    end
end

y = y /(rows*colms);
end