% --- Image Analysis 3CV14
% --- Olvera Olvera Kevin Jesus

% --- TODO: Aqui va la descripcion de la practica!!!

% --- Inicio
% --- limpiar espacio de trabajo
clc
clear all
close all

% --- variables - imagen original
imagen = imread ('peppers.png');
imagen = rgb2gray(imagen);

% --- menu para ingresar los datos
validar = true;
 
while validar
    bits = double(input('¿A cúantos bits desea comprimir?'));
    predictor = crear_predictor(imagen);
    imagen = double(imagen);
    error = imagen - predictor;
    [min, max] = limites_imagen(error);
      
    rangos_error = rangos_error_arreglo(min,max,bits);
     
    meq = matriz_meq(error,rangos_error);
       
    niveles_error = niveles_error_arreglo(rangos_error,bits); 
       
    meq_1 = matriz_meq_1(meq, niveles_error);
        
    resultante = meq_1 + predictor;
     
    s_n = calcular_s_n(imagen, resultante);
    
    imagen=uint8(imagen);
    resultante=uint8(resultante);
    imagenes = [imagen,resultante];
     
    figure(1)
    imshow(imagenes)
     
    disp('s/n = ')
    disp(s_n);
    disp('dB')
        
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
function predictor = crear_predictor(imagen)
    [alto, ancho] = size(imagen);
    predictor = zeros(alto, ancho);
    predictor(1:alto) = imagen(1:alto);
    predictor(1,1:ancho) = imagen(1,1:ancho);
    
    for i = 2 : +1 :alto
        for j = 2: +1 :ancho
            if i == alto && j < ancho
                total = 4;
            elseif j == 2 && j < ancho
                total = 5;
            elseif j < ancho
                total = 4;
            else
                total = 3;
            end
            predictor(i, j) = round(sum(segmento_auxiliar(predictor, i, j), 'all')/total);
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

function arreglo = rangos_error_arreglo(min,max,bits);
    factor = power(2,bits);
    teta = (max - min)/factor;
    arreglo = zeros(1,factor+1);
    acum=min;
    for i = 1:factor+1  
        arreglo(i)=acum; 
        acum=acum+teta;
    end   
end

function arreglo = matriz_meq(error,niveles_error)
    [alto,ancho]=size(error);
    arreglo = zeros(alto,ancho);
    for i = 1:alto
        for j = 1:ancho
            arreglo(i,j)=encontrar_val(error(i,j),niveles_error);
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

function arreglo =  niveles_error_arreglo(rangos_error,bits)
    factor = power(2,bits);
    arreglo = zeros(1,factor);
    for i=1:factor
        arreglo(i)=(rangos_error(i)+rangos_error(i+1))/2;
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

function valor = calcular_s_n(original, resultante)
    
    [largo,ancho]=size(original);
    numerador=0;
    denominador=0;
    
    for i = 1:largo
        for j = 1:ancho
            or=original(i,j);
            res=resultante(i,j);
            numerador=numerador+power(or,2);
            denominador=denominador+power(or-res,2);
        end
    end
    res=numerador/denominador;
    valor=10*log10(res);
end
