% UACI  good

function [y]=UACI(P,C)

[rowss,colmss]=size(P);
P = double(P);
C = double(C);
 y=0;

 for uci=1:1:rowss
     for ucj=1:1:colmss
             S=abs(   P(uci,ucj)-C(uci,ucj)    ) / 255;
             y=S+y;
     end
 end

y=(y*100)/(rowss*colmss);

end