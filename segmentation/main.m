im = im2double(rgb2gray(imread('temp.png')));
subplot(2,1,1); imshow(im); title('Original');

imt = threshold(im);
subplot(2,1,2); imshow(imt); title('Thresholded');

