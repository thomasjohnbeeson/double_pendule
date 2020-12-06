

% _____________________________________________________________ 
% Programme 'main' :
%
% Description : 
% Ce programme est le programme central du logiciel. Il doit �tre lanc� en
% premier. Il d�fini d'abord les param�tres par d�faut (qui peuvent ensuite �tre
% modifi�s dans le GUI), initialise ensuite les figures, initialise les
% objets graphiques "pendules", puis lance ensuite l'interface utilisateur
% (GUI) � l'aide de la commande 'menu_princ'. C'est ensuite l'utilisateur
% qui d�cide de modifier les param�tres, la m�thode d'int�gration, les
% conditions initiales, et qui prend la d�cision d'animer le syst�me. Quand
% l'utilisateur s�lectionner l'option 'animer', le logiciel r�sout les
% �quations diff�rentielles 'solutionner.m' et lance l'animation.
%
% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 1/12/2020
% -------------------------------------------------
% _____________________________________________________________


%%%%%%%%%%%%%%%%%%%%%%%%% NOTE AU CORRECTEUR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Si on ne veut pas lancer le LOGICIEL INTERACTIF (GUI), et simplement modifier
% les param�tres directement dans main.m, on peut mettre la ligne 110 en
% commentaire "menu_princ"

% Pour faire la R�SOLUTION � partir des conditions initiales et de la
% m�thode choisie plus bas, simplement lancer la fonctions "solutionner"
% apr�s avoir lanc� 'main' et mis en commentaire la ligne 110 (menu_princ)
% Cette fonction se charge d'appeler EE, EI, Verlet, RK4 pour la
% r�solution, puis stocke le r�sultat dans l'objet "pendules"
% solutionner

% Pour ANIMER le pendule, on appelle ensuite la fonction "animate"
% animate

clc
clear all
close all

% D�finition de param�tres par d�fauts
l1 = 1 ; l2 = 1;
I1 =  1; I2 = 1;
m1 = 10 ; m2 = 10;
k1 = 0 ; k2 = 0;
g = 9.81;
tf = 20;
dt = 0.01;

% Activer/d�sactiver les trajectoires des pendules
trajectoires = true; 

global params
params = [l1,l2,I1,I2,m1,m2,k1,k2,g,tf,dt,trajectoires];

% Conditions initiales
global etat_initial
etat_initial = [[3*pi/4;3*pi/4;0;0],[3*pi/4;3*pi/4 + 0.0001;0;0]];

% M�thodes choisies.
global methodes
methodes = [4];
% EE = 1
% EI = 2
% Verlet = 3
% RK4 = 4
% On peut s�lectionne plusieurs m�thodes (ex: methodes = [3 4])

% Initialisation du graphe
%fig_anim = figure('Position',[10 250 1000 450]);
fig_anim = figure('Units', 'normalized', 'Position', [0, 0.4, 0.9, 0.6]);
set(fig_anim,'WindowStyle','normal');
set(fig_anim,'visible','on');

% D�finition des axes de l'animation
global axes_pendules;
axes_pendules = subplot(2,2,[1,3]);
axis square; % utile pour maintenir les proportions du graphe
ax.NextPlot = 'replaceChildren';
title("Double Pendule")
xlabel("x (m)")
ylabel("y (m)")

% D�finition des axes
global axes_energie;
axes_energie = subplot(2,2,2);
title("�nergie")
xlabel("Temps (s)")
ylabel("�nergie (J)")

global axes_position;
axes_position = subplot(2,2,4);
ax.NextPlot = 'replaceChildren';
title("Position y2")
xlabel("t (s)")
ylabel("y (m)")

% Initialisation des pendules
init_pendules 

% On peut ensuite simplement appeler les fonctions 'solutionner' et 'animate' 
% pour voir le r�sultat, au lieu de partir le GUI
% solutionner
% animate

% On part le programme interactif de menus (GUI) (Optionnel)
menu_princ
