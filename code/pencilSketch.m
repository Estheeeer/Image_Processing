% Function PENCILSKETCH is used to simulate the pencil sketch effect on image.
% ------------------------------------------------------------------
% Parameter: 
%       Input:
%             inImg     : input image [any type]
%             ks        : convolutional kernal size [1, 2, 3...]
%             dirNum    : numbers of direction segments [8]
%             w         : width of the strocke
%             betaS     : the darkness of the stroke [1, 2, 3...]
%       Output:
%             outImg    : output image
% ------------------------------------------------------------------
% Usage:
%       e.g.
%       im = imread('nameofimage');
%       I = pencilSketch(im, 1, 8, 2);
% ------------------------------------------------------------------
% Note: 
%       For better performance:
%       ks should be small, so 1, 2, and 3 are smart choices
%       w should be no larger than 3 for better smoothing effect
% ------------------------------------------------------------------
% Author: Xinxin Zhang
% Date: 12/04/2016
% Reference: "Combining Sketch and Tone for Pencil Drawing Production" 
% Cewu Lu, Li Xu, Jiaya Jia (NPAR 2012), June, 2012

% ================================================================== %

function outImg = pencilSketch(inImg, ks, w, dirNum, betaS)

    % close all ,clear all, clc;
    % 
    % X = 'suzzallo.png';
    % inImg = imread(X);
    inImg = im2double(inImg);    % convert image type to 'double'
    [len, wid, sc] = size(inImg);    % get image length, width, and dimension

    % get the luminance information of image
    % convert color image to grayscale if necessary
    
    % Y = Y
    % U = 0.872021 Cb
    % V = 1.229951 Cr
    % Because only care the Y(lumina), so instead to convert RGB to YUV, 
    % I simply convert RGB to YCbCr
    
    if (sc == 3)                 
        imgLumina = rgb2ycbcr(inImg);
        img = imgLumina(:,:,1);
    else
        img = inImg;
    end

    %% generate line-drawing image (stroke map)
    % ks = 1; 
    % W = 3; 
    % betaS = 2.0;
    outImg = lineDrawing(img, ks, w, dirNum).^betaS; % darken the result by gammaS
%     figure, imshow(S);

end