function menu_parametres

title = 'Paramètres';
options = {'Paramètres physiques','Paramètres de simulation','Menu précédent'};
choix = disp_menu(options,title);

switch choix
    case 1
        menu_parametres_physiques
    case 2
        menu_parametres_simulation
    case 3
        menu_princ
end
end