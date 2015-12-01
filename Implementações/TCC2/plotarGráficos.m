%Gráfico Malha Interna

malha1 = importdata('Tst_Malha1.txt');
plot(malha1(:,1),'r');
hold on;
plot(malha1(:,2),'b');
t = title('Erro da Malha 1 - P: kp=18','FontSize',24,'FontWeight','bold');
x = xlabel('Iterações','FontSize',22,'FontWeight','demi');
y = ylabel('Erro de Velocidade das Rodas (rad/s)','FontSize',22,'FontWeight','demi');
l = legend('Roda Direita','Roda Esquerda');
set(l,'FontSize',22,'FontWeight','demi');
set(gca,'FontSize',22,'FontWeight','demi');

figure;

malha1 = importdata('Tst_Malha2.txt');
plot(malha1(:,5),'r');
t = title('Erro da Malha 2 - Polinomial','FontSize',24,'FontWeight','bold');
x = xlabel('Iterações','FontSize',22,'FontWeight','demi');
y = ylabel('Erro de Theta (rad)','FontSize',22,'FontWeight','demi');
l = legend('Erro');
set(l,'FontSize',22,'FontWeight','demi');
set(gca,'FontSize',22,'FontWeight','demi');

figure;
%Gráfico Malha Externa
malha2=importdata('Tst_Malha2.txt');
for i = 1:length(malha2(:,1))
    plot(malha2(:,3),malha2(:,4),'r');	
    hold on;
    plot(malha2(i,3),malha2(i,4),'r*');
    plot(malha2(:,1),malha2(:,2),'b');
    plot(malha2(i,1),malha2(i,2),'b*');
	t = title('Teste Malha 2 - Polinomial','FontSize',24,'FontWeight','bold');
	x = xlabel('X (metros)','FontSize',22,'FontWeight','demi');
	y = ylabel('Y (metros)','FontSize',22,'FontWeight','demi');
	l = legend('Trajeto Desejado','Posição Desejada','Trajeto Real','Posição Real');
	set(l,'FontSize',22,'FontWeight','demi');
	set(gca,'FontSize',22,'FontWeight','demi');
    pause(0.01);
    hold off;
end;

%%%%%%%%%%%%%%%%%%%%%%%
 figure;
%Gráfico Malha Externa
malha2=importdata('Tst_Malha2.txt');
for i = 1:length(malha2(:,1))
    plot(malha2(1:1199,3),malha2(1:1199,4),'r');	
    hold on;
    plot(malha2(1202:length(malha2(:,1)),3),malha2(1202:length(malha2(:,1)),4),'r');
    plot(malha2(i,3),malha2(i,4),'r*');
    plot(malha2(:,1),malha2(:,2),'b');
    plot(malha2(i,1),malha2(i,2),'b*');
	t = title('Teste Malha 2 - M2: P=1.0| M1: Polinomial','FontSize',24,'FontWeight','bold');
	x = xlabel('X (metros)','FontSize',22,'FontWeight','demi');
	y = ylabel('Y (metros)','FontSize',22,'FontWeight','demi');
	l = legend('Trajeto Desejado','Posição Desejada','Trajeto Real','Posição Real');
	set(l,'FontSize',22,'FontWeight','demi');
	set(gca,'FontSize',22,'FontWeight','demi');
    pause(0.01);
    hold off;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Plotando dois - P1
figure;
pause(2);
for i = 1:88
    plot(mestre_2(:,1),mestre_2(:,2),'r');	
    hold on;
    plot(mestre_2(i,1),mestre_2(i,2),'ro');
    plot(escravo_2(:,1),escravo_2(:,2)+ 0.20,'b');
    plot(escravo_2(i,1),escravo_2(i,2)+ 0.20,'bo');
	 set(p1,'LineWidth',12);
    set(p2,'LineWidth',12);
	t = title('Problema 1 - Polinomial','FontSize',24,'FontWeight','bold');
	x = xlabel('X (metros)','FontSize',22,'FontWeight','demi');
	y = ylabel('Y (metros)','FontSize',22,'FontWeight','demi');
	%l = legend('Trajeto Mestre','Posição Mestre','Trajeto Escravo','Posição Escravo');
	%set(l,'FontSize',22,'FontWeight','demi');
	set(gca,'FontSize',22,'FontWeight','demi');
    pause(0.1);
    hold off;
end;





%P2

mestre_1 = importdata('Mestre_1.txt');
escravo_1 = importdata('Escravo_1.txt');
mestre_2 = importdata('Mestre_2.txt');
escravo_2 = importdata('Escravo_2.txt');
figure;
pause(2);
for i = 1:length(mestre_2(:,1))
    plot(mestre_2(:,1),mestre_2(:,2),'r');	
    hold on;
    plot(mestre_2(i,1),mestre_2(i,2),'r*');
    plot(escravo_2(:,1),escravo_2(:,2),'b');
	if i <= length(escravo_2(:,2))
    plot(escravo_2(i,1),escravo_2(i,2),'b*');
	end
	t = title('Problema 2 - Polinomial','FontSize',24,'FontWeight','bold');
	x = xlabel('X (metros)','FontSize',22,'FontWeight','demi');
	y = ylabel('Y (metros)','FontSize',22,'FontWeight','demi');
	%l = legend('Trajeto Mestre','Posição Mestre','Trajeto Escravo','Posição Escravo');
	%set(l,'FontSize',22,'FontWeight','demi');
	set(gca,'FontSize',22,'FontWeight','demi');
    pause(0.1);
    hold off;
end;