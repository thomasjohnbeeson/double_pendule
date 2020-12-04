function [t,etat] = EI(etat_initial,params,dt,tf)
% _____________________________________________________________ 
% Fonction 'EI' :
%
% Description : 
% Cette fonction utilise la m�thode de Euler implicite pour 
% r�soudre le syst�me d'�quations diff�rentielles dy/dt = f(t,y) sur une
% p�riode de temps [0;tf]. Les 4 �quations diff�rentielles qui composent
% dy/dt sont les vitesses angulaires theta_dot_1 et theta_dot_2, ainsi que
% les acc�l�rations angulaires theta_dotdot_1 et theta_dotdot_2.
% La fonction utilise la m�thode Newton-Raphson avec une Jacobienne 
% num�rique pour r�soudre les �quations non-lin�aires provenant de la forme
% en diff�rences finies implicites.
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
% Arguments de sortie : 
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

% On defini ensuite les param�tres de r�solution d'�quations non-lin�aires
% par newton-Raphson
N = 1000; % Nombre d'it�rations maximales pour r�soudre une �quation non-lin�aire
tol = 1e-7; % Pr�cision vis�e par la r�solution non-lin�aire

% Boucle de r�solution des �quations diff�rentielles
while t(end) < tf
    
    % D�but de la r�solution du syt�me d'�quations non-lin�aire de
    % diff�rences finies par la m�thode de Newton-Raphson
    dx = 1; % Vecteur de correction dx initialis� comme = 1
    it = 0; % Compteur d'it�rations
    xi = etat(:,end);
    if any(xi == 0) % Cette condition assure que les estim�s initiaux ne comportent pas de z�ros, ce qui cr�e des erreurs dans la jacobienne
        x = xi + 0.01*ones(4,1);
    else
        x = xi;
    end
    % Boucle de r�solution non-lin�aire
    while norm(dx) > tol && it < N
        R = Residu(x,xi,dt,params);
        J = Jac(x,xi,dt,params,tol);
        dx = J\-R;
        x = x + dx;
        it = it+1;
    end    
    % Stockage des valeurs trouv�es par Newton-Raphson
    etat(:,end+1) = x;
    t(end+1) = t(end) + dt;
    
end

end
    
    
    
    
    
    
