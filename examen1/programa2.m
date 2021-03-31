clc % Clean the screen
clear % Clean all
close all % Close all
warning off all % Avoid warnings

color = imread('peppers.png');

gris = rgb2gray(color);
grisrgb = cat(3, gris, gris, gris);

binaria = im2bw(color);
binariargb = cat(3, uint8(binaria)*255, uint8(binaria)*255, uint8(binaria)*255);

yellow = color;
yellow(:,:,3) = 0;

magenta = color;
magenta(:,:,2) = 0;

resultado = [binariargb magenta;
             yellow grisrgb];

         
figure(1)
imshow(resultado)

disp('End process')