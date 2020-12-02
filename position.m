function [x1 y1 x2 y2] = position(etat,params)

% On extrait la valeur de l1 et l2 des paramètres satiques
l1 = params(1);
l2 = params(2);

%Création des coordonnées dans le bon repère
% Ici, x est un vecteur [x;y] correspondant à la position
[x1 y1] = pol2cart(etat(1,:)+pi/2,l1); % On décale de pi/2 car on défini l'angle de manière différente que la convention de MATLAB
y1 = -y1; % Il faut inverser l'axe y
[x2_rel y2_rel] = pol2cart(etat(2,:)+pi/2,l2);
% Coordonnées x2 et y2 sont trouvées relativement à x1,y1
x2 = x1 + x2_rel;
y2 = y1 - y2_rel; % signe négatif pour les y par convention

end