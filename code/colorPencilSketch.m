% Function COLORPENCILSKETCH is used to simulate the colored pencil sketch effect on image.
% ------------------------------------------------------------------
% Parameter: 
%       Input:
%             inImg     : input image [any type]
%             ks        : convolutional kernal size [1, 2, 3...]
%             theta     : parameter to adjust the pencil texture intensity 
%                         (larger theta means larger intensity) [0.1~]
%             weightRat : weight ratio of three tone layers [1, 2, 3] 
%             w         : width of the strocke
%             dirNum    : numbers of direction segments [8]
%             betaS     : the darkness of the stroke [1, 2, 3...]
%             betaI     : the darkness of the resulted image [1, 2, 3...]
%       Output:
%             outImg    : output image
% ------------------------------------------------------------------
% Usage:
%       e.g.
%       im = imread('nameofimage');
%       I = colorPencilSketch(im, 1, 0.2, 8, 3, 2, 2)
% ------------------------------------------------------------------
% Note: For better performance:
%       ks should be small, 1, 2, and 3 are smart choice
%       w should be no larger than 3 for better smoothing effect
% ------------------------------------------------------------------
% Author: Xinxin Zhang
% Date: 12/04/2016
% ================================================================== %

function outImg = colorPencilSketch(inImg, ks, theta, w, dirNum, weightRat, betaS, betaI)

    % close all ,clear all, clc;
    % 
    % X = 'suzzallo.png';
    % inImg = imread(X);
    inImg = im2double(inImg);       % convert image type to 'double'
    [len, wid, sc] = size(inImg);   % get image length, width, and dimension

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
    S = lineDrawing(img, ks, w, dirNum) .^betaS; % darken the result by gammaS
    % figure, imshow(S);

    %% generate tone map
    % weightRat = 3; 
    % betaI = 2.0;
    J = toneDrawing(img, weightRat).^betaI ; % darken the result by gammaI
    % figure, imshow(J);

    %% generte pencil texture image
    % theta = 0.2;
    P = im2double(rgb2gray(imread('tonalTexture.png'))); % load pencil texture image
    T = pencilTexture(img, P, J, theta).^ betaI;
    % figure, imshow(T);

    %% compute output image
    img = S .* T;

    if (sc == 3)
        imgLumina(:,:,1) = img;
        I = ycbcr2rgb(imgLumina);
    else
        I = img;
    end
    
    outImg = I;
%      figure, imshow(outImg);
    imshow(outImg);

end