function menu_princ
global methodes
global pendules
global params

title = 'Menu principal';
options = {'Param�tres','S�lection m�thode','Changer/ajouter des conditions initiales','Animer','Enregistrer vid�o','Quitter'};
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
        
    case 3 % Changer les conditions initiales
        menu_CI
                    
    case 4 % Animer
        % la fonction solutionner solutionne chaque pendule un par un selon
        % les m�thodes d�finies dans l'objet "pendules"
        init_pendules
        solutionner

        % On anime ensuite les pendules
        animate(pendules,params(11),false)
        fprintf("Simulation termin�e!")
        pause(2)
        menu_princ
        
    case 5 % Cr�er un enregistrement vid�o
        % C'est la fonction animate.m qui permet l'enregistrement. Si on
        % lui fourni l'argument 'true', elle d�sactive le graphe et produit
        % un vid�o MPEG-4 � la place
        slct = false;
        while ~slct
            clc
            choix = input("�tes-vous s�r de vouloir continuer?\nL'enregistrement peut prendre plusieurs minutes! [y/n] : ",'s')
            if choix == 'y' % On proc�de avec l'enregistrement
                init_pendules
                solutionner % Cette fonction effectue la r�solution des pendules
                animate(pendules,params(11),true)
                fprintf("\nL'enregistrement a �t� un succ�s!")
                slct = true;
                pause(2)
                menu_princ
            elseif choix == 'n'
                slct = true;
                menu_princ
                
            else
                fprintf("\n Veuillez s�lectionner une des options [y/n]")
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