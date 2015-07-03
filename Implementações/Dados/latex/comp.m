function comp(T,R,max_linha,teste,testePI)
close all
clc

%plot(teste(:,1),'r');
%hold on;
%plot(teste(:,2),'r*');
%hold on;
%plot(testePI(:,1),'b');
%hold on;
%plot(testePI(:,2),'b*');

%figure;

L = 0.105;
RP = 0.0287;
wd = (2*3.14)/T;
vd = wd*R;
wdr = (2*vd + wd*L)/(2*RP);
wdl = (2*vd - wd*L)/(2*RP);

dt = 0.2;
teta(1) = 0;
x(1)=0;
y(1)=0;

tetaPI(1) = 0;
xPI(1)=0;
yPI(1)=0;

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
    
    %comparação testePI
     erPI(i) = testePI(i,1);
    %rad/s
    wrPI(i) = (wdr - erPI(i));
    dtetarPI = wrPI(i)*dt;
    drPI = dtetarPI*RP;
    
    elPI(i) = testePI(i,2);    
    wlPI(i) = (wdl - elPI(i));
    dtetalPI = wlPI(i)*dt;
    dlPI = dtetalPI*RP;
    
    %delta real x real e y real
    xPI(i+1) = xPI(i) + (drPI+dlPI)* cos(tetaPI(i))/2;
    yPI(i+1) = yPI(i) + (drPI+dlPI)* sin(tetaPI(i))/2;
    tetaPI(i+1) = tetaPI(i) + (drPI - dlPI)/L;
    
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
    
    hold on;
    plot(xPI(1:i),yPI(1:i))
    axis([-1 1 -1 1])
    axis equal
    hold on 
    plot(xPI(i),yPI(i),'b*')
    pause(0.001)
    
    hold off
end
end