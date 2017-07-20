% Function LINEDRAWING is used to generate line-drawing image.
% ------------------------------------------------------------------
% Parameter: 
%       Input:
%             img    : input image [1D, 'double' type]
%             ks     : convolutional kernal size [1, 2, 3...]
%             w      : width of the stroke
%             dirNum : numbers of direction segments [8]
%       Output:
%             S      : output image
% ------------------------------------------------------------------
% Usage:
%       e.g.
%       S = lineDrawing(img, 1, 8);
% ------------------------------------------------------------------
% Note: 
%       For better performance:
%       ks should be small, 1, 2, and 3 are smart choices
%       w should be no larger than 3 for better smoothing effect
%
% ------------------------------------------------------------------
% Author: Xinxin Zhang
% Date: 12/04/2016
% ================================================================== %
function S = lineDrawing(img, ks, w, dirNum)

    % close all; clear all; clc

    % X = 'suzzallo.png';     % name of the image
    % im = imread(X);        % load image
    % 
    % [ly, lx, sc] = size(im);
    % 
    % if sc == 3
    %     img = rgb2gray(im); % convert rgb to grayscale
    %     img = img(:,:,1);
    % else
    %     img = im;
    % end

    wsize = 3;                              % lowpass filter window size
    img = medianFilter(img, wsize);         % smooth image
    imgEdge = sobel_operator(img);          % find the edge image of original image

    [ly, lx, sc] = size(img);       % get the length, width and color dimension of image
    % dirNum = 8;                   % numbe of direction line segements
    % ks = 1;                       % convolution kernel with horizontal direction  
                                    % (usually 1/30 of the width or length of image)

    % find the optimal direction of sketch at each pixel and form a direction map           
    [Dirs, cindex] = direction_classification(img, ks, 8);

    % create the magnitude map of direction i 
    cMap = zeros(ly, lx, dirNum);
    for li = 1 : dirNum
        cMap(:, :, li) = imgEdge .* (cindex == li);
    end

    kerRef = zeros(ks*2+1);
    kerRef(ks+1, :) = 1;
    
    for i = 1 : w
        if (ks+1-i) > 0
            kerRef(ks+1-i, :) = 1;
        end

        if (ks+1+i) < (ks*2+1)
            kerRef(ks+1+i, :) = 1;
        end
    end

    % generate lines at each pixels
    S_prime_i = zeros(ly, lx, dirNum);

    for li = 1 : dirNum
        ker = imrotate(kerRef, (li-1)*180/dirNum, 'bilinear', 'crop');
        S_prime_i(:, :, li) = conv2(cMap(:, :, li), ker, 'same');
    end

    S_prime = sum(S_prime_i, 3);

    % map to [0, 1]
    S_prime = (S_prime - min(S_prime(:))) / (max(S_prime(:)) - min(S_prime(:)));

    % invert pixle values to get final pencil stroke map S
    S = 1 - S_prime;
    % show line drawing of image
    % imshow(S);
end


