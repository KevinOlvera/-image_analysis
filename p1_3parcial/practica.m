% imagen = imread ('imagen4fig.bmp');
% imagen = imagen(:,:,1);
% imgBin = imbinarize(imagen);
% imshow(imgBin);
% 
% [alto,ancho]=size(imgBin);
 
imagen = [1 0 0 1 0 0;0 0 1 0 1 0;0 0 0 0 1 0;1 0 0 1 0 0;1 0 0 1 0 1];
imgBin = imbinarize(imagen);
[alto,ancho]=size(imgBin);

imgAux = zeros(alto,ancho);

contadorImagenes=0;
  
for i=1:alto
     for j =1:ancho
         if imgBin(i,j)==1
             valor = encontrarAdyacencia(i,j,imgAux);
             if valor==0
                %No hay pixeles adyacentes
                contadorImagenes=contadorImagenes+1;
                valor=contadorImagenes;
             end
             imgAux(i,j)=valor;
          end
      end
 end
imgAux
disp('En total se encontraron:');
disp(contadorImagenes);
 
function valor = encontrarAdyacencia(fila,columna,imgAux)
     %fila superior
     valor0_0=verificar_indice(imgAux,fila-1,columna-1);    
     valor0_1=verificar_indice(imgAux,fila-1,columna);    
     valor0_2=verificar_indice(imgAux,fila-1,columna+1);    
     
     %fila central
     valor0_3=verificar_indice(imgAux,fila,columna-1);    
     valor0_5=verificar_indice(imgAux,fila,columna+1);    
     
     %fila inferior
     valor0_6=verificar_indice(imgAux,fila+1,columna-1);    
     valor0_7=verificar_indice(imgAux,fila+1,columna);    
     valor0_8=verificar_indice(imgAux,fila+1,columna+1);  
        
     if valor0_0>0
         valor=valor0_0;
     elseif valor0_1>0
         valor=valor0_1;
     elseif valor0_2>0
         valor=valor0_2;
     elseif valor0_3>0
         valor=valor0_3;
     elseif valor0_5>0
         valor=valor0_5;
     elseif valor0_6>0
         valor=valor0_6;
     elseif valor0_7>0
         valor=valor0_7;
     elseif valor0_8>0
         valor=valor0_8;
     else
         valor=0;
     end
end
 
function resultado = verificar_indice(valor,fila,columna)
     try
         resultado = valor(fila, columna);
     catch
         resultado = 0;
     end
 end