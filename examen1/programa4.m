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
histograma_a = ampliar_histograma(img_roja, 0, 5);
histograma_b = ampliar_histograma(img_azul, 176, 255);

figure(1)
subplot(1,2,1)
histogram(histograma_a)
title('Histograma A')
subplot(1,2,2)
histogram(histograma_b)
title('Histograma B')

[alto_a, ancho_a] = size(histograma_a);
[alto_b, ancho_b] = size(histograma_b);

ocurrencias_a = ocurrences(histograma_a, alto_a, ancho_a);
ocurrencias_b = ocurrences(histograma_b, alto_b, ancho_b);

correspondencia = correspondence(ocurrencias_a, ocurrencias_b);

imagen_correspondiente = new_image(correspondencia, histograma_b, alto_b, ancho_b);

figure(2)
subplot(1,2,1)
histogram(histograma_a)
title('Histograma A')
subplot(1,2,2)
histogram(imagen_correspondiente)
title('Histograma B Nuevo')

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

function resultado = ocurrences(imagen, alto, ancho)
    lista = [];
    index = 1;
    for i = 1: +1 : alto
        for j = 1: +1: ancho
            if ismember(imagen(i,j), lista)
                continue
            else
                lista(index) = imagen(i,j);
                index = index + 1;
            end
        end
    end
    lista = sort(lista);
    
    for item = lista
        data(item+1).g = item;
    end
    
    acumulado = 0;
    for item = lista
       contador = 0;
       for i=1: +1 : alto
           for j=1 : +1 :ancho
               if imagen(i,j) == item
                   contador = contador + 1;
               end
           end
       end
       
       acumulado = acumulado + contador;
       data(item+1).ng = contador;
       data(item+1).pn = contador / (alto*ancho);
       data(item+1).pag = acumulado / (alto*ancho);
    end 
    
    resultado = data;
end

function resultado = correspondence(data_A, data_B)
    for item = data_B
        lista_correspondencia(item.g + 1) = find_correspondence(data_A, item.pag);
    end
    resultado = lista_correspondencia;
end

function resultado = find_correspondence(data, pag)
    g=0;
    for item = data
        if pag < item.pag
            continue
        elseif pag >= item.pag
            g = item.g;
        end
    end
    resultado = g;
end

function resultado = new_image(lista, imagen, alto, ancho)
    for i = 1 : +1 :alto
        for j = 1: +1 :ancho
            imagen(i,j) = lista(imagen(i,j) + 1);
        end
    end
    resultado = imagen;
end
