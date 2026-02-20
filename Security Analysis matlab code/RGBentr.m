function [y]=RGBentr(img)

[n, m, depth] = size(img);
c=0;
count = zeros(m, 1);
%count is an array having the number of intensities of each pixel
for i = 1:n
   for j = 1:m
       count(img(i,j)+1)=count(img(i,j)+1)+1;
   end
end

sum = 0;
%sum = double(sum);
for b=1: 256
    if(count(b) ~=0)
        p = count(b) / (n*m);
        %p = double(p);
        sum = sum + p * log2(1/p);
    end
end
y = sum;
end

