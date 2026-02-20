clear all;
img1 = imread('chest1_out.png');
img1 = double(img1);
entropykkh = RGBentr(img1);