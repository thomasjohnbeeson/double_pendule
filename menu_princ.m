function menu_princ
global methodes

title = 'Menu principal';
options = {'Paramètres','Sélection méthode','Animer','Enregistrer vidéo','Quitter'}
choix = disp_menu(options,title);

switch choix
    case 1 % Accéder au menu des paramètres
        menu_parametres
    case 2 % Changer la méthode de résolution numérique 
        list = ["Euler explicite" "Euler implicite" "Verlet" "Runge Kutta 4"];
        [select,tf] = listdlg('PromptString','Sélectionner les méthodes souhaitées:',...
                           'SelectionMode','multiple',...
                           'ListString',list,'InitialValue',methodes);
        methodes = select;
        fprintf("Méthodes changées avec succès!")
        init_pendules;
        pause(1)
        menu_princ
                       
    case 3 % Animer
        d
    case 4 % Créer un enregistrement vidéo
        fg
    case 5 % Quitter
        clc
        clear all
        close all
        return
end
end