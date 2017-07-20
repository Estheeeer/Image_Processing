% Function RESPONSE_IMG is used to find the response gradient 
% magnitude image on each segment direction. 
% ------------------------------------------------------------------
% Parameter: 
%       Input:
%             img     : input image [1D, 'double' type]
%             map     : edge image
%             kerRef  : kernel reference
%             dirNum  : numbers of direction segments [8]
%       Output:
%             outMap  : ouput image after convolution
% ------------------------------------------------------------------
% Usage:
%       e.g. outMap = response_img(img, edgeImage, kerRef, 8)
% ------------------------------------------------------------------
% Note:
%       line segments can be customizedly defined [2...8],
%       the larger number leads to the better output
% ------------------------------------------------------------------ 
% Author: Xinxin Zhang
% Date: 12/04/2016
% ================================================================== %

function outMap = response_img(img, map, kerRef, dirNum)
    
    % img = imread(X);
  
    % classification
    [H, W, sc] = size(img);
    outMap = zeros(H, W, dirNum);

    for li = 1 : dirNum

        % generate line segments with certain direction from 0 to 180 degree
        % the angle is uniformly divided into dirNum times
        ker = imrotate(kerRef, (li-1)*180/dirNum, 'bilinear', 'crop');

        % convolve the kernel with the each pixel of gradient map
        outMap(:, :, li) = conv2(map, ker, 'same');

    end  
end