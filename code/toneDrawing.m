% Function TONEDRAWING is used to generate line-drawing image.
% ------------------------------------------------------------------
% Parameter:
%       Input:
%             img    : input image [1D, 'double' type]
%             weightRat : weight ratio of three tone layers [1, 2, 3]
%       Output:
%             J      : output image
% ------------------------------------------------------------------
% Usage:
%       e.g.
%       J = toneDrawing(img, 1);
% ------------------------------------------------------------------
% Note: 
%
% ------------------------------------------------------------------
% Author: Xinxin Zhang
% Date: 12/04/2016
% ================================================================== %
function J = toneDrawing(img, weightRat)

    % close all; clear all; clc
    % X = 'flower.png';
    img = im2double(img); 

    % parameter
    ua = 105; ub = 225; mud = 90; sigmab = 9; sigmad=11;

    % choose the weights
    if weightRat==1
        omega1 = 11; omega2 = 37; omega3 = 52; % ratio 11:37:52
    elseif weightRat==2
        omega1 = 42; omega2 = 29; omega3 = 29; % ratio 42:29:29
    else 
        omega1 = 2; omega2 = 22; omega3 = 76;  % ratio 2:76:22
    end

    % generate tone map 
    p = zeros(1,256);
    tot = 0;
    for v = 0:255    
        % p1 bright layer
        p1 = (1/sigmab)*exp(-(255-v)/sigmab);

        % p2 mid tone layer
        if v>=ua && v<=ub
            p2 = 1/(ub-ua);
        else
            p2 = 0;
        end  

        % p3 dark tone layer
        p3 = (1/sqrt(2*pi*sigmad)) * exp(-(v-mud)^2/(2*sigmad^2))*0.01;

        % p sum up three layers
        p(v+1) = omega1*p1 + omega2*p2 + omega3*p3;
        tot = tot+p(v+1);   
    end
    
    % normalization
    p = p/tot; 

    J = histeq(img, p);       % let the image histogram maches the intended histogram
    J = Ave_LPFilter(J, 10);  % smooth the image
    % imshow(J);

end
