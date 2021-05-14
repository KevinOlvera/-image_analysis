clc %Limpia la pantalla
clear all %limpia todas las variables
close all %cierra todo
warning off all %evita llamadas de atención

%variables
lista_etapas = {};
setGlobalList(lista_etapas);
imagen = imread('peppers.png');
imagen = rgb2gray(imagen);
[alto, ancho] = size(imagen);

imagen = [1 1 0 1; 2 2 2 3; 2 2 3 2; 4 4 1 2 ];
[alto, ancho] = size(imagen);

archivo = ArchivoTXT;

archivo.idArchivo = fopen('3CV3.txt','r+');

archivo.idArchivo = fopen(archivo.idArchivo);

lista = ocurrences(imagen, alto, ancho);

entropia = calcularEntropia(lista);

[etapas, num] = sumar_lista([lista.p]);

lista_etapas = getGlobalList; % lista con los resultados de las etapas

idArchivo = fopen('3CV3.txt','w');
%

% figure(1)
% subplot(1,2,1)
% imshow(imagen);
% title('Imagen');
% subplot(1,2,2)
% histogram(imagen);
% title('Histograma');

%funciones
function setGlobalList(val)
global x
x = val;
end

function r = getGlobalList
global x
r = x;
end

function [resultado, index] = sumar_lista(lista)
    lista_ordenada = sort(lista, 'descend');
    lista_aux = lista_ordenada;
    longitud = length(lista_ordenada);
    
    if longitud > 2
        suma = lista_ordenada(longitud-1) + lista_ordenada(longitud);
        
        lista_aux(longitud-1) = suma;
        lista_aux(end) = [];
        
        [resultado, index] = sumar_lista(lista_aux);
        index = index + 1;
    else
        index = 1;
        resultado = lista_ordenada;
    end
    x = getGlobalList;
    x(end+1) = {lista_ordenada};
    setGlobalList(x);
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
        data(item+1).n = item;
    end
    
    for item = lista
       contador = 0;
       for i=1: +1 : alto
           for j=1 : +1 :ancho
               if imagen(i,j) == item
                   contador = contador + 1;
               end
           end
       end
       
       data(item+1).o = contador;
       data(item+1).p = contador / (alto*ancho);
    end 
    
    resultado = data;
end

function resultado = calcularEntropia(lista)
    aux = 0;
    for item=lista
        aux = aux + ecuacionEntropia(item.p); 
    end
    resultado = aux;
end

function resultado = ecuacionEntropia(probabilidad)
    X = probabilidad ^ (-1);
    resultado = probabilidad * (log2(X));
    %resultado = round(resultado, 2);
end