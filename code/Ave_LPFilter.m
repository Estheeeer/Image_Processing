% Function AVE_LPFILTER smooths and denoises the image
% ------------------------------------------------------------------
% Parameter: 
%        input: 
%              I: input image 
%              W: size of the LPF, usually a square
%        output:
%              Y: output image
% ------------------------------------------------------------------
% Usage:
%       e.g.
%       Y = Ave_LPFilter(img, 10)
% ------------------------------------------------------------------
% Note: 
%
% ------------------------------------------------------------------
% Author: Xinxin Zhang
% Date: 10/24/2016
% ================================================================== %

function [Y] = Ave_LPFilter(I, W)

    % generate a LPF
    LPF = (1 / W^2) * ones(W);

    I1 = conv2(double(I(:, :, 1)), LPF, 'same');

    Y(:, :, 1) = I1;
    Y(:, :, 2) = I1;
    Y(:, :, 3) = I1;

end


