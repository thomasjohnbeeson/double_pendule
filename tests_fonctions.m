
% PROGRAMME DE TEST SEULEMENT!!!
clc
clear all

% TEST DE LA FONCTION f.m

    % D�finition de param�tres
    l1 = 1.5 ; l2 = 2;
    I1 = 10 ; I2 = 20;
    m1 = 5 ; m2 = 2;
    k1 = 3 ; k2 = 5;
    g = 9.81;
    params = [l1,l2,I1,I2,m1,m2,k1,k2,g];

    %etat = [pi/2;pi/2;1;1];
    %tdd = f(etat,params);

    %tdd1_coup = f_coup_1(etat(1:2),etat(3:4),tdd(4),params);

    %tdd(3) - tdd1_coup;
    

% TEST DE LA FONCTION RK4

etat_initial = [pi/2;pi/2;0;0];
tf = 40;
dt = 0.01;

[t_rk4,etat_rk4] = RK4(etat_initial,params,dt,tf);
[t_ei,etat_ei] = EI(etat_initial,params,dt,tf);

% figure
% hold on
% plot(t_rk4,etat_rk4(1:2,:))
% plot(t_ei,etat_ei(1:2,:))
% legend("theta_1 RK4","theta_2 RK4","theta_1 EI","theta_2 EI")

%Cr�ation des coordonn�es dans le bon rep�re
% Ici, x est un vecteur [x;y] correspondant � la position
[x1 y1] = pol2cart(etat_rk4(1,:)+pi/2,l1);
y1 = -y1; % Il faut inverser l'axe y
[x2_rel y2_rel] = pol2cart(etat_rk4(2,:)+pi/2,l2);
% Coordonn�es x2 et y2 sont trouv�es relativement � x1,y1
x2 = x1 + x2_rel;
y2 = y1 - y2_rel;

fig = figure
hold on
%fig.Visible = 'off'
xlim([-(l1 + l2 + 1) (l1 + l2 + 1)]);
ylim([-(l1 + l2 + 1) (l1 + l2 + 1)]);
ax = gca;
ax.NextPlot = 'replaceChildren'
%vidfile = VideoWriter('video_test.mp4','MPEG-4')
%open(vidfile);

for frame = 1:length(t_rk4)
plot(ax,x1(frame),y1(frame),'ro','MarkerSize',10)
plot(ax,x2(frame),y2(frame),'bo','MarkerSize',10)
animatedline([0,x1(frame)],[0,y1(frame)],'Color','r','LineWidth',2)
animatedline([x1(frame),x2(frame)],[y1(frame),y2(frame)],'Color','b','LineWidth',2)

drawnow
pause(dt)

%M(frame) = getframe(gcf);
%writeVideo(vidfile,M(frame))
end
%close(vidfile)

%fig.Visible = 'on'
%movie(fig,M,1,1/dt)







