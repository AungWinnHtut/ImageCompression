clc
clear all
close all
[f p]=uigetfile('*.jpg');
I = imread([p f]);  %-- load the image
I=rgb2gray(I); 
%I = imresize(I,.5);  
[x y II rect]=imcrop(I);
rect=round(rect);
m = zeros(size(I,1),size(I,2)); %-- create initial mask
m(rect(2):rect(2)+rect(4)-1,rect(1):rect(1)+rect(3)-1)=ones;  
figure

subplot(2,3,1),imshow(I); title('Input Image');
subplot(2,3,2),imshow(m); title('Initial mask');
subplot(2,3,3),title('Segmentation');

seg = region_seg(I, m, 100); %-- Run segmentation
subplot(2,3,4),imshow(seg); title('Final Segmentation');

[r c] = size(I);
newimag1 = uint8(zeros(r,c));
newimag2 = uint8(zeros(r,c));
for ii=1:r
    for jj = 1:c
        if seg(ii,jj) == 1
            newimag1(ii,jj) = I(ii,jj);
            newimag2(ii,jj) = 255;
        else
            newimag1(ii,jj) = 0;
            newimag2(ii,jj) = I(ii,jj);
        end
    end
end
subplot(2,3,5),imshow(newimag1),title('Segmented ROI');
subplot(2,3,6),imshow(newimag2),title('Other than ROI');





