im = im2double(rgb2gray(imread('temp.png')));
subplot(2,2,1); imshow(im); title('Original');

imt = threshold(im);
subplot(2,2,2); imshow(imt); title('Thresholded');

imb = binary_erosion(imt, 9);
subplot(2,2,3); imshow(imb); title('After Binary erosion');

imbb = imb;
br = blank_rowcol(imb, true); % rows
% This isnt how it shall work, it shall recursively split. This is only for
% testing if blank_rowcol really works
for i = 1:size(br)
    imbb(br(i), :) = 0.5;
end

br = blank_rowcol(imb, false); % cols
for i = 1:size(br)
    imbb(:, br(i)) = 0.5;
end

subplot(2,2,4); imshow(imbb); title('After splits (gray)');