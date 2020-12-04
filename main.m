

%%%%%%%%%%%%%%%%%%%%%% NOTE AU CORRECTEUR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Si on ne veut pas lancer le LOGICIEL INTERACTIF (GUI), et simplement modifier
% les paramètres directement dans main.m, on peut mettre la ligne 66 en
% commentaire "menu_princ"

% Pour faire la RÉSOLUTION à partir des conditions initiales et de la
% méthode choisie plus bas, simplement lancer la fonctions "solutionner"
% Cette fonction se charge d'appeler EE, EI, Verlet, RK4 pour la
% résolution, puis stocke le résultat dans l'objet "pendules"
% solutionner

% Pour ANIMER le pendule, on appelle la fonction "animate"
% animate

clc
clear all
close all

% Définition de paramètres par défauts
l1 = 0.5 ; l2 = 4;
I1 =  0; I2 = 0;
m1 = 10 ; m2 = 10;
k1 = 0 ; k2 = 0;
g = 9.81;
tf = 60;
dt = 0.01;

% Activer/désactiver les trajectoires des pendules
trajectoires = false; 
global params
params = [l1,l2,I1,I2,m1,m2,k1,k2,g,tf,dt,trajectoires];

% Conditions initiales
global etat_initial
etat_initial = [[3*pi/4;pi;0;0]];

% Méthodes choisies.
global methodes
methodes = [4];
% EE = 1
% EI = 2
% Verlet = 3
% RK4 = 4
% On peut sélectionne plusieurs méthodes (ex: methodes = [3 4])

% Initialisation du graphe
%fig_anim = figure('Position',[10 250 1000 450]);
fig_anim = figure('Units', 'normalized', 'Position', [0, 0.4, 0.9, 0.6]);
set(fig_anim,'WindowStyle','normal');
set(fig_anim,'visible','on');

% Définition des axes de l'animation
global axes_pendules;
axes_pendules = subplot(1,2,1);
axis square; % utile pour maintenir les proportions du graphe
ax.NextPlot = 'replaceChildren';
title("Double Pendule")
xlabel("x (m)")
ylabel("y (m)")

% Définition des axes
global axes_energie;
axes_energie = subplot(1,2,2);
axis square
title("Énergie")
xlabel("Temps (s)")
ylabel("Énergie (J)")

% Initialisation des pendules
init_pendules 

% On peut ensuite simplement appeler les fonctions 'solutionner' et 'animate' 
% pour voir le résultat, au lieu de partir le GUI
% solutionner
% animate

% On part le programme interactif de menus (GUI) (Optionnel)
menu_princ
