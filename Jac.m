function [J] = Jac(x_tdt,x_t,dt,params,tol)
% _____________________________________________________________ 
% Fonction 'Jac' :
%
% Description : 
% Cette fonction calcule la Jacobienne numérique d'une équation
% non-linéaire, comme utilisée dans la méthode de résolution
% Newton-Raphson. Pour estimer la jacobienne, on utilise un vecteur
% perturbé.
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
% - tol : Tolérance, valeur très petite utilisée comme perturbation pour le
% calcul de la Jacobienne numérique.
%
% Arguments de sortie : 
% - J : Matrice Jacobienne 4x4.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

%Initialisatiuon de la Jacobienne
J = zeros(length(x_t));
for i = 1:length(x_t)
    % Calcul du vecteur perturbé
    etat_perturb = x_tdt;
    etat_perturb(i) = etat_perturb(i) + etat_perturb(i)*tol;
    
    % Remplissage de la Jacobienne numérique
    J(:,i) = (Residu(etat_perturb,x_t,dt,params) - Residu(x_tdt,x_t,dt,params))/(x_tdt(i)*tol);
end

end
    

