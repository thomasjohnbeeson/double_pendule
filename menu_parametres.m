function menu_parametres

title = 'Param�tres';
options = {'Param�tres physiques','Param�tres de simulation','Menu pr�c�dent'};
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