% _____________________________________________________________ 
% Fonction 'menu_parametres' :
%
% �L�MENT D'INTERFACE GRAPHIQUE. PAS DE R�LE IMPORTANT DANS LA R�SOLUTION
%
% Description : 
% Cette fonction sans arguments g�re les fonctionnalit�es associ�es au menu
% des param�tres. Elle permet de modifier les diff�rent param�tres de la
% simulation (l1, l2, I1, g, dt, tf, etc ).
% Elle poss�de deux sous-fonction de menu similaires, soit menu_parametres_physiques
% et menu_parametres_simulation.
% Elle contient finalement la sous-fonction change_param qui modifie le
% param�tre s�lectionn� dans la simulation
% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

%% Fonction menu_parametres
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

function menu_parametres_physiques

global params
title = 'Modifier param�tres physiques';
options = {['l1 : ' num2str(params(1))],...
           ['l2 : ' num2str(params(2))],...
           ['I1 : ' num2str(params(3))],...
           ['I2 : ' num2str(params(4))],...
           ['m1 : ' num2str(params(5))],...
           ['m2 : ' num2str(params(6))],...
           ['k1 : ' num2str(params(7))],...
           ['k2 : ' num2str(params(8))],...
           ['Gravit� : ' num2str(params(9)) ' m/s^2'],...
           'Menu Pr�c�dent'};
choix = disp_menu(options,title);

switch choix
    case 1 % Modifier l1
        change_param('l1',1,'parametres_physiques')
    case 2
        change_param('l2',2,'parametres_physiques')
    case 3
        change_param('I1',3,'parametres_physiques')
    case 4
        change_param('I2',4,'parametres_physiques')
    case 5
        change_param('m1',5,'parametres_physiques')
    case 6
        change_param('m2',6,'parametres_physiques')
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

%% Fonction menu_parametres_simulation
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

%% Fonction change_param
% Cette fonction change le param�tre du m�me 'name' dans les param�tres de
% simulation. 'index' est l'indexe du param�tre vis� dans la variable global
% 'params'. 'prev' est le menu pr�c�dent, pour y renvoyer l'utilisateur
% apr�s l'ex�cution.
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