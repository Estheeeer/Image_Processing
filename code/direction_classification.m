% Function DIRECTION_CLASSIFICATION is used to compute the index
% and angle representation of the line segment.
% ------------------------------------------------------------------
% Parameter: 
%       Input:
%             img     : input image [1D, 'double' type]
%             ks      : convolutional kernal size [1, 2, 3...]
%             dirNum  : numbers of direction segments [8]
%       Output:
%             Dirs    : direction angle of pixels
%             cindex  : index of segment direction
% ------------------------------------------------------------------
% Usage:
%       e.g.
%       [Dirs, cindex] = direction_classification(img, 1, 8)
% ------------------------------------------------------------------
% Note:
%       e.g. Define 8 line segement direction: 
%       cindex[1 2 3 4 5 6 7 8] --> Dirs[0 22.5 45 67.5 90 112.5 135 157.5]
%       Thus, Dirs[22.5 22.5 22.5] --> cindex[2 2 2]
% ------------------------------------------------------------------ 
% Author: Xinxin Zhang
% Date: 12/04/2016
% ================================================================== %

function [Dirs, cindex] = direction_classification(img, ks, dirNum)

    %   X = 'Leon.jpg';
    %   img = imread(X);

    imgEdge = sobel_operator(img);     
    kerRef = zeros(ks*2+1);
    kerRef(ks+1, :) = 1;

    % convolute direction line-segement with the input edge image
    response = response_img(img, imgEdge, kerRef, dirNum);

    % compute the direction angle
    [~, index] = sort(response, 3);
    Dirs = (index(:, :, end)-1) * 180 / dirNum; 

    % returns the largest response along 3 dimensions 
    [~, cindex] = max(response, [], 3); 
 
end


