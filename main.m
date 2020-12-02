%main

clc
clear all
close all

% Définition de paramètres
l1 = 1.5 ; l2 = 1;
I1 =  0; I2 = 0;
m1 = 2 ; m2 = 2;
k1 = 0 ; k2 = 0;
g = 9.81;
tf = 30;
dt = 0.001;
global params
params = [l1,l2,I1,I2,m1,m2,k1,k2,g,tf,dt];

% Conditions initiales
global etat_initial
etat_initial = [pi/2;pi/2;0;0];

% Méthodes choisies
global methodes
methodes = [3]; % La méthode par défaut est Verlet
% EE = 1
% EI = 2
% Verlet = 3
% RK4 = 4
% On peut sélectionne plusieurs méthodes (ex: methodes = [3 4])

% Initialisation du graphe
fig = figure
set(fig,'WindowStyle','normal')
hold on
% Définition des axes de la figure
axis square % utile pour maintenir les proportions du graphe
ax = gca;
ax.NextPlot = 'replaceChildren'

% Initialisation des pendules
init_pendules
% nbconfig = 1;
% global pendules
% pendules = {};
% couleurs = {'r' 'g' 'b' 'm' 'c' 'w' 'k'};
% for config = 1:nbconfig
%     [x1 y1 x2 y2] = position(etat_initial,params);
%     obj = def_pendule(x1(1),y1(1),x2(1),y2(1),couleurs{config});
%     pendules{end+1} = {obj;[x1];[y1];[x2];[y2]}; % Structure de données qui contient toute l'information sur les objets pendules (graphique + poistion)
% end

% On part le programme interactif de menus
menu_princ