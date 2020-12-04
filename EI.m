function [t,etat] = EI(etat_initial,params,dt,tf)
% _____________________________________________________________ 
% Fonction 'EI' :
%
% Description : 
% Cette fonction utilise la méthode de Euler implicite pour 
% résoudre le système d'équations différentielles dy/dt = f(t,y) sur une
% période de temps [0;tf]. Les 4 équations différentielles qui composent
% dy/dt sont les vitesses angulaires theta_dot_1 et theta_dot_2, ainsi que
% les accélérations angulaires theta_dotdot_1 et theta_dotdot_2.
% La fonction utilise la méthode Newton-Raphson avec une Jacobienne 
% numérique pour résoudre les équations non-linéaires provenant de la forme
% en différences finies implicites.
%
% Arguments d'entrée : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
% - tf : Temps de simulation
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% système d'équations différentielles a été évalué, en incluant le temps 0.
% - etat : Matrice 4xn décrivant l'état du système dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] évaluée à
% tous les temps présents dans le vecteur t.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________


% On défini d'abord les conditions initiales
t = [0];
etat = [etat_initial];

% On defini ensuite les paramètres de résolution d'équations non-linéaires
% par newton-Raphson
N = 1000; % Nombre d'itérations maximales pour résoudre une équation non-linéaire
tol = 1e-7; % Précision visée par la résolution non-linéaire

% Boucle de résolution des équations différentielles
while t(end) < tf
    
    % Début de la résolution du sytème d'équations non-linéaire de
    % différences finies par la méthode de Newton-Raphson
    dx = 1; % Vecteur de correction dx initialisé comme = 1
    it = 0; % Compteur d'itérations
    xi = etat(:,end);
    if any(xi == 0) % Cette condition assure que les estimés initiaux ne comportent pas de zéros, ce qui crée des erreurs dans la jacobienne
        x = xi + 0.01*ones(4,1);
    else
        x = xi;
    end
    % Boucle de résolution non-linéaire
    while norm(dx) > tol && it < N
        R = Residu(x,xi,dt,params);
        J = Jac(x,xi,dt,params,tol);
        dx = J\-R;
        x = x + dx;
        it = it+1;
    end    
    % Stockage des valeurs trouvées par Newton-Raphson
    etat(:,end+1) = x;
    t(end+1) = t(end) + dt;
    
end

end
    
    
    
    
    
    
