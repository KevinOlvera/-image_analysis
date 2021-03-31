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

% --- seccionamos la imagen en sus componentes de color
img_roja = imagen_1(:,:,1);
img_verde = imagen_1(:,:,2);
img_azul = imagen_1(:,:,3);

% --- realizamos la ampliacion para cada canal
img_roja_ampliada = ampliar_histograma(img_roja, 0, 5);
img_verde_ampliada = ampliar_histograma(img_verde, 16, 175);
img_azul_ampliada = ampliar_histograma(img_azul, 176, 255);

% --- Se muestran en pantalla los histogramas
figure(1)
% --- Histogramas ampliados
subplot(1,3,1)
histogram(img_roja_ampliada)
title('Canal Rojo Ampliado')
subplot(1,3,2)
histogram(img_verde_ampliada)
title('Canal Verde Ampliado')
subplot(1,3,3)
histogram(img_azul_ampliada)
title('Canal Azul Ampliado')


% --- Funciones del programa
function [min, max] = limites_imagen(imagen)
    % --- se obtiene el tamaño de la imagen
    [alto, ancho] = size(imagen);
    % --- se asigna un valor minimo y maximo default
    aux_min = imagen(1,1);
    aux_max = imagen(1,1)+1;
    % --- recorremos la imagen
    for i = 1: +1 : alto
        for j = 1: +1: ancho
            if imagen(i,j) > aux_max
                aux_max = imagen(i,j);
            elseif imagen(i,j) < aux_min
                aux_min = imagen(i,j);
            end
        end
    end
    % --- Necesitamos trabajar con doubles (dafault en MatLab),
    % --- Si no se hace cast da error por estar en diferentes formatos
    min = double(aux_min);
    max = double(aux_max);
end

function resultado = ecuacion_ampliacion(value, min, max, min_ampl, max_ampl)
    % --- se hace cast al resultado para regresar del tipo uint8
    resultado = double((((value - min)/(max - min)) * (max_ampl - min_ampl)) + min_ampl);
    % --- redondeamos al entero mas cercano
    resultado = round(resultado);
end

function imagen_ampliada = ampliar_histograma(imagen, min_ampl, max_ampl)
    % --- inicializamos la imagen
    imagen_ampliada = imagen;
    [alto, ancho] = size(imagen);
    % --- obtenemos el valor maximo y minimo
    [min, max] = limites_imagen(imagen);
    % --- recorremos la imagen
    for i = 1: +1 : alto
        for j = 1: +1: ancho
            value = double(imagen(i,j));
            imagen_ampliada(i,j) = ecuacion_ampliacion(value, min, max, min_ampl, max_ampl);
        end
    end
end