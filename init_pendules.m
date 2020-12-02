function init_pendules

% On acc�de d'abord aux variables globales
global params
global etat_initial
global methodes

% On supprime ensuite les anciens objets du graphe
obj_a_supr = findobj(gca, 'Type', 'line');
if ~isempty(obj_a_supr)
    delete(obj_a_supr);
end
  
% On met ensuite � jour les axes du graphe pour les nouvelles dimensions
xlim([-(params(1) + params(2) + 1) (params(1) + params(2) + 1)]);
ylim([-(params(1) + params(2) + 1) (params(1) + params(2) + 1)]);

% On d�fini la variable pendules qui contient l'information sur les
% pendules (objet graphique, solution, couleur, etc)
global pendules
pendules = {};
 
% On remplit ensuite la variable "pendules" en ordre de m�thode, puis de
% conditions initiales
couleurs = {'r' 'g' 'b' 'm' 'c' 'w' 'k'}; % Couleurs possibles pour le pendule
compteur = 0;
for ci = 1:size(etat_initial,2)
    % On d�fini d'abord les positions cart�siennes de d�part
    [x1 y1 x2 y2] = position(etat_initial(:,ci),params);
    for met = methodes
        compteur = compteur + 1;
        if compteur <= length(couleurs) % On ne veut pas d�passer le nombre d'�l�ments de couleur permis
            col = couleurs{compteur};
        else
            col = 'k'; % Si il ne reste plus de couleurs, on prend noir
        end
        obj = def_pendule(x1(1),y1(1),x2(1),y2(1),col);
        pendules{end+1} = {obj;[x1];[y1];[x2];[y2];met;ci;col};% Structure de donn�es qui contient toute l'information sur les objets pendules (graphique + poistion)
    end
end
legend(pendules{1,:}{1}(1))
end
