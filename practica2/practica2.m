% --- Image Analysis 3CV14
% --- Olvera Olvera Kevin Jesus

% --- TODO: Aqui va la descripcion de la practica!!!

% --- Inicio
% --- limpiar espacio de trabajo
clc
clear all
close all

% --- variables - imagen original
imagen_1 = imread ('peppers.png');
figure(1)
imshow(imagen_1)
title('Imagen Original')

% --- seccionamos la imagen en sus componentes de color
img_roja = imagen(:,:,1);
img_verde = imagen(:,:,2);
img_azul = imagen(:,:,3);

% --- obtenemos el tamaño de la imagen
[alto, ancho, color] = size(imagen);


% --- menu para ingresar los datos
validar = true;
while validar
    valor_maximo = double(input('¿Cuál es el valor máximo?'));
    valor_minimo = double(input('¿Cuál es el valor mínimo?'));
    
    
    
    
    % --- TODO: Aqui va el algoritmo de la practica
    % --- ...
    
    
    
    
    % --- Calcular de nuevo
    respuesta = input('¿Deseas calcular con otros valores? S/N','s');
    if isempty(respuesta)
        respuesta = 'N';
    end
    % --- Fin de programa
    if respuesta == 'N' || respuesta == 'n'
        validar = false;
    end
end