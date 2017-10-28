im = rgb2gray(imread('temp3.png'));

points = detectBRISKFeatures(im);
points = double(points.Location');

% tic
c = minBoundingBox(points);
% toc

figure;
imshow(im);
hold on,  plot(points(1,:),points(2,:),'.')
hold on,   plot(c(1,[1:end 1]),c(2,[1:end 1]),'r')
set(gca,'Ydir','reverse')
axis equal

angle = atan( ( c(2,2) - c(2, 1) ) / ( c(1,2) - c(1, 1) ) ) * 180 / pi;
if angle < -45
    angle = angle + 90;
end
imR = rotateWhiteBG(im, angle+5);
figure, imshow(imR);