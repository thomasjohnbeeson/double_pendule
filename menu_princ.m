% _____________________________________________________________ 
% Fonction 'menu_princ' :
%
% ÉLÉMENT D'INTERFACE GRAPHIQUE. PAS DE RÔLE IMPORTANT DANS LA RÉSOLUTION
%
% Description : 
% Cette fonction sans arguments gère les fonctionnalitées associées au menu
% principal. À partir de ce menu, l'utilisateur à accès au menu des
% paramètres, au menu des conditions initales, il peut changer la méthode
% d'intégration, animer le pendule ou créer une vidéo MPEG-4 de sa
% simulation.
% Pour effectuer la RÉSOLUTION, ce menu appelle la fonction 'solutionner',
% puis l'anime avec la fonction 'animate'. Tous autre élément sert à
% l'interface utilisateur (UI).
%
% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

function menu_princ
global methodes
global pendules
global params

title = 'Menu principal';
options = {'Paramètres','Sélection méthode','Changer/ajouter des conditions initiales','Animer','Enregistrer vidéo','Quitter'};
choix = disp_menu(options,title);

switch choix
    case 1 % Accéder au menu des paramètres
        menu_parametres % Renvoi au menu des paramètres
        
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
        
    case 3 % Changer les conditions initiales
        menu_CI % Renvoi au menu des CI
                    
    case 4 % Animer
        % la fonction solutionner solutionne chaque pendule un par un selon
        % les méthodes définies dans l'objet "pendules"
        init_pendules
        solutionner % Fait la résolution complète de tous les pendules

        % On anime ensuite les pendules
        animate(pendules,params(11),false)
        fprintf("Simulation terminée!")
        pause(2)
        menu_princ
        
    case 5 % Créer un enregistrement vidéo
        % C'est la fonction animate.m qui permet l'enregistrement. Si on
        % lui fourni l'argument 'true', elle désactive le graphe et produit
        % un vidéo MPEG-4 à la place
        slct = false;
        while ~slct
            clc
            choix = input("Êtes-vous sûr de vouloir continuer?\nL'enregistrement peut prendre plusieurs minutes! [y/n] : ",'s')
            if choix == 'y' % On procède avec l'enregistrement
                init_pendules
                solutionner % Cette fonction effectue la résolution des pendules
                animate(pendules,params(11),true)
                fprintf("\nL'enregistrement a été un succès!")
                slct = true;
                pause(2)
                menu_princ
            elseif choix == 'n'
                slct = true;
                menu_princ
                
            else
                fprintf("\n Veuillez sélectionner une des options [y/n]")
                pause(1.5)
            end
        end
        
    case 6 % Quitter 
        clc
        clear all
        close all
        return % termine le programme
end
end