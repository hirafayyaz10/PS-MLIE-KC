
% Histogrmas
clear all;
I = imread('chest1_out.png');
% I = imread('chemical plant_out.tiff');
%I=imread('out.png');
% 
% I=double(I);
% figure
% histogram(I,256,'EdgeColor','b','FaceColor','g');


figure
histogram(I,256,'EdgeColor','r','FaceColor','r');
set(gca,'FontSize',25);

%title('Red Channel');

% figure
% histogram(I(:,:,2),256','EdgeColor','g','FaceColor','g');
% title('Green Channel');
% 
% figure
% histogram(I(:,:,3),256','EdgeColor','b','FaceColor','b');
% title('Blue Channel');
% 
