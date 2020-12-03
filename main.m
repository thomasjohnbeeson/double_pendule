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
tf = 3;
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
fig = figure;
set(fig,'WindowStyle','normal');
set(fig,'visible','on');
hold on
% Définition des axes de la figure
axis square; % utile pour maintenir les proportions du graphe
ax = gca;
ax.NextPlot = 'replaceChildren';

% Initialisation des pendules
init_pendules

% On part le programme interactif de menus
menu_princ