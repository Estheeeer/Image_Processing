% Function MEDIANFILTER smooths and denoises the image
% ------------------------------------------------------------------
% Parameter: 
%        input:
%               I: input image
%               W: size of the sliding window(filter size)
%                  usually a square
%        output:
%               Y: output image after smoothing
% ------------------------------------------------------------------ 
% Usage: 
%       img = imread('imagename');
%       Y = medianFilter (img, 3); 
% ------------------------------------------------------------------
% Note: 
%
% ------------------------------------------------------------------
% Author: Xinxin Zhang
% Date: 10/23/2016
%
% ================================================================== %

function [Y] = medianFilter(I, W)

    % get a dimension of pixel values
    I1 = I(:, :, 1);

    % repeat four boundaries
    topRow = I1(1:((W-1)/2), :);
    bottomRow = I1(end-(((W-1)/2))+1:end, :);

    I_noise = [topRow; I1];
    I_noise = [I_noise; bottomRow];

    topColumn = I_noise(:,1:((W-1)/2));
    bottomColumn = I_noise(:, end-(((W-1)/2))+1:end);

    I_noise = [topColumn, I_noise];
    I_noise = [I_noise, bottomColumn];

    I_Denoise = zeros(size(I_noise));

    % replace the value in each pixel with the median value within 
    % in sliding window
    for i = 1:size(I1, 1)
        for j = 1:size(I1, 2)
            I_Denoise(i+1, j+1) = median(median(I_noise(i:(i+(W-1)), j:(j+(W-1)))));
        end
    end

    % denoise the image
    I_Denoise = I_Denoise(2:(end-1), 2:(end-1));
    Y(:, :, 1) = I_Denoise;
    % Y(:, :, 2) = I_Denoise;
    % Y(:, :, 3) = I_Denoise;
    % Y = uint8(Y);

end


