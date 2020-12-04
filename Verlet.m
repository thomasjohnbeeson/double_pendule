function [t, etat] = Verlet(etat_initial,params,dt,tf)
%_____________________________________________________________
% Fonction 'Verlet' :
%
% Description :
% La fonction 'Verlet' trouve les solutions pour les accélérations angulaires (theta_dotdot) et les vitesses angulaires 
% pour un pendule double par la méthode de Verlet. Elle prend en
% entrée l'état initial du système, les paramètres du système étudié, ainsi
% que le pas de temps et la durée de simulation.
%
% Arguments d'entrée : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul (s)
% - tf : Temps de simulation (s)
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% système d'équations différentielles a été évalué, en incluant le temps 0.
% - etat : Matrice 4xn décrivant l'état du système dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] évaluée à
% tous les temps présents dans le vecteur t.

% -------------------------------------------------
% Auteur : Kevin Chau
% Date de création : 02/12/2020
% Dernière modification (v1) : 02/12/2020
% -------------------------------------------------
% _____________________________________________________________


%Initialisation 
t = 0;
etat = etat_initial;

%On calcule l'accélération initiale
accel = f(etat_initial,params);
accel = accel(3:4); % Juste les éléments 3 et 4 de la fonction f

while t(end) < tf
    v_half = etat(3:4,end) + 0.5*dt*accel;
    etat(1:2,end + 1) = etat(1:2, end) + dt*v_half; %Calcul de la position au temps t + dt
    accel = f([etat(1:2, end) ; v_half], params); %Calcul de la nouvelle accélération
    accel = accel(3:4);
    etat(3:4, end) = v_half + 0.5*dt*accel; %Calcul de la vitesse au temps t + dt
    t(end + 1) = t(end) + dt;
end
