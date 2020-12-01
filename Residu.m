function [R] = Residu(x_tdt,x_t,dt,params)
% _____________________________________________________________ 
% Fonction 'Residu' :
%
% Description : 
% Cette fonction calcule l'expression R = x_t+dt - dt*f(x_t) - x_t, pour
% des valeurs de x aux temps t et t+dt, et une fonction f(x) qui évalue la
% dérivée temporelle du vecteur x.
% Cette valeur correspond au résidu d'une équation non-linéaire, comme
% celle qui apparaît dans la méthode de résolution d'équations
% différentielles par Euler Implicite.
%
% Arguments d'entrée : 
% - x_tdt : Vecteur colonne 4x1 contenant les
% valeurs au temps t+dt des deux angles et des deux vitesses telles que 
% x_tdt = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - x_t : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% x_t = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
%
% Arguments de sortie : 
% - R : Vecteur colonne 4x1 du résidu.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

R = x_tdt - dt*f(x_tdt,params) - x_t;

end