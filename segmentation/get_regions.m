function [ regions ] = get_regions( im, fsize )
%GET_REGIONS Takes thresholded image and return regions of the image in a 
% n x 4 matrix, each row
%containing x1 x2 y1 y2. Regions have a single character in them to be
%recognized.
% Args - image, binary erosion filter size

MIN_EROSION_SIZE = 3;

imb = binary_erosion(im, fsize);
im_seg = imb;

br = blank_rowcol(imb, true); % rows
bc = blank_rowcol(imb, false); % cols

temp_regions = [];
regions = {};

for row_idx = 1:size(br,1)
    temp_row = br(row_idx);
    next_row = 0;
    if row_idx == size(br,1)
        next_row = size(imb,1);
    else
        next_row = br(row_idx + 1);
    end
    
    for col_idx = 1:size(bc,1)
        temp_col = bc(col_idx);
        next_col = 0;
        if col_idx == size(bc,1)
            next_col = size(imb,2);
        else
            next_col = bc(col_idx + 1);
        end
        if max(max(imb(temp_row:next_row, temp_col:next_col))) >= 1
            temp_regions = [temp_regions; temp_row next_row temp_col next_col];
            % imwrite( im(temp_row:next_row, temp_col:next_col), strcat(num2str(row_idx), '.png'))
        end
    end
end

for i = 1:size(temp_regions,1)
    r = temp_regions(i,:);
    if fsize == MIN_EROSION_SIZE
        regions{end+1} = im(r(1):r(2), r(3):r(4));
    else
        new_regions = get_regions(im(r(1):r(2), r(3):r(4)), fsize - 2);
        regions = [regions new_regions];
    end
end

end