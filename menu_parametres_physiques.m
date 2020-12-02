function menu_parametres_physiques

global params
title = 'Modifier paramètres physiques';
options = {['l1 : ' num2str(params(1))],...
           ['l2 : ' num2str(params(2))],...
           ['m1 : ' num2str(params(3))],...
           ['m2 : ' num2str(params(4))],...
           ['I1 : ' num2str(params(5))],...
           ['I2 : ' num2str(params(6))],...
           ['k1 : ' num2str(params(7))],...
           ['k2 : ' num2str(params(8))],...
           ['Gravité : ' num2str(params(9)) ' m/s^2'],...
           'Menu Précédent'};
choix = disp_menu(options,title);

switch choix
    case 1 % Modifier l1
        change_param('l1',1,'parametres_physiques')
    case 2
        change_param('l2',2,'parametres_physiques')
    case 3
        change_param('m1',3,'parametres_physiques')
    case 4
        change_param('m2',4,'parametres_physiques')
    case 5
        change_param('I1',5,'parametres_physiques')
    case 6
        change_param('I2',6,'parametres_physiques')
    case 7 
        change_param('k1',7,'parametres_physiques')
    case 8 
        change_param('k2',8,'parametres_physiques')
    case 9
        change_param('g',9,'parametres_physiques')
    case 10
        menu_parametres
end    

end