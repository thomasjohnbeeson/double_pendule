function menu_CI

global etat_initial
title = 'Changer/ajouter des conditions initiales';
options = {'Modifier des conditions initiales','Ajouter des conditions initiales','Supprimer des conditions initiales','Menu précédent'};
choix = disp_menu(options,title);

switch choix
    case 1 % Modifier conditions initiales
        ci_a_modif = [1:size(etat_initial,2)];
        modif_CI(ci_a_modif);
        init_pendules;
        menu_CI
     
    case 2 % Ajouter des conditions initiales
        etat_initial(:,end+1) = [0];
        ci_a_modif = size(etat_initial,2);
        modif_CI(ci_a_modif);
        init_pendules;
        menu_CI
        
    case 3 % Supprimer des conditions initiales
        slct = false;
        while ~slct
            clc
            fprintf("Il y a %f ensembles de conditions initiales.\nOn ne peut pas supprimer le dernier ensemble si il n'en reste qu'un.\n",size(etat_initial,2))
            supr = input("Veuillez sélectionner l'ensemble à supprimer : ",'s');
            if ~isempty(str2num(supr)) && size(etat_initial,2) ~= 1 && str2num(supr) <= size(etat_initial,2)
                etat_initial(:,str2num(supr)) = [];
                slct = true;
            end
        end
        % On réinitilaise les pendules
        init_pendules
        menu_CI
             
    case 4
        menu_princ
        
end

end