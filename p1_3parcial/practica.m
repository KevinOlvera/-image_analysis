imagen = imread ('imagen4fig.bmp');
figure(1)
imshow(imagen);

imagen = imagen(:,:,1);

%imagen = [0 1 0 0 0 1;0 1 1 1 1 1;0 0 0 0 0 0;0 1 1 0 0 1];

% 0 1 0 0 0 1 
% 0 1 1 1 1 1 
% 0 0 0 0 0 0
% 0 1 1 0 0 1

imgBin = imbinarize(imagen);
%imshow(imgBin);
[alto,ancho]=size(imgBin);
%a b c
%d e f 
%g h i
global imgAux;
imgAux = zeros(alto,ancho);

for i=1:alto
    for j=1:ancho
        if imgBin(i,j)==1
            imgAux(i,j)=1;
        end 
    end
end

contadorImagenes=2;
   
for i=1:alto
      for j =1:ancho
         if imgAux(i,j)==1
             findImg(i,j,contadorImagenes);
             contadorImagenes=contadorImagenes+1;
         end
      end
end
%imgAux
disp('Número de imágenes encontradas');
disp(contadorImagenes-2);

rojo  =  zeros(alto,ancho);
verde =  zeros(alto,ancho);
azul  =  zeros(alto,ancho);

for i=1:alto
    for j=1:ancho
        if imgAux(i,j)==2
            rojo(i,j)=255;
            verde(i,j)=0;
            azul(i,j)=0;
        elseif imgAux(i,j)==3
            rojo(i,j)=0;
            verde(i,j)=255;
            azul(i,j)=0;
        elseif imgAux(i,j)==4
            rojo(i,j)=255;
            verde(i,j)=0;
            azul(i,j)=255;
        elseif imgAux(i,j)==5
            rojo(i,j)=0;
            verde(i,j)=0;
            azul(i,j)=255;
        elseif imgAux(i,j)==6
            rojo(i,j)=255;
            verde(i,j)=128;
            azul(i,j)=0;
        elseif imgAux(i,j)==7
            rojo(i,j)=255;
            verde(i,j)=255;
            azul(i,j)=51;
        elseif imgAux(i,j)==8
            rojo(i,j)=153;
            verde(i,j)=51;
            azul(i,j)=255;
        end          
    end
end

if contadorImagenes>0
    disp('Imagen 1 es Roja')
end
if contadorImagenes>1
    disp('Imagen 2 es Verde')
end
if contadorImagenes>2
    disp('Imagen 3 es Rosa')
end
if contadorImagenes>3
    disp('Imagen 4 es Azul')
end
if contadorImagenes>5
    disp('Imagen 5 es Naranja')
end

if contadorImagenes>6
    disp('Imagen 6 es Amarilla')
end

if contadorImagenes>7
    disp('Imagen 7 es Morada')
end

imagen(:,:,1)=rojo;
imagen(:,:,2)=verde;
imagen(:,:,3)=azul;
figure(2)
imshow(imagen);

function valor = findImg(x,y,val)
    global imgAux;
    
    imgAux(x,y)=val;
    
    a = verificar_indice(x-1,y-1);
    b = verificar_indice(x-1,y  );
    c = verificar_indice(x-1,y+1);
    d = verificar_indice(x  ,y-1);
    f = verificar_indice(x  ,y+1);
    g = verificar_indice(x+1,y-1);
    h = verificar_indice(x+1,y  );
    i = verificar_indice(x+1,y+1);
    
    if  a==1 
        findImg(x-1,y-1,val);
    end
    if b==1 
        findImg(x-1,y  ,val);
    end
    if c==1 
        findImg(x-1,y+1,val);
    end
    if d==1 
        findImg(x  ,y-1,val);
    end
    if f==1 
        findImg(x  ,y+1,val);
    end
    if g==1 
        findImg(x+1,y-1,val);
    end
    if h==1 
        findImg(x+1,y  ,val);
    end
    if i==1    
        findImg(x+1,y+1,val);
    end   
    
end

function resultado = verificar_indice(x,y)
    global imgAux;
     try
         resultado = imgAux(x, y);
     catch
         resultado = 0;
     end
end