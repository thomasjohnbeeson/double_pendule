% _____________________________________________________________ 
% Fonction 'solutionner' :
%
% Description : 
% Cette fonction sans arguments est la fonction CENTRALE de la r�solution.
% Elle utilise la m�thode sp�cifi�e dans chaque objet "pendules" pour
% trouver la SOLUTION � l'aide d'une des 4 m�thodes: EE ; EI ; Verlet ; RK4
% Elle stocke ensuite les coordonn�es cart�siennes correspondantes
% (en utilisant la fonction "position"), ainsi que l'�nergie � chaque
% instant (en utilisant la fonction "�nergie") dans les objets "pendules"
% qui seront ensuite anim�s.
% Il est n�cessaire de d�finir les param�tres et les graphes ("main.m")
% ainsi que d'initialiser les pendules (init_pendules) avant d'utiliser
% cette fonction.
%
% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________
function solutionner

%  Variables globales
global pendules
global params
global etat_initial
global axes_energie

% Cette boucle solutionne chaque pendule un par un selon la m�thode choisie
% ,puis place les coordonn�es cart�siennes, les valeurs d'angles/vitesse angulaire
% et l'�nergie dans l'objet "pendules", qui sera anim� ensuite.

for i = 1:size(pendules,2)
            switch pendules{i}{6} % Cet �l�ment de "pendules" contient la m�thode d'int�gration
                case "EE" % Ce pendule utilise EE
                    [t, sol] = EE(etat_initial(:,pendules{i}{7}),params,params(11),params(10));
                    pendules{i}{9} = sol(1,:);pendules{i}{10} = sol(2,:);pendules{i}{11} = sol(3,:);pendules{i}{12} = sol(4,:);
                    [x1 y1 x2 y2] = position(sol,params);
                    pendules{i}{2} = x1 ; pendules{i}{3} = y1 ; pendules{i}{4} = x2 ; pendules{i}{5} = y2 ; % On stocke les solutions dans les objets pendules
                    pendules{i}{13} = t;% On stocke le temps
                    pendules{i}{14} = Energie(sol,params,t);% On stocke l'�nergie
                
                case "EI" % Ce pendule utilise EI
                    [t, sol] = EI(etat_initial(:,pendules{i}{7}),params,params(11),params(10));
                    pendules{i}{9} = sol(1,:);pendules{i}{10} = sol(2,:);pendules{i}{11} = sol(3,:);pendules{i}{12} = sol(4,:);
                    [x1 y1 x2 y2] = position(sol,params);
                    pendules{i}{2} = x1 ; pendules{i}{3} = y1 ; pendules{i}{4} = x2 ; pendules{i}{5} = y2 ; % On stocke les solutions dans les objets pendules
                    pendules{i}{13} = t;% On stocke le temps
                    pendules{i}{14} = Energie(sol,params,t);% On stocke l'�nergie
                
                case "Verlet" % Ce pendule utilise Verlet
                    [t, sol] = Verlet(etat_initial(:,pendules{i}{7}),params,params(11),params(10));
                    pendules{i}{9} = sol(1,:);pendules{i}{10} = sol(2,:);pendules{i}{11} = sol(3,:);pendules{i}{12} = sol(4,:);
                    [x1 y1 x2 y2] = position(sol,params);
                    pendules{i}{2} = x1 ; pendules{i}{3} = y1 ; pendules{i}{4} = x2 ; pendules{i}{5} = y2 ; % On stocke les solutions dans les objets pendules
                    pendules{i}{13} = t;% On stocke le temps
                    pendules{i}{14} = Energie(sol,params,t);% On stocke l'�nergie
                
                case "RK4" % Ce pendule utilise RK4
                    [t, sol] = RK4(etat_initial(:,pendules{i}{7}),params,params(11),params(10));
                    pendules{i}{9} = sol(1,:);pendules{i}{10} = sol(2,:);pendules{i}{11} = sol(3,:);pendules{i}{12} = sol(4,:);
                    [x1 y1 x2 y2] = position(sol,params);
                    pendules{i}{2} = x1 ; pendules{i}{3} = y1 ; pendules{i}{4} = x2 ; pendules{i}{5} = y2 ; % On stocke les solutions dans les objets pendules
                    pendules{i}{13} = t; % On stocke le temps
                    pendules{i}{14} = Energie(sol,params,t);% On stocke l'�nergie
            end
            
end

% On doit red�finir les axes du graphe de l'�nergie pour s'assurer que la
% courbe d'�nergie demeure visible!
energ = zeros(2,size(pendules,2));
% On trouve les valeurs extr�mes d'�nergie parmi les conditions initiales pr�sentes
for obj = 1:length(pendules)
    energ(1,obj) = max(pendules{obj}{14});
    energ(2,obj) = min(pendules{obj}{14});
end
ylim(axes_energie,[min(energ(2,:))-10 max(energ(1,:))+10]);

end