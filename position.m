function [x1 y1 x2 y2] = position(etat,params)

% On extrait la valeur de l1 et l2 des param�tres satiques
l1 = params(1);
l2 = params(2);

%Cr�ation des coordonn�es dans le bon rep�re
% Ici, x est un vecteur [x;y] correspondant � la position
[x1 y1] = pol2cart(etat(1,:)+pi/2,l1); % On d�cale de pi/2 car on d�fini l'angle de mani�re diff�rente que la convention de MATLAB
y1 = -y1; % Il faut inverser l'axe y
[x2_rel y2_rel] = pol2cart(etat(2,:)+pi/2,l2);
% Coordonn�es x2 et y2 sont trouv�es relativement � x1,y1
x2 = x1 + x2_rel;
y2 = y1 - y2_rel; % signe n�gatif pour les y par convention

end