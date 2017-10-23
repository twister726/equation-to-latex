function [] = segment (impath, outpath)

im = im2double(rgb2gray(imread(impath)));
% subplot(2,2,1); imshow(im); title('Original');

imt = threshold(im);
% subplot(2,2,2); imshow(imt); title('Thresholded');

regions = get_regions(imt, 9);

% subplot(3,3,1);
% imshow(im);
for i = 1:size(regions,2)
    % subplot(3,3,i+1);
    fname = strcat(outpath, num2str(i));
    fname = strcat(fname, '.png');
    imwrite(regions{i}, fname);
end

% imb = binary_erosion(imt, 9);
% subplot(2,2,3); imshow(imb); title('After Binary erosion');
%
% imbb = imb;
%
% br = blank_rowcol(imb, true); % rows
% % This isnt how it shall work, it shall recursively split. This is only for
% % testing if blank_rowcol really works
% for i = 1:size(br)
%     imbb(br(i), :) = 0.5;
% end
%
% bc = blank_rowcol(imb, false); % cols
% for i = 1:size(bc)
%     imbb(:, bc(i)) = 0.5;
% end
%
% subplot(2,2,4); imshow(imbb); title('After splits (gray)');
