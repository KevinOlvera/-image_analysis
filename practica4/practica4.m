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
imagen = [1 1 1 2 7;8 3 2 1 1; 1 3 9 2 1; 1 2 2 3 1; 1 1 1 2 1; 1 2 4 3 5];

% --- menu para ingresar los datos
validar = true;
%while validar
    % bits = double(input('¿A cúantos bits desea comprimir?'));
    
    predictor = crear_predictor(imagen);
    error = imagen - predictor;
    
    
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