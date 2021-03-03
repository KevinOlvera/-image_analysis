img = imread('leocuadro.jpg');
imge = imread('londres.jpg');

figure(1);
imshow(img);

[i,j,c]=size(img);
[p,q,r]=size(imge);

ej2=img;
ej3=img;
ej4=img;
ej5=imge;

%EJERCICIO 2
col=fix(j/3);
%red
ej2(:,1:col,1);
ej2(:,1:col,2)=0;
ej2(:,1:col,3)=0;
%green
ej2(:,col+1:col*2,1)=0;
ej2(:,col+1:col*2,2);
ej2(:,col+1:col*2,3)=0;
%blue
ej2(:,col*2+1:end,1)=0;
ej2(:,col*2+1:end,2)=0;
ej2(:,col*2+1:end,3);
figure(2);
imshow(ej2);


%EJERCICIO 3
row=fix(i/3);
%red
ej3(1:row,:,1);
ej3(1:row,:,2)=0;
ej3(1:row,:,3)=0;
%green
ej3(row+1:row*2,:,1)=0;
ej3(row+1:row*2,:,2);
ej3(row+1:row*2,:,3)=0;
%blue
ej3(row*2+1:end,:,1)=0;
ej3(row*2+1:end,:,2)=0;
ej3(row*2+1:end,:,3);
figure(3);
imshow(ej3);

%EJERCICIO 4
step=j;
col=fix(j/3)

for m = 1:col
   ej4(1:step,m,1);
   ej4(1:step,m,2)=0;
   ej4(1:step,m,3)=0;
   step=step-1;
end
for m = (col+1):(2*col)
   ej4(1:step,m,1)=0;
   ej4(1:step,m,2);
   ej4(1:step,m,3)=0;
   step=step-1;
end
 for m = (2*col+1):j
    ej4(1:step,m,1)=0;
    ej4(1:step,m,2)=0;
    ej4(1:step,m,3);
    step=step-1;
 end
 figure(4);
 imshow(ej4);

%EJERCICIO 5
col=fix(q/12);

%extremos
ej5(:,1:col,1);
ej5(:,1:col,2)=0;
ej5(:,1:col,3)=0;

ej5(:,col*11+1:end,1)=0;
ej5(:,col*11+1:end,2)=0;
ej5(:,col*11+1:end,3);

%primer verde
ej5(500:end,col+1:col*3,1)=0;
ej5(500:end,col+1:col*3,2);
ej5(500:end,col+1:col*3,3)=0;

%pilar rojo
ej5(500:end,col*3+1:col*5,1);
ej5(500:end,col*3+1:col*5,2)=0;
ej5(500:end,col*3+1:col*5,3)=0;

%central verde
ej5(500:end,col*5+1:col*7,1)=0;
ej5(500:end,col*5+1:col*7,2);
ej5(500:end,col*5+1:col*7,3)=0;

%pilar azul
ej5(500:end,col*7+1:col*9,1)=0;
ej5(500:end,col*7+1:col*9,2)=0;
ej5(500:end,col*7+1:col*9,3);

%pilar azul
ej5(500:end,col*9+1:col*11,1)=0;
ej5(500:end,col*9+1:col*11,2);
ej5(500:end,col*9+1:col*11,3)=0;

%barra verde
ej5(1:499,col+1:col*11,1)=0;
ej5(1:499,col+1:col*11,2);
ej5(1:499,col+1:col*11,3)=0;

figure(5);
imshow(ej5);
