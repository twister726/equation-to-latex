function [ imout ] = binary_dilation( im, W )
%   W = size of filter (must be odd)

Wm = floor(W / 2);
filter = ones(W, W);
impadded = padarray(im, [Wm Wm]);
imout = im;
for i = 1:size(im, 1)
    for j = 1:size(im, 2)
        temp = impadded(i:i+2*Wm, j:j+2*Wm) .* filter;
        imout(i, j) = sum(temp(:));
    end
end

end
