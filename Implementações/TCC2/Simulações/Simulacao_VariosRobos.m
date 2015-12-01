clear all
close all
clc

%Simulação
%Variáveis do Sistema
num_robos = 5; %número de robos do sistema
raio = 0.3; %Raio em torno do alvo - metros
periodo = 24; %Período desejado
wd = 2*pi/periodo; 
vd = wd*raio;
amostras = 2000;
t_amostral = 25/1000.0;
k = 8;
kv = 1.5;
%Posição do Alvo
x_alvo = 0.0;
y_alvo = 0.0;
%Posições Iniciais dos Robos
%Nota: [Mestre Slave1 Slave2]
for i = 1:num_robos;
    xr(1,i) = randi(2)*(-1)^(randi(2)); 
    yr(1,i) = randi(2)*(-1)^(randi(2)); ;
    thetar(1,i) = pi;
    wr(1,i) = 0;
    vr(1,i) = vd;
end;

xr(1,1) = 0.8;
yr(1,1) = 0.0;
thetar(1,1) = pi;
vr(1,1) = vd;

xr(1,2) = -0.8;
yr(1,2) = 0.0;
thetar(1,2) = 0;
vr(1,2) = vd;
wr = zeros(1,num_robos);

%plot(x_alvo,y_alvo,'r*');
%hold on;
for i = 2:amostras
%Nota: [Mestre Slave1 Slave2]
for j = 0:num_robos-1
    xd(i,j+1) = x_alvo + raio*cos(i*t_amostral*wd + j*2*pi/num_robos);
    yd(i,j+1) = y_alvo + raio*sin(i*t_amostral*wd + j*2*pi/num_robos);
%Calculando Xr e Yr e Thetar dos Robos no instante i    
    xr(i,j+1) = xr(i-1,j+1) + t_amostral*vr(i-1,j+1)*cos(thetar(i-1,j+1));
    yr(i,j+1) = yr(i-1,j+1) + t_amostral*vr(i-1,j+1)*sin(thetar(i-1,j+1));
    thetar(i,j+1) = thetar(i-1,j+1) + t_amostral*wr(i-1,j+1);
%Calculando Theta desejado apartir dos erros dos Robos no instante i
    errx = xd(i,j+1) - xr(i,j+1);
    erry = yd(i,j+1) - yr(i,j+1);
    thetad = atan2(erry,errx);
    errt = thetad - thetar(i,j+1);
    errt = atan2(sin(errt),cos(errt));
    wr(i,j+1) = k*errt;   
    dist = sqrt(errx^2+erry^2);
    vr(i,j+1) = vd + kv*dist; 
end;


end;

figure;
plot(x_alvo,y_alvo,'bo');
t = title('Problema 1 - Segunda Abordagem: 5','FontSize',24,'FontWeight','bold');
xl = xlabel('X (metros)','FontSize',22,'FontWeight','demi');
yl = ylabel('Y (metros)','FontSize',22,'FontWeight','demi');
hold on;
axis equal
pause(5);


for i = 1:amostras
        
    for j = 1:num_robos
        
        plot(xr(1:i,j),yr(1:i,j),'r');
        hold on;
        plot(xd(1:i-1,j),yd(1:i-1,j),'b');
        t = title('Problema 2 - Número de Robôs: 5','FontSize',24,'FontWeight','bold');
        xl = xlabel('X (metros)','FontSize',22,'FontWeight','demi');
        yl = ylabel('Y (metros)','FontSize',22,'FontWeight','demi');
        set(gca,'FontSize',22,'FontWeight','demi');
        %hold on;
        plot(xd(i,j),yd(i,j),'b*');
        plot(xr(i,j),yr(i,j),'r*'); 
        %l = legend('Trajetória Robô','Trajetória Posições Desejadas','Robô','Ponto Desejado');
        %set(l,'FontSize',22,'FontWeight','demi');
        
     
    end;
    if i == 3
        %   pause(10);
    end
    pause(0.0001);
    hold off;
end;