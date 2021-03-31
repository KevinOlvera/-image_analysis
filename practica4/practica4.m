% --- Image Analysis 3CV14
% --- Olvera Olvera Kevin Jesus

% --- TODO: Aqui va la descripcion de la practica!!!

% --- Inicio
% --- limpiar espacio de trabajo
clc
clear all
close all

% --- variables - imagen original
% imagen = imread ('peppers.png');
% imagen = rgb2gray(imagen);
% figure(1)
% imshow(imagen)
% title('Imagen Original')
%imagen = [1 1 1 2 7;8 3 2 1 1; 1 3 9 2 1; 1 2 2 3 1; 1 1 1 2 1; 1 2 4 3 5];

imagen = [11 19 27; 19 82 54;21 19 36];
predictor = [11 19 27; 19 19 22;21 20 20];
error = imagen - predictor;
% --- menu para ingresar los datos
validar = true;
%while validar
    % bits = double(input('¿A cúantos bits desea comprimir?'));
    bits=4;

%    predictor = crear_predictor(imagen)
%    error = imagen - predictor;
    [min, max] = limites_imagen(error);
    recta1_meq = obtener_recta1_meq(min,max,bits);
    
    meq = matriz_meq(error,recta1_meq);
    
    recta2_meq = obtener_recta2_meq(recta1_meq,bits); 
    
    meq_1 = matriz_meq_1(meq,recta2_meq);
     
    mrec = meq_1 + predictor
        
     % --- Calcular de nuevo
%     respuesta = input('¿Deseas calcular con otros valores? S/N','s');
%     if isempty(respuesta)
%         respuesta = 'N';
%     end
%     % --- Fin de programa
%     if respuesta == 'N' || respuesta == 'n'
%         validar = false;
%     end
    
    %close all
% end

% --- Funciones del programa
function predictor = crear_predictor(imagen)
    [alto, ancho] = size(imagen);
    predictor = zeros(alto, ancho);
    predictor(1:alto) = imagen(1:alto);
    predictor(1,1:ancho) = imagen(1,1:ancho);
    
    for i = 2 : +1 :alto
        for j = 2: +1 :ancho
            if i == alto || j == ancho
                total = 4;
            else
                total = 5;
            end
            predictor(i, j) = uint8(round(sum(segmento_auxiliar(predictor, i, j), 'all')/total));
        end
    end
end

function imagen_auxiliar = segmento_auxiliar(imagen, fila, columna)
    imagen_auxiliar = [];
    % arriba
    imagen_auxiliar(1,1) = verificar_indice(imagen, fila-1, columna-1);
    imagen_auxiliar(1,2) = verificar_indice(imagen, fila-1, columna);
    imagen_auxiliar(1,3) = verificar_indice(imagen, fila-1, columna+1);
    
    %medio
    imagen_auxiliar(2,1) = verificar_indice(imagen, fila, columna-1);
    %centro
    imagen_auxiliar(2,2) = imagen(fila, columna);
    imagen_auxiliar(2,3) = verificar_indice(imagen, fila, columna+1);
    
    %bajo
    imagen_auxiliar(3,1) = verificar_indice(imagen, fila+1, columna-1);
    imagen_auxiliar(3,2) = verificar_indice(imagen, fila+1, columna);
    imagen_auxiliar(3,3) = verificar_indice(imagen, fila+1, columna+1);   
end

function resultado = verificar_indice(valor, fila, columna)
    try
        resultado = valor(fila, columna);
    catch
        resultado = 0;
    end
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

function arreglo = obtener_recta1_meq(min,max,bits)
    factor = power(2,bits);
    teta = round((max - min)/factor);
    arreglo = zeros(1,factor+1);
    acum=min;
    for i = 1:factor+1  
        arreglo(i)=acum; 
        acum=acum+teta;
    end   
end

function meq = matriz_meq(error,recta_meq)
    [alto,ancho]=size(error);
    meq = zeros(alto,ancho);
    for i = 1:alto
        for j = 1:ancho
            meq(i,j)=encontrar_val(error(i,j),recta_meq);
        end
    end
end

function valor = encontrar_val(val,arr_meq)
    [fila,columna] = size(arr_meq);
    valor=0;
    for i = 1:(columna-1)
        if val>=arr_meq(i) && val<=arr_meq(i+1)
            valor=i;
            break
        end
    end    
end

function arreglo = obtener_recta2_meq(recta1_meq,bits)
    factor = power(2,bits);
    arreglo = zeros(1,factor);
    for i=1:factor
        arreglo(i)=(recta1_meq(i)+recta1_meq(i+1))/2;
    end
end   


function meq_1 = matriz_meq_1(meq,recta2_meq)
    [alto,ancho]=size(meq);
    meq_1 = zeros(alto,ancho);
    for i = 1:alto
        for j = 1:ancho
            meq_1(i,j)=recta2_meq(meq(i,j));
        end
    end
    
end
