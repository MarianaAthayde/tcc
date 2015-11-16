clear all;
close all;
clc;

%Simulação Varredura em Paralelo
%[ x | y | v ]
x(1,:) = [randi(30), randi(30), randi(30), randi(30)];
%x(1,:) = [-10, 0, 100];
y(1,:) = [1,1.2,1.4,1.6];
v(1,:) = [0.0,0.0,0.0,0.0];

amostras = 50;
t_amostral = 0.25;
k = 0.5;
vd = 0.5;

for i = 1:amostras
%     mx = max(x(i,:));
%     mn = min(x(i,:)); 
%     xd = ( max(x(i,:)) + min(x(i,:)) )/2;
     
    for j = 1:4
        
        if j == 1
        v(i+1,j) = vd + k * ( (x(i,2) - x(i,j)) + (x(i,3) - x(i,j)) + (x(i,4) - x(i,j)));
        end;
        if j == 2
        v(i+1,j) = vd + k * ( (x(i,1) - x(i,j)));
        end;
        if j == 3
        v(i+1,j) = vd + k * ( (x(i,1) - x(i,j)));
        end;
        if j == 4
        v(i+1,j) = vd + k * ( (x(i,1) - x(i,j)));
        end;
        %v(i+1,j) = vd + k * (xd - x(i,j));
        x(i+1,j) = x(i,j) + v(i+1,j)*cos(0)*t_amostral;
        y(i+1,j) = y(i,j) + v(i+1,j)*sin(0)*t_amostral; 
    end;
    
end;

figure;
        t = title('Problema 1 - Rede Centralizada: vd = 0.5m/s','FontSize',24,'FontWeight','bold');
        xl = xlabel('X (metros)','FontSize',22,'FontWeight','demi');
        yl = ylabel('Y (metros)','FontSize',22,'FontWeight','demi');
pause(10);
for i = 1:amostras
        
    for j = 1:4
        
        plot(x(1:i,j),y(1:i,j),'r');
        t = title('Problema 1 - Rede Centralizada: vd = 0.5m/s','FontSize',24,'FontWeight','bold');
        xl = xlabel('X (metros)','FontSize',22,'FontWeight','demi');
        yl = ylabel('Y (metros)','FontSize',22,'FontWeight','demi');
        %set(l,'FontSize',22,'FontWeight','demi');
        set(gca,'FontSize',22,'FontWeight','demi');
        hold on;
        plot(x(i,j),y(i,j),'r*');    
     
    end;
    if i == 3
            pause(10);
    end
    pause(0.1);
    hold off;
end;
        
