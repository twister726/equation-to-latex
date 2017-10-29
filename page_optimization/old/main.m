im = rgb2gray(imread('temp3.png'));

[pointsy, pointsx] = find(im > 200);
imwrite(im > 200, 'as.png')
% points = double(points.Location');

% tic
c = minBoundingBox([pointsy, pointsx]')
% toc

% figure;
% imshow(im);
% hold on,  plot(points(1,:),points(2,:),'.')
% hold on,   plot(c(1,[1:end 1]),c(2,[1:end 1]),'r')
% set(gca,'Ydir','reverse')
% axis equal

angle = atan( ( c(2,2) - c(2, 1) ) / ( c(1,2) - c(1, 1) ) ) * 180 / pi
if angle < -45
    angle = -(angle + 90);
else
    angle = -angle;
end
angle
imR = rotateWhiteBG(im, angle+5);
% figure, imshow(imR);
imwrite(imR, 'tea.png')
