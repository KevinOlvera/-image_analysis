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
imagen_2 = imagen_1;


% -----EJERCICIO 3A
% --- menu para ingresar los datos
validar = true;
while validar
    
    % --- seccionamos la imagen en sus componentes de color
    img_roja = imagen_1(:,:,1);
    img_verde = imagen_1(:,:,2);
    img_azul = imagen_1(:,:,3);
    
    valor_minimo = double(input('¿Cuál es el valor mínimo?'));
    valor_maximo = double(input('¿Cuál es el valor máximo?'));
    
    % --- realizamos la ecualizacion para cada canal
    img_roja_ampliada = ampliar_histograma(img_roja, valor_minimo, valor_maximo);
    img_verde_ampliada= ampliar_histograma(img_verde, valor_minimo, valor_maximo);
    img_azul_ampliada=  ampliar_histograma(img_azul, valor_minimo, valor_maximo);
      
    % --- realizamos la ecualizacion para cada canal
    img_roja_ecualizada = ecualizar_histograma(img_roja, valor_minimo, valor_maximo);
    img_verde_ecualizada= ecualizar_histograma(img_verde, valor_minimo, valor_maximo);
    img_azul_ecualizada = ecualizar_histograma(img_azul, valor_minimo, valor_maximo);
    
    % --- Reconstrucción de las imagenes en sus tres canales de color
    
    imagen_1(:,:,1)=img_roja_ampliada;
    imagen_1(:,:,2)=img_verde_ampliada;
    imagen_1(:,:,3)=img_azul_ampliada;
    
    imagen_2(:,:,1)=img_roja_ecualizada;
    imagen_2(:,:,2)=img_verde_ecualizada;
    imagen_2(:,:,3)=img_azul_ecualizada;
    
    
    % --- Se muestran en pantalla los histogramas
    figure(2)
    % --- Histogramas ampliados
    subplot(2,4,1)
    histogram(img_roja_ampliada)
    title('Canal Rojo Ampliado')
    subplot(2,4,2)
    histogram(img_verde_ampliada)
    title('Canal Verde Ampliado')
    subplot(2,4,3)
    histogram(img_azul_ampliada)
    title('Canal Azul Ampliado')
    subplot(2,4,4)
    imshow(imagen_1);
    title('Imagen ampliada')
    % --- Histogramas ecualizados
    subplot(2,4,5)
    histogram(img_roja_ecualizada)
    title('Canal Rojo Ecualizado')
    subplot(2,4,6)
    histogram(img_verde_ecualizada)
    title('Canal Verde Ecualizado')
    subplot(2,4,7)
    histogram(img_azul_ecualizada)
    title('Canal Azul Ecualizado')
    subplot(2,4,8)
    imshow(imagen_2);
    title('Imagen ecualizada')
        
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

% % % -----EJERCICIO 3B
% % 
% % img_a=imread ('img1.png');
% % img_b=imread ('img2.png');
% % 
% % a=rgb2gray(img_a);
% % b=rgb2gray(img_b);
% % 
% % [alto,ancho]=size(b)
% % 
% % acum_a=getProbabilidadAcumulada(a);
% % acum_b=getProbabilidadAcumulada(b);

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

function imagen_ecualizada = ecualizar_histograma(imagen, min, max)
    imagen_ecualizada = imagen; 
    [alto, ancho] = size(imagen);
    
    % --- Obtención del arreglo con las probabilidades acumuladas Pac(g)
    pAcumGris = getProbabilidadAcumulada(imagen);
    
    % --- Se itera sobre cada pixel de la imagen aplicando la fórmula de
    % ecualización
    for i = 1:alto
        for j = 1:ancho
            imagen_ecualizada(i,j)=round((max-min)*pAcumGris(imagen(i,j)+1)+min);   
        end
    end
end

function pAcumGris = getProbabilidadAcumulada(imagen)
    [alto,ancho]=size(imagen);
    nivelesGris=zeros(1,256); % --- N(g)
    pGris=zeros(1,256);       % --- P(g)
    pAcumGris=zeros(1,256);   % --- Pac(g)
    acum=0;
    
    % --- Obtencion del histograma N(g)
    for i = 1:alto
        for j = 1:ancho
            indice= imagen(i,j)+1;
            nivelesGris(indice)= nivelesGris(indice)+1;    
        end
    end
    
    % --- Obtencionde la probabilidad P(g) y la probabilidad acumulada Pac(g) 
    for i = 1:256
        pGris(i)=nivelesGris(i)/(alto*ancho);
        acum=pGris(i)+acum;
        pAcumGris(i)=acum;
    end
    
end


