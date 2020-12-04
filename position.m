%_____________________________________________________________
% Fonction 'position' :
%
% Description :
% Cette fonction retourne les vecteurs cart�siens x1,y1,x2,y2 pour un
% pendule, � partir de l'�tat [theta_1 ; theta_2 ; theta_dot_1 ;
% theta_dot_2].
% Cette fonction est utile pour transformer la solution de dy/dt = y en
% coordonn�es faciles � animer
%
% Arguments d'entr�e : 
% - etat : Matrice colonne 4xn contenant les
% valeurs  des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% syst�me d'�quations diff�rentielles a �t� �valu�, en incluant le temps 0.
% - etat : Matrice 4xn d�crivant l'�tat du syst�me dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] �valu�e �
% tous les temps pr�sents dans le vecteur t.

% -------------------------------------------------
% Auteur : Thomas John Beeson
% Date de cr�ation : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________
function [x1 y1 x2 y2] = position(etat,params)

% On extrait la valeur de l1 et l2 des param�tres satiques
l1 = params(1);
l2 = params(2);

%Cr�ation des coordonn�es dans le bon rep�re
% Ici, x est un vecteur [x;y] correspondant � la position
[x1 y1] = pol2cart(etat(1,:)-pi/2,l1); % On d�cale de -pi/2 car on d�fini l'angle de mani�re diff�rente que la convention de MATLAB
y1 = y1; % Il faut inverser l'axe y
% Coordonn�es relatives de y
[x2_rel y2_rel] = pol2cart(etat(2,:)-pi/2,l2);
% Coordonn�es x2 et y2 sont trouv�es relativement � x1,y1
x2 = x1 + x2_rel;
y2 = y1 + y2_rel; 

end