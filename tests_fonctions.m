
% PROGRAMME DE TEST SEULEMENT!!!
clc
clear all
close all

% TEST DE LA FONCTION f.m

    % Définition de paramètres
    l1 = 1.5 ; l2 = 1;
    I1 = 1 ; I2 = 0;
    m1 = 2 ; m2 = 2;
    k1 = 1 ; k2 = 0.1;
    g = 9.81;
    params = [l1,l2,I1,I2,m1,m2,k1,k2,g];

    %etat = [pi/2;pi/2;1;1];
    %tdd = f(etat,params);

    %tdd1_coup = f_coup_1(etat(1:2),etat(3:4),tdd(4),params);

    %tdd(3) - tdd1_coup;
    

% TEST DE LA FONCTION RK4

etat_initial = [pi/2;pi/2;0;0];
tf = 30;
dt = 0.01;

[t_rk4,etat_rk4] = RK4(etat_initial,params,dt,tf);
[t_ei,etat_ei] = EI(etat_initial,params,dt,tf);
% On crée une structure de donnees solution qui contient la solution aux équations
% différentielles pour chaque méthode. On peut donc fournir cette fonction
% comme argument aux fonctions de position et d'animation, peu importe sa
% longueur (donc le nombre de pendules à animer)
%solutions = {{t_rk4;etat_rk4}};
solutions = {{t_rk4;etat_rk4},{t_ei;etat_ei}};

% DONNEES SUR LA FIGURE
fig = figure
hold on
% Définition des axes de la figure
xlim([-(l1 + l2 + 1) (l1 + l2 + 1)]);
ylim([-(l1 + l2 + 1) (l1 + l2 + 1)]);
axis square % utile pour maintenir les proportions du graphe
ax = gca;
ax.NextPlot = 'replaceChildren'

% Bloc de définition et animation des pendules
enregistrement = false;
pendules = {};
couleurs = {'r' 'g' 'b' 'm' 'c' 'w' 'k'};
for config = 1:size(solutions,2)
    [x1 y1 x2 y2] = position(solutions{config}{2},params);
    obj = def_pendule(x1(1),y1(1),x2(1),y2(1),couleurs{config})
    pendules{end+1} = {obj;x1;y1;x2;y2}; % Structure de données qui contient toute l'information sur les objets penules (graphique + poistion)
end

animate(pendules,dt,enregistrement)

%vidfile = VideoWriter('video_test.mp4','MPEG-4')
%open(vidfile);


%for frame = 1:length(x1)
%     set(pendule_obj(1),'XData',[0,x1(frame)],'YData',[0 y1(frame)])
%     set(pendule_obj(2),'XData',[x1(frame),x2(frame)],'YData',[y1(frame),y2(frame)])
%     set(pendule_obj(3),'XData',x1(frame),'YData',y1(frame))
%     set(pendule_obj(4),'XData',x2(frame),'YData',y2(frame))
%     
%     drawnow
%     pause(dt)
    
    
%     if isempty(obj_graphe)
%         obj_graphe = [line([0,x1(frame)],[0 y1(frame)],'LineStyle','-','Color','r','LineWidth',2) , ... % Tige 1
%                       line([x1(frame),x2(frame)],[y1(frame),y2(frame)],'LineStyle','-','Color','b','LineWidth',2) , ... % tige 2
%                       line(x1(frame),y1(frame),'Marker','.','LineStyle','none','Color','r','MarkerSize',30) , ...
%                       line(x1(frame),y1(frame),'Marker','.','LineStyle','none','Color','b','MarkerSize',30)] % Masse 1
%     else
%         set(obj_graphe(1),'XData',[0,x1(frame)],'YData',[0 y1(frame)])
%         set(obj_graphe(2),'XData',[x1(frame),x2(frame)],'YData',[y1(frame),y2(frame)])
%         set(obj_graphe(3),'XData',x1(frame),'YData',y1(frame))
%     end
%     if isempty(obj_graphe)
%         obj_graphe = plot(x1(frame),y1(frame),'ro',... % Masse 1
%                           x2(frame),y2(frame),'bo',... % Masse 2
%                           [0,x1(frame)],[0 y1(frame)],'r-',... % Tige 1
%                           [x1(frame),x2(frame)],[y1(frame),y2(frame)],'b-',... % tige 2
%                           'MarkerSize',10,...
%                           'LineWidth',2)
%     else
%         set(obj_graphe(1),'XData',x1(frame),'YData',y1(frame))
%         set(obj_graphe(2),'XData',x2(frame),'YData',y2(frame))
%         set(obj_graphe(3),'XData',[0,x1(frame)],'YData',[0 y1(frame)])
%         set(obj_graphe(4),'XData',[x1(frame),x2(frame)],'YData',[y1(frame),y2(frame)])
%     end
%     if isempty(tiges)
%         tiges = plot([0,x1(frame)],[0 y1(frame)],'r-',[x1(frame) x2(frame)],[y1(frame) y2(frame)],'b-','LineWidth',2)
%     else
%         set(tiges,'XData',[[0,x1(frame)],[x1(frame),x2(frame)]],'YData',[[0,y1(frame)],[y1(frame),y2(frame)]])
%     end
%animatedline([0,x1(frame)],[0,y1(frame)],'Color','r','LineWidth',2)
%animatedline([x1(frame),x2(frame)],[y1(frame),y2(frame)],'Color','b','LineWidth',2)


%M(frame) = getframe(gcf);
%writeVideo(vidfile,M(frame))
%end
%close(vidfile)

%fig.Visible = 'on'
%movie(fig,M,1,1/dt)







