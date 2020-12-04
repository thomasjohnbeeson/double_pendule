%_____________________________________________________________
% Fonction 'position' :
%
% Description :
% Cette fonction retourne les vecteurs cartésiens x1,y1,x2,y2 pour un
% pendule, à partir de l'état [theta_1 ; theta_2 ; theta_dot_1 ;
% theta_dot_2].
% Cette fonction est utile pour transformer la solution de dy/dt = y en
% coordonnées faciles à animer
%
% Arguments d'entrée : 
% - etat : Matrice colonne 4xn contenant les
% valeurs  des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% système d'équations différentielles a été évalué, en incluant le temps 0.
% - etat : Matrice 4xn décrivant l'état du système dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] évaluée à
% tous les temps présents dans le vecteur t.

% -------------------------------------------------
% Auteur : Thomas John Beeson
% Date de création : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________
function [x1 y1 x2 y2] = position(etat,params)

% On extrait la valeur de l1 et l2 des paramètres satiques
l1 = params(1);
l2 = params(2);

%Création des coordonnées dans le bon repère
% Ici, x est un vecteur [x;y] correspondant à la position
[x1 y1] = pol2cart(etat(1,:)-pi/2,l1); % On décale de -pi/2 car on défini l'angle de manière différente que la convention de MATLAB
y1 = y1; % Il faut inverser l'axe y
% Coordonnées relatives de y
[x2_rel y2_rel] = pol2cart(etat(2,:)-pi/2,l2);
% Coordonnées x2 et y2 sont trouvées relativement à x1,y1
x2 = x1 + x2_rel;
y2 = y1 + y2_rel; 

end