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



% --- menu para ingresar los datos
validar = true;
while validar
    
    % --- seccionamos la imagen en sus componentes de color
    img_roja = imagen_1(:,:,1);
    img_verde = imagen_1(:,:,2);
    img_azul = imagen_1(:,:,3);
    
    valor_minimo = double(input('¿Cuál es el valor mínimo?'));
    valor_maximo = double(input('¿Cuál es el valor máximo?'));
        
    % --- realizamos la ampliacion para cada canal
    img_roja_ampliada = ampliar_histograma(img_roja, valor_minimo, valor_maximo);
    img_verde_ampliada = ampliar_histograma(img_verde, valor_minimo, valor_maximo);
    img_azul_ampliada = ampliar_histograma(img_azul, valor_minimo, valor_maximo);
    
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
    subplot(2,3,4)
    histogram(img_roja_ampliada)
    title('Canal Rojo Ampliado')
    subplot(2,3,5)
    histogram(img_verde_ampliada)
    title('Canal Verde Ampliado')
    subplot(2,3,6)
    histogram(img_azul_ampliada)
    title('Canal Azul Ampliado')
    
    % --- Reconstrucción de la imagen en sus tres canales de color
    imagen_1(:,:,1)=img_roja_ampliada;
    imagen_1(:,:,2)=img_verde_ampliada;
    imagen_1(:,:,3)=img_azul_ampliada;
    figure(3);
    imshow(imagen_1);
    
    % --- Calcular de nuevo
    respuesta = input('¿Deseas calcular con otros valores? S/N','s');
    if isempty(respuesta)
        respuesta = 'N';
    end
    % --- Fin de programa
    if respuesta == 'N' || respuesta == 'n'
        validar = false;
    end
    
    close all
end

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