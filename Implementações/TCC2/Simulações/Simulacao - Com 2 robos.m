clear all
close all
clc

%Simulação
%Variáveis do Sistema
num_robos = 2; %número de robos do sistema
raio = 0.3; %Raio em torno do alvo - metros
periodo = 24; %Período desejado
wd = 2*pi/periodo; 
vd = wd*raio;
t_amostral = 25/1000.0;
k = 1;
kv = 0.1;
%Posição do Alvo
x_alvo = 0.0;
y_alvo = 0.0;
%Posições Iniciais dos Robos
%Nota: [Mestre Slave1 Slave2]
for i = 1:num_robos;
    xr(1,i) = 0; 
    yr(1,i) = 0;
    thetar(1,i) = pi;
    wr(1,i) = 0;
end;

xr(1,1) = 0.8;
yr(1,1) = 0.0;
thetar(1,1) = pi;
vr(1,1) = vd;

xr(1,2) = -0.8;
yr(1,2) = 0.0;
thetar(1,2) = 0;
vr(1,2) = vd;
wr = zeros(1,2);

plot(x_alvo,y_alvo,'r*');
hold on;
for i = 2:2001
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

% % % % %Nota: [Mestre Slave1 Slave2]
% % % % %for j = 0:num_robos-1
% % % %     xd(i) = x_alvo + raio*cos(i*t_amostral*wd);
% % % %     yd(i) = y_alvo + raio*sin(i*t_amostral*wd);
% % % % %Calculando Xr e Yr e Thetar dos Robos no instante i    
% % % %     xr(i) = xr(i-1) + t_amostral*vr(i-1)*cos(thetar(i-1));
% % % %     yr(i) = yr(i-1) + t_amostral*vr(i-1)*sin(thetar(i-1));
% % % %     thetar(i) = thetar(i-1) + t_amostral*wr(i-1);
% % % % %Calculando Theta desejado apartir dos erros dos Robos no instante i
% % % %     errx = xd(i) - xr(i);
% % % %     erry = yd(i) - yr(i);
% % % %     thetad = atan2(erry,errx);
% % % %     errt = thetad - thetar;
% % % %     errt = atan2(sin(errt),cos(errt));
% % % %     wr = k*errt;   
% % % %     dist = sqrt(errx^2+erry^2);
% % % %     vr(i) = vd + kv*dist; 
% % % % %end;

end;

plot(xr,yr,'r');
hold on;
plot(xd,yd,'b');
axis equal

figure;
for i = 1:10:2001
       plot(xr(1:i,1),yr(1:i,1),'r');
       hold on;
       plot(xr(i,1),yr(i,1),'r*');
       axis equal
       plot(xd(1:i,1),yd(1:i,1),'b');
       plot(xd(i,1),yd(i,1),'b*');
       
       plot(xr(1:i,2),yr(1:i,2),'r');
       plot(xr(i,2),yr(i,2),'r*');
       axis equal
       plot(xd(1:i,2),yd(1:i,2),'b');
       plot(xd(i,2),yd(i,2),'b*');
       
       pause(0.0001);
       hold off
end;