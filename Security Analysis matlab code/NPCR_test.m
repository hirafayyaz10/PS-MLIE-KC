clear all;
IMG1 = imread('chest1_out.png'); % Read image
IMG1=double(IMG1);

IMG2 = imread('chest1_diff_out.png'); % Read image
IMG2=double(IMG2);
npcr = NPCR(IMG1, IMG2);
uaci = UACI(IMG1, IMG2);
