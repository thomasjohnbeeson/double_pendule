function change_param(name,index,prev)
global params
global pendules
global etat_initial
clc
fprintf(['La valeur actuelle de ' name ' est ' num2str(params(index)) '\n'])
val = str2num(input('Veuillez choisir une nouvelle valeur : ','s'));
if ~isempty(val)
    params(index) = val;
    
    if index == 1 | index == 2 % Si on change une des valeurs de l, on veut aussi mettre � jour le graphe
        init_pendules
%         % On met d'abord � jour les axes du grahe pour les nouvelles dimensions
%         xlim([-(params(1) + params(2) + 1) (params(1) + params(2) + 1)]);
%         ylim([-(params(1) + params(2) + 1) (params(1) + params(2) + 1)]);
%         
%         for obj = 1:size(pendules,2) % On veut s�lectionner tous les pendules � animer
%             % On recalcule d'abord les conditions de d�part
%             [x1 y1 x2 y2] = position(etat_initial,params);
%             pendules{obj}{2}(1) = x1;
%             pendules{obj}{3}(1) = y1;
%             pendules{obj}{4}(1) = x2;
%             pendules{obj}{5}(1) = y2;
%             % On met ensuite � jour le graphe
%             set(pendules{obj}{1}(1),'XData',[0,pendules{obj}{2}(1)],'YData',[0 pendules{obj}{3}(1)])
%             set(pendules{obj}{1}(2),'XData',[pendules{obj}{2}(1),pendules{obj}{4}(1)],'YData',[pendules{obj}{3}(1),pendules{obj}{5}(1)])
%             set(pendules{obj}{1}(3),'XData',pendules{obj}{2}(1),'YData',pendules{obj}{3}(1))
%             set(pendules{obj}{1}(4),'XData',pendules{obj}{4}(1),'YData',pendules{obj}{5}(1))
%             drawnow
%         end

    end
    fprintf("Valeur chang�e!")
    pause(1.5)
    
    % On retourne ensuite au menu pr�c�dent
    switch prev
        case 'parametres_physiques'
            menu_parametres_physiques
        case 'parametres_simulation'
            menu_parametres_simulation
    end
    
else
    change_param(name,index)
end
    
end


