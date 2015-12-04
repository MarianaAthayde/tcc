clear all
close all
clc

%Simulação
%Variáveis do Sistema
num_robos = 5; %número de robos do sistema
raio = 0.4; %Raio em torno do alvo - metros
periodo = 24; %Período desejado
dist_min = 0.1; %Distancia mínima de colisão
wd = 0;%2*pi/periodo; 
vd = 0.5;%wd*raio;
t_amostral = 25/1000.0;
amostras = 300;
kp = 10;
kv = 6;
%Posição do Alvo
x_alvo = 0.0;
y_alvo = 0.0;

flag_modo1 = 1; %Colisão
flag_modo2 = 0; %Esperar Conversão

%Posições Iniciais dos Robos
%Nota: [Mestre Slave1 Slave2]
for i = 1:num_robos;
    xr(1,i) = randi(5)*(-1)^(randi(2,1)); 
    yr(1,i) = randi(2)*(-1)^(randi(2,1));%i;%randi(3)*(-1)^(randi(2,1));
    thetar(1,i) = pi;
    wr(1,i) = rand(1);
    vr(1,i) = rand(1);
end;

qnt_robos(1) = num_robos;

dist = zeros(qnt_robos(1),qnt_robos(1));

%plot(x_alvo,y_alvo,'r*');
%hold on;
for i = 2:amostras
%Nota: [Mestre Slave1 Slave2]
qnt_robos(i) = num_robos;
for j = 0:num_robos-1
    xd(i,j+1) = ( max(xr(i-1,:)) + min(xr(i-1,:)) )/2;
    if (( max(xr(i-1,:)) - min(xr(i-1,:)) )<= 0.1)
        xd(i,j+1) = max(xr(i-1,:)) + vd*t_amostral;
    end;
    yd(i,j+1) = (j+1)/5;%yr(1,j+1);%(j+1)/10;
%Calculando Xr e Yr e Thetar dos Robos no instante i    
    xr(i,j+1) = xr(i-1,j+1) + t_amostral*vr(i-1,j+1)*cos(thetar(i-1,j+1));
    yr(i,j+1) = yr(i-1,j+1) + t_amostral*vr(i-1,j+1)*sin(thetar(i-1,j+1));
    thetar(i,j+1) = thetar(i-1,j+1) + t_amostral*wr(i-1,j+1);
%Calculando Theta desejado apartir dos erros dos Robos no instante i
    errxd = xd(i,j+1) - xr(i,j+1);
    erryd = yd(i,j+1) - yr(i,j+1);
    thetad = atan2(erryd,errxd);
    errt = thetad - thetar(i,j+1);
    errt = atan2(sin(errt),cos(errt));
    edist = sqrt(errxd^2+erryd^2);
    wr(i,j+1) = kp*errt;   
    vr(i,j+1) = vd*kv*edist;%vd + kv * edist;% + kv*edist;
    
    %Esperar os prioritários convergir
    if flag_modo2 == 1
    if j > 0 
%             sprintf('Entrei j: %d', j+1)
            aux = sqrt( (xd(i,j) - xr(i,j))^2 + (yd(i,j) - yr(i,j))^2 );
        if aux > 0.1
            wr(i,j+1) = 0.0;  
            vr(i,j+1) = 0.0;
%             sprintf('i: %d, j: %d, vr: %f', i,j+1,vr(i,j+1))
        end
    end
    end

    %Parar quando for colidir (Não prioritário para)
    if flag_modo1 == 1
    %Verificando as distÂncias das posições desejadas
 for k = 1:num_robos
     for l = k:num_robos
         if l == k
             dist(k,l) = 1.0 + dist_min;
         else
            errx = xr(i,k) - xr(i,l);
            erry = yr(i,k) - yr(i,l);
            dist(k,l) = sqrt(errx^2+erry^2);
            dist(l,k) = dist(k,l);
         end
     end;
 end;
  
 %Não está para colidir
 flag = 0;
  for k = num_robos:-1:1
     for l = k:-1:1
         if dist(k,l) <= dist_min
             flag = 1;
         %sprintf('Cheguei 0');
         end
     end;
     if flag == 1
         vr(i,k) = 0.0;
         wr(i,k) = 0.0;
        % sprintf('Cheguei');
%      else
%          vr(i,k) = vr(1,k);        
%          wr(i,k) = wr(1,k);
     end
     flag = 0;    
  end;
    end
    
 end;
  
%     if i == randi(amostras,1)
%         num_robos = 3;
%     end
end;


figure;
        t = title('Problema 1 - Segunda Abordagem: vd = 0.5m/s','FontSize',24,'FontWeight','bold');
        xl = xlabel('X (metros)','FontSize',22,'FontWeight','demi');
        yl = ylabel('Y (metros)','FontSize',22,'FontWeight','demi');
for i = 1:amostras
        
    for j = 1:num_robos
        
        plot(xr(1:i,j),yr(1:i,j),'r');
        hold on;
        plot(xd(2:i-1,j),yd(2:i-1,j),'b');
        t = title('Problema 1 - Segunda Abordagem: vd = 0.5m/s','FontSize',24,'FontWeight','bold');
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
           %pause(10);
    end
    pause(0.0001);
    hold off;
end;