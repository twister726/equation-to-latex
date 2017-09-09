function [ imout ] = threshold( im )
%THRESHOLD Summary of this function goes here
%   Detailed explanation goes here

imout = double(im < 0.5);

end

