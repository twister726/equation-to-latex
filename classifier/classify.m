function [ class ] = classify(impath)
img = imread(impath);
img = rgb2gray(img);
img = imbinarize(img);
img = imresize(img, [48 48]);
features = extractHOGFeatures(img, 'CellSize', [4 4]);
class = predict(classifier, features);

