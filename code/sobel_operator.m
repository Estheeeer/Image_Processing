% Function SOBEL_OPERATOR is used to output the edge of given image. 
% ------------------------------------------------------------------
% Parameter: 
%       Input:
%             im    : data of input image
%
%       Output:
%             Y     : edge iamge
% ------------------------------------------------------------------
% Usage:
%       e.g.
%       Y = sobel_operator(imread('imagename'))
% ------------------------------------------------------------------
% Author: Xinxin Zhang
% Date: 12/04/2016


function Y = sobel_operator(im)
    % close all; clear all; clc
    % X = 'flower.png';
    % im = imread(X);
    img = im2double(im);

    % [ly, lx, sc] = size(img);
    % 
    % if sc == 3
    %     img = rgb2gray(img); % convert rgb to grayscale
    % %     img1 = img2(:,:,1);
    % else
    %     img = img;
    % end


    % Horizontal and vertical Sobel operators
    hor_oper = [-1 0 1; -2 0 2; -1 0 1];
    ver_oper = [-1 -2 -1; 0 0 0; 1 2 1];

    Gx=abs(conv2(img, ver_oper, 'same'));
    Gy=abs(conv2(img, hor_oper, 'same'));
    Y = sqrt(Gx.^2 + Gy.^2);
    % Y = img;

    % img_d = img_d > 0.08995; %// Threshold image
    % figure;
    % imshow(Y);

    % [ly, lx, sc] = size(img);
    % for i=1:(ly-2)
    %     for j=1:(lx-2)
    %         %Sobel mask for x-direction:
    %         Gx=(2*img_d(i+2,j+1)+img_d(i+2,j)+img_d(i+2,j+2))-(2*img_d(i,j+1)+img_d(i,j)+img_d(i,j+2));
    %         
    %         %Sobel mask for y-direction:
    %         Gy=(2*img_d(i+1,j+2)+img_d(i,j+2)+img_d(i+2,j+2))-(2*img_d(i+1,j)+img_d(i,j)+img_d(i+2,j));
    %       
    %         %The gradient of the image
    %         %B(i,j)=abs(Gx)+abs(Gy);
    %         img(i,j)=sqrt(Gx.^2+Gy.^2);
    %     end
    % end
    % 
    % figure(2);
    % imshow(img);

end