clear all;
img1 = imread('chest1.png'); % Read image
img2 = imread('chest1_out.png'); % Read image
img1 = double(img1);
img2 = double(img2);

mae = MAE(double(img1), double(img2));

 