function menu_parametres_simulation

global params
title = 'Modifier param�tres simulation';
options = {['Dur�e simulation : ' num2str(params(10)) 's'],...
           ['dt : ' num2str(params(11)) 's'],...
           'Menu Pr�c�dent'};
choix = disp_menu(options,title);

switch choix
    case 1
        change_param('tf',10,'parametres_simulation')
    case 2
        change_param('dt',11,'parametres_simulation')
    case 3
        menu_parametres
end

end
