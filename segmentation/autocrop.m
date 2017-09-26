function [ im ] = autocrop( im )
%AUTOCROP Autocrops the image so that the padding goes away

b = sum( im.^2, 3 ); % check how far each pixel from "black"

% use regionprops to get the bounding box
st = regionprops( double( b > .5 ), 'BoundingBox' ); % convert to double to avoid bwlabel of logical input

rect = st.BoundingBox; % get the bounding box

% Crop the image
im = imcrop(im, rect);

end

