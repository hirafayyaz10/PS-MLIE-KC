clear all;
img = imread('chest1_out.png'); % Read image

% double format
img=double(img);
img1 = img(:,:,1);


diff = zeros(1, 256);
for k  = 1: 256
img = img1(:,k);
    for i = 1: 256
    flag = 0;
    key =  i;
    for j = 1: key-1
        if img(i) == img(j)
            flag = 1;
            break;
        end
    end
    if flag == 0
        diff(k) = diff(k) + 1;
    end
    end
    
end

mymean = mean(diff)

x = [1:256];
plot(x, diff, 'LineWidth', 2);
set(gca,'FontSize',22)
axis([0 255 0 255]);
xlabel('Window') 
ylabel('Frequency') 
