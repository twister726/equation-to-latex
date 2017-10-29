labels = dir('data/*')

trainingFeatures = zeros(0, 4356);
trainingLabels = zeros(0);
valFeatures = zeros(0, 4356);
valLabels = zeros(0);

for label = labels'
    dirname = label.name
    images = dir(strcat('data/', strcat(dirname, '/*.png')));
    images = images(randperm(size(images, 1)));
    if size(images, 1) < 10
        continue
    end
    
    if size(images, 1) > 60
        images = images(1:60 , :);
    end

    isVal = false;
    curi = 1;
    for imgstruct = images'
        imgname = imgstruct.name;
        img = imread(strcat( strcat('data/', dirname), strcat('/', imgname) ));
        img = rgb2gray(img);
        img = imbinarize(img);
        img = imresize(img, [48 48]);
        features = extractHOGFeatures(img, 'CellSize', [4 4]);
        if isVal
            valFeatures = [ valFeatures; features ];
            valLabels = [ valLabels; dirname ];
        else
            trainingFeatures = [ trainingFeatures; features ];
            trainingLabels = [ trainingLabels; dirname ] ;            
        end
        
        curi = curi + 1;
        if curi > size(images, 1) * 0.8
            isVal = true;
        end
    end
end

rp = randperm(size(trainingFeatures, 1));
trainingFeatures = trainingFeatures(rp, :);
trainingLabels = trainingLabels(rp, :);

rp = randperm(size(valFeatures, 1));
valFeatures = valFeatures(rp, :);
valLabels = valLabels(rp, :);

classifier = fitcecoc(trainingFeatures, trainingLabels);

predictedLabels = predict(classifier, valFeatures);

acc = sum(predictedLabels == valLabels) / size(valLabels, 1)
