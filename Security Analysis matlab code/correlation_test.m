% horizontal/vertical/diagonal random selection from Plain image
% as Red, Green, Blue Scale matrices
%I = imread('Lena_out.tiff');
clear;
I = imread('chest1_out.png');

%I = imread('lena_out.tiff');

% red = I(:,:,1);
% green = I(:,:,2);
% blue = I(:,:,3);

 [m,n, depth] = size(I);
 %[Org_pic, h] = picr(I);

 
% [p, q, dep] = size(red);

[pa, hh] = picr(I);

N=3000;
ran=randi([1 hh],1,N);
ra=zeros(1,N);
rh=zeros(1,N);
rv=zeros(1,N);
rd=zeros(1,N);
for i=1:N
    ra(i)=pa(ran(i));
    
    if (mod(ran(i),n)==0)   % if pixel is on the right edge of the image
        rh(i)=pa(ran(i)-1);
    else
        rh(i)=pa(ran(i)+1);% otherwise
    end
    
    if (ran(i) > (hh - n))  % if pixel is on the last row of the image
        rv(i)=pa(ran(i)-n);
    else
        rv(i)=pa(ran(i)+n);  % otherwise
    end
        
    if ( mod (ran(i),n) == 0 && ran(i) ~= hh)% if pixel is on right edge and not the last pixel of image   
        rd(i)=pa(ran(i)+(n-1));
    elseif (ran(i) > (hh - n + 1)) % if pixel is in hte last row of the image except first pixel of last row
        rd(i)=pa(ran(i)-(n + 1));
    elseif (ran(i) == (hh - n + 1)) % if pixel is in hte last row and first
        rd(i)=pa(ran(i)-(n-1));
    else
        rd(i)=pa(ran(i)+(n+1)); % otherwise
    end

end

% For Red

%fprintf('Correlation of Plain image for Red Scale only \n');
% figure
% imshow(I);
figure
plot(ra,rh,'r.'); %horizontal
set(gca,'FontSize',17);
Cor4=correlation(ra,rh);
fprintf('Correlation with horizontal elements = %s \n', Cor4);

figure
plot(ra,rv,'r.'); %vertical
set(gca,'FontSize',17);

Cor5=correlation(ra,rv);
fprintf('Correlation with vertical elements   = %s \n', Cor5);

figure
plot(ra,rd,'r.'); %diagonal
set(gca,'FontSize',17);

Cor6=correlation(ra,rd);
fprintf('Correlation with diagonal elements  = %s \n', Cor6);
