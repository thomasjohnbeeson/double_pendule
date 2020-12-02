function [t, etat] = EE(etat_initial,params,dt,tf)
%_____________________________________________________________
% Fonction 'EE' :
%
% Description :
% La fonction 'EE' trouve les solutions pour les acc�l�rations angulaires (theta_dotdot) et les vitesses angulaires 
% pour un pendule double par la m�thode d'Euler explicite. Elle prend en
% entr�e l'�tat initial du syst�me, les param�tres du syst�me �tudi�, ainsi
% que le pas de temps et la dur�e de simulation.
%
% Arguments d'entr�e : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul (s)
% - tf : Temps de simulation (s)
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% syst�me d'�quations diff�rentielles a �t� �valu�, en incluant le temps 0.
% - etat : Matrice 4xn d�crivant l'�tat du syst�me dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] �valu�e �
% tous les temps pr�sents dans le vecteur t.

% -------------------------------------------------
% Auteur : Kevin Chau
% Date de cr�ation : 02/12/2020
% Derni�re modification (v1) : 02/12/2020
% -------------------------------------------------
% _____________________________________________________________

%On initialise les variables
t = 0;
etat = etat_initial;

%On applique la suite de r�currence pendant la dur�e souhait�e de la
%simulation
while t < tf
    etat(:,end + 1) = etat(:,end) + dt*f(etat(:,end),params);
    t(end + 1) = t(end) + dt;
end
end