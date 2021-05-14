clc %Limpia la pantalla
clear all %limpia todas las variables
close all %cierra todo
warning off all %evita llamadas de atención

%variables
lista_etapas = {};
lista_bits = {};
setGlobalList(lista_etapas);
imagen = imread('peppers.png');
imagen = rgb2gray(imagen);
[alto, ancho] = size(imagen);

% imagen = [1 1 0 1 9; 2 2 2 3 9; 2 2 3 2 9; 4 4 1 2 9];
% [alto, ancho] = size(imagen);

archivo = ArchivoTXT;

archivo.idArchivo = fopen('3CV3.txt','r');
lista = ocurrences(imagen, alto, ancho);
% if archivo.estaVacio()
    archivo.idArchivo = fclose(archivo.idArchivo);
    archivo.idArchivo = fopen('3CV3.txt','w+');
    [etapas, num] = sumar_lista([lista.p]);

    x = getGlobalList;

    x(end+1)={[lista.n]};

    setGlobalList(x);

    lista_etapas = getGlobalList; % lista con los resultados de las etapas

    c = relBits(lista_etapas);
    
    archivo.escribir(c,size(c));
% else
%    c = archivo.leer(); 
% end

archivo.idArchivo = fclose(archivo.idArchivo);

entropia = calcularEntropia([lista.p]);

longitudMedia = calcularLM(c);

eficiencia = entropia/longitudMedia * 100;

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
    lista_ordenada = sort(lista,'descend');
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
    cantidad = [];
    probabilidad = [];
    index = 1;
    
    for i = 1: +1 : alto
        for j = 1: +1: ancho
            if ~ismember(imagen(i,j), lista)
                lista(index) = imagen(i,j);
                index = index + 1;
            end
        end
    end
    lista = sort(lista);
    index = 1;
    for item = lista
       contador = 0;
       for i=1: +1 : alto
           for j=1 : +1 :ancho
               if imagen(i,j) == item
                   contador = contador + 1;
               end
           end
       end
       cantidad(index) = contador;
       probabilidad(index) = contador / (alto*ancho);
       index = index + 1;
    end 
    y = 1;
    listaOrdenada = [];
    for item = probabilidad
        if ~ismember(item, listaOrdenada)
            listaOrdenada(y) = item;
            y = y + 1;
        end
    end
    listaOrdenada = sort(listaOrdenada,'descend');
    
    n = 1;
    for item = listaOrdenada
        aux = [];
        aumento = 1;
        for x = index-1: -1: 1
            if item == probabilidad(x)
                aux(aumento) = x;
                aumento = aumento + 1;
            end
        end
        for x = 1: +1 : aumento -1 
            data(n).n = lista(aux(x));
            data(n).o = cantidad(aux(x));
            data(n).p = probabilidad(aux(x));
            n = n + 1;
        end
    end
    
    resultado = data;
end

function resultado = calcularEntropia(lista)
    aux = 0;
    for item=lista
        aux = aux + ecuacionEntropia(item); 
    end
    resultado = aux;
end

function resultado = ecuacionEntropia(probabilidad)
    X = probabilidad ^ (-1);
    resultado = probabilidad * (log2(X));
    resultado = round(resultado, 2);
end

function resultado = relBits(lista)
    ultima = lista{1};
    c = ["",""];
    c(1,1) = num2str(ultima(end-1));
    c(1,2) = "1";
    c(2,1) = num2str(ultima(end));
    c(2,2) = "0";
    for i = 2: +1 : length(lista)-1
        aumento = 1;
        aux = ["",""];
        %Paso 1: Leer ultima fila
        ultima = lista{i};
        for item = ultima
            aux(aumento,1) = num2str(item);
            aumento = aumento + 1;
        end
        aux(end-1,2) = c(end-1,2);
        aux(end,2) = c(end,2);
        %Paso 2: Encontrar suma
        sum = num2str(ultima(end-1) + ultima(end));
        for j = 1: +1: length(c)
            if strcmp(sum,c(j,1))
                match = j;
            end
        end
        %Paso 3: Leer ultimo bit y asignar en la ultima fila
        bit = split(c(match,2));
        
        if strcmp(bit(1),"1")
            aux(end-1,2) = strcat ("1 ", aux(end-1,2));
            aux(end,2) = strcat ("1 ", aux(end,2));
        else
            aux(end-1,2) = strcat ("0 ", aux(end-1,2));
            aux(end,2) = strcat ("0 ", aux(end,2));
        end
        %Paso 4: Buscar elementos faltantes en la anterior fila
        for i = 1: +1: length(aux)-2
            for j = 1: +1: length(c)
                if strcmp(aux(i,1),c(j,1))
                    aux(i,2) = c(j,2);
                    c(j,1) = "0";
                    break
                end
            end
        end
        c = aux;
    end
    resultado = ["","",""];
    numero = lista{end};
    for i = 1: +1: length(c)
        resultado(i,1) = num2str(numero(i));
        resultado(i,2) = c(i,1);
        aux = split(c(i,2));
        string = "";
        for j = 1: +1:length(aux)
            string = strcat(string,aux(j));
        end
        resultado(i,3) = string;
    end
end

function resultado = calcularLM(lista)
    resultado = 0.0;
    for i = 1: +1: size(lista)
        resultado = resultado + ecuacion(str2double(lista(i,2)),strlength(lista(i,3)));
    end   
end

function resultado = ecuacion(x,y)
    resultado = x * y;
end