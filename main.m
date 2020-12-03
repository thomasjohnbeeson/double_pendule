%main

clc
clear all
close all

% Définition de paramètres par défauts
l1 = 1.5 ; l2 = 1;
I1 =  0; I2 = 0;
m1 = 2 ; m2 = 2;
k1 = 0 ; k2 = 0;
g = 9.81;
tf = 1;
dt = 0.01;
global params
params = [l1,l2,I1,I2,m1,m2,k1,k2,g,tf,dt];

% Conditions initiales
global etat_initial
etat_initial = [[pi/2;pi/2;0;0],[0;0;5;0]];

% Méthodes choisies la méthode par défaut est Verlet
global methodes
methodes = [3];
% EE = 1
% EI = 2
% Verlet = 3
% RK4 = 4
% On peut sélectionne plusieurs méthodes (ex: methodes = [3 4])

% Initialisation du graphe
fig_anim = figure('Position',[10 400 700 700]);
set(fig_anim,'WindowStyle','normal');
set(fig_anim,'visible','on');

% Définition des axes de l'animation
global axes_pendules;
axes_pendules = subplot(1,2,1);
axis square; % utile pour maintenir les proportions du graphe
ax = gca;
ax.NextPlot = 'replaceChildren';

% Définition des axes
global axes_energie;
axes_energie = subplot(1,2,2);

% Initialisation des pendules
init_pendules

% On part le programme interactif de menus
menu_princ