function mat(T,R,nome,max_linha)
close all
clc
%teste = importdata('Err_bloco1.txt');
teste = importdata(nome);
L = 0.105;
RP = 0.0287;
wd = (2*3.14)/T;
vd = wd*R;
wdr = (2*vd + wd*L)/(2*RP);
wdl = (2*vd - wd*L)/(2*RP);

dt = 0.2;
teta(1) = pi;
x(1)=0.4;
y(1)=0;

i = 1;
while(i <= max_linha)
    
    er(i) = teste(i,1);
    %rad/s
    wr(i) = (wdr - er(i));
    dtetar = wr(i)*dt;
    dr = dtetar*RP;
    
    el(i) = teste(i,2);    
    wl(i) = (wdl - el(i));
    dtetal = wl(i)*dt;
    dl = dtetal*RP;
    
    %delta real x real e y real
    x(i+1) = x(i) + (dr+dl)* cos(teta(i))/2;
    y(i+1) = y(i) + (dr+dl)* sin(teta(i))/2;
    teta(i+1) = teta(i) + (dr - dl)/L;
    
    i = i + 1;
end;

for i = 1:length(x)
    figure(1)
   
    
    plot(x(1:i),y(1:i))
    axis([-1 1 -1 1])
    axis equal
    hold on 
    plot(x(i),y(i),'r*')
    pause(0.001)
    
    hold off
end
end