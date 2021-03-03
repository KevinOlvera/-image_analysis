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
img_roja = imagen_1(:,:,1);
img_verde = imagen_1(:,:,2);
img_azul = imagen_1(:,:,3);

% --- obtenemos el tamaño de la imagen
[alto, ancho, color] = size(imagen_1);


% --- menu para ingresar los datos
validar = true;
while validar
    valor_maximo = double(input('¿Cuál es el valor máximo?'));
    valor_minimo = double(input('¿Cuál es el valor mínimo?'));
    
    
    
    
    % --- TODO: Aqui va el algoritmo de la practica
    % --- ...
    
    
    % --- Se muestran en pantalla los histogramas
    figure(2)
    % --- Histogramas originales
    subplot(2,3,1)
    histogram(img_roja)
    title('Canal Rojo')
    subplot(2,3,2)
    histogram(img_verde)
    title('Canal Verde')
    subplot(2,3,3)
    histogram(img_azul)
    title('Canal Azul')
    % --- Histogramas ampliados
    % --- TODO: cambiar la entrada de estos histogramas por los calculados
    subplot(2,3,4)
    histogram(img_roja)
    title('Canal Rojo Ampliado')
    subplot(2,3,5)
    histogram(img_verde)
    title('Canal Verde Ampliado')
    subplot(2,3,6)
    histogram(img_azul)
    title('Canal Azul Ampliado')
    
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