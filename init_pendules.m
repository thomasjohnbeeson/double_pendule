function init_pendules

% On acc�de d'abord aux variables globales
global params
global etat_initial
global methodes
global axes_pendules
global axes_energie

% On supprime ensuite les anciennes lignes du graphe
obj_a_supr = [findobj(axes_pendules, 'Type', 'line');findobj(axes_pendules, 'Type', 'AnimatedLine');findobj(axes_energie, 'Type', 'AnimatedLine')];
if ~isempty(obj_a_supr)
    delete(obj_a_supr);
end
  
% On met ensuite � jour les axes du graphe pour les nouvelles dimensions
xlim(axes_pendules,[-(params(1) + params(2) + 1) (params(1) + params(2) + 1)]);
ylim(axes_pendules,[-(params(1) + params(2) + 1) (params(1) + params(2) + 1)]);
xlim(axes_energie,[0 params(10)]);
% Pour d�finir les limites de l'axe y, on doit trouver l'�nergie initiale
% du syst�me
energ_init = zeros(1,size(etat_initial,2));
for i = 1:size(etat_initial,2) % On trouve la valeur maximale d'�nergie parmi les conditions initiales pr�sentes
    energ_init(i) = Energie(etat_initial(:,i),params,0);
end
ylim(axes_energie,[-0.1*(max(energ_init)) max(energ_init) + 0.1*(max(energ_init))]);

% On d�fini la variable pendules qui contient l'information sur les
% pendules (objet graphique, solution, couleur, etc)
global pendules
pendules = {};
 
% On remplit ensuite la variable "pendules" en ordre de m�thode, puis de
% conditions initiales
couleurs = {'r' 'g' 'b' 'm' 'c' 'w' 'k'}; % Couleurs possibles pour le pendule

% �l�ments de la l�gende
lgd_labels = strings([1 size(etat_initial,2)*size(methodes,2)]);
lgd_elements = [];

% On initialise un compteur
compteur = 0;
for ci = 1:size(etat_initial,2)
    % On d�fini d'abord les positions cart�siennes de d�part
    [x1 y1 x2 y2] = position(etat_initial(:,ci),params);
    for met_num = methodes
        % On it�re la valeur du compteur
        compteur = compteur + 1;
        % On d�fini le nom de m�thode � afficher dans la l�gende
        switch met_num
            case 1
                met = 'EE';
            case 2
                met = 'EI';
            case 3
                met = 'Verlet';
            case 4
                met = 'RK4';
        end
        
        if compteur <= length(couleurs) % On ne veut pas d�passer le nombre d'�l�ments de couleur permis
            col = couleurs{compteur};
        else
            col = 'k'; % Si il ne reste plus de couleurs, on prend noir
        end
        obj = def_pendule(x1(1),y1(1),x2(1),y2(1),col);
        pendules{end+1} = {obj;[x1];[y1];[x2];[y2];met;ci;col;[];[];[];[];[];[]};% Structure de donn�es qui contient toute l'information sur les objets pendules (graphique + poistion)
        lgd_labels(compteur) = [met ' CI ' num2str(ci)]; % Nom du pendule dans la l�gende
        lgd_elements(end+1) = pendules{end}{1}(1); % On marque la premi�re tige dans la l�gende
        
    end
end
legend(axes_pendules,lgd_elements,lgd_labels)
legend(axes_energie,lgd_elements,lgd_labels)
end
