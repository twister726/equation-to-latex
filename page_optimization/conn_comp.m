% function out = conn_comp(im)
filename = 'temp3_rotated.png';
im = rgb2gray(imread(filename));
im = imcomplement(im);

cc = bwconncomp(im,4);

num_comp = size(cc.PixelIdxList,2);

for i = 1:num_comp
    comp = cc.PixelIdxList{i};
    [xs,ys] = ind2sub(size(im), comp);
    
    minx = min(xs);
    miny = min(ys);
    maxx = max(xs);
    maxy = max(ys);
    
    temp = im(minx:maxx, miny:maxy);
    imwrite(temp, strcat(num2str(i), '.png'));
end

% end