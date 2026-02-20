% NPCR   good

function [y]=NPCR(P,C)

[rows,colms]=size(P);

y=0;
for npi=1:1:rows
    for npj=1:1:colms
        S=1-(P(npi,npj)==C(npi,npj));
        y=S+y;       
    end
end

y=(y*100)/(rows*colms);
end