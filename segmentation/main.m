im = im2double(rgb2gray(imread('temp.png')));
subplot(3,1,1); imshow(im); title('Original');

imt = threshold(im);
subplot(3,1,2); imshow(imt); title('Thresholded');

imb = binary_erosion(imt, 9);
subplot(3,1,3); imshow(imb); title('After Binary erosion');

