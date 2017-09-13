% Function PENCILTEXTURE is used to generate pencil texture map and apply
% it on the tone map.
% ------------------------------------------------------------------
% Parameter: 
%           Input:    
%                  P: tonnal texture image 
%                  J: tone map of original image
%                  theta: parameter to adjust the pencil texture intensity
%                        (larger theta means larger intensity)
%           Output:   
%                  T: pencil-texture image
% ------------------------------------------------------------------
% Usage:
%       e.g.
%       J = pencilTexture(P, J, 0.2);
% ------------------------------------------------------------------
% Note: 
%      A larger theta will result in a larger intensity.
% ------------------------------------------------------------------
% Author: Xinxin Zhang
% Date: 12/04/2016
% ================================================================== %

function T = pencilTexture(img, P, J, theta)

    % img = imread('flower.png');

    % P = im2double(rgb2gray(imread('tonalTexture.png')));
    % P = imresize(P, [len wid]);
    
    J = toneDrawing(img, 1);
    J = rgb2gray(J);
    [len, wid, ~] = size(img);

    % Initialization
    P = imresize(P, [len, wid]);
    P = reshape(P, len*wid, 1);
    logP = log(P);
    logP = spdiags(logP, 0, len*wid, len*wid);

    J = imresize(J, [len, wid]);
    J = reshape(J, len*wid, 1);
    logJ = log(J);

    e = ones(len*wid, 1);
    Dx = spdiags([-e, e], [0, len], len*wid, len*wid);
    Dy = spdiags([-e, e], [0, 1], len*wid, len*wid);

    % Compute matrix A and b
    A = theta * (Dx * Dx' + Dy * Dy') + (logP)' * logP;
    b = (logP)' * logJ;

    % Conjugate gradient
    beta = pcg(A, b, 1e-6, 60);

    % Compute the result
    beta = reshape(beta, len, wid);

    P = reshape(P, len, wid);

    T = P.^beta;

    % figure;
    % imshow(T);

end