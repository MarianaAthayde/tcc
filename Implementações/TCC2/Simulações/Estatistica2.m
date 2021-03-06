count_com = 0;
for rpt = 1:100
num_robos = 10; %n�mero de robos do sistema
raio = 0.3; %Raio em torno do alvo - metros
periodo = 24; %Per�odo desejado
dist_min = 0.2; %Distancia m�nima de colis�o
wd = 2*pi/periodo; 
vd = wd*raio;
t_amostral = 25/1000.0;
amostras = 500;
kp = 1;
kv = 0.5;
%Posi��o do Alvo
x_alvo = 0.0;
y_alvo = 0.0;
%Posi��es Iniciais dos Robos
%Nota: [Mestre Slave1 Slave2]
for i = 1:num_robos;
    xr(1,i) = rand(1)*(-1)^(randi(2,1)); 
    yr(1,i) = rand(1)*(-1)^(randi(2,1));
    thetar(1,i) = pi;
    wr(1,i) = rand(1);
    vr(1,i) = rand(1);
end;

qnt_robos(1) = num_robos;

dist = zeros(qnt_robos(1),qnt_robos(1));

for i = 2:amostras
%Nota: [Mestre Slave1 Slave2]
qnt_robos(i) = num_robos;
for j = 0:num_robos-1
    xd(i,j+1) = x_alvo + raio*cos(i*t_amostral*wd + j*2*pi/num_robos);
    yd(i,j+1) = y_alvo + raio*sin(i*t_amostral*wd + j*2*pi/num_robos);
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
    vr(i,j+1) = vd + kv*edist;
    if j > 0 
%             sprintf('Entrei j: %d', j+1)
            aux = sqrt( (xd(i,j) - xr(i,j))^2 + (yd(i,j) - yr(i,j))^2 );
        if aux > 0.1
            wr(i,j+1) = 0.0;  
            vr(i,j+1) = 0.0;
%             sprintf('i: %d, j: %d, vr: %f', i,j+1,vr(i,j+1))
        end
    end

%Verificando as dist�ncias das posi��es desejadas
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
  
 %N�o est� para colidir
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
 end;
 
    %if i == randi(amostras,1)
     %   num_robos = 2;
    %end
end;

for i = 1:amostras
        
    for j = 1:num_robos
        
        for l = j+1:num_robos
            if xr(i,j)==xr(i,l)
                if yr(i,j)==yr(i,l)
                count_com = count_com+1;
                end;
            end;
        end;        
     
    end;
end;
end;
count_com