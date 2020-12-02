function menu_princ
global methodes

title = 'Menu principal';
options = {'Param�tres','S�lection m�thode','Animer','Enregistrer vid�o','Quitter'}
choix = disp_menu(options,title);

switch choix
    case 1 % Acc�der au menu des param�tres
        menu_parametres
    case 2 % Changer la m�thode de r�solution num�rique 
        list = ["Euler explicite" "Euler implicite" "Verlet" "Runge Kutta 4"];
        [select,tf] = listdlg('PromptString','S�lectionner les m�thodes souhait�es:',...
                           'SelectionMode','multiple',...
                           'ListString',list,'InitialValue',methodes);
        methodes = select;
        fprintf("M�thodes chang�es avec succ�s!")
        init_pendules;
        pause(1)
        menu_princ
                       
    case 3 % Animer
        d
    case 4 % Cr�er un enregistrement vid�o
        fg
    case 5 % Quitter
        clc
        clear all
        close all
        return
end
end