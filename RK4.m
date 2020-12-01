function [t,etat] = RK4(etat_initial,params,dt,tf)
% _____________________________________________________________ 
% Fonction 'RK4' :
%
% Description : 
% Cette fonction utilise la m�thode de Runge Kutta 4 explicite pour 
% r�soudre le syst�me d'�quations diff�rentielles dy/dt = f(t,y) sur une
% p�riode de temps [0;tf]. Les 4 �quations diff�rentielles qui composent
% dy/dt sont les vitesses angualaires theta_dot_1 et theta_dot_2, ainsi que
% les acc�l�rations angulaires theta_dotdot_1 et theta_dotdot_2.
%
% Arguments d'entr�e : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
% - tf : Temps de simulation
%
% Argument de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% syst�me d'�quations diff�rentielles a �t� �valu�, en incluant le temps 0.
% - etat : Matrice 4xn d�crivant l'�tat du syst�me dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] �valu�e �
% tous les temps pr�sents dans le vecteur t.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

% On d�fini d'abord les conditions initiales
t = [0];
etat = [etat_initial];

% Boucle de resolution
while t(end) < tf
    k1 = dt*f(etat(:,end),params); % Pertinent de noter que f ne d�pend pas de t -> f(y)
    k2 = dt*f(etat(:,end) + k1/2 , params);
    k3 = dt*f(etat(:,end) + k2/2 , params);
    k4 = dt*f(etat(:,end) + k3 , params);
    etat(:,end+1) = etat(:,end) + (k1 + 2*k2 + 2*k3 + k4)/6;
    t(end+1) = t(end) + dt;
end

end