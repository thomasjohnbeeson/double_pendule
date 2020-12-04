% _____________________________________________________________ 
% Fonction 'menu_CI' :
%
% �L�MENT D'INTERFACE GRAPHIQUE. PAS DE R�LE IMPORTANT DANS LA R�SOLUTION
%
% Description : 
% Cette fonction sans arguments g�re les fonctionnalit�es associ�es au menu
% des conditions initiales. Elle permet d'ajouter, de supprimer et de
% modifier des ensembles de conditions initiales.
% Elle poss�de une sous-fonction modif_CI qui cr�e un menu interactif et
% modifie les conditions initiales de simulation.
%
% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

%% Fonction menu_CI
function menu_CI

global etat_initial
title = 'Changer/ajouter des conditions initiales';
options = {'Modifier des conditions initiales','Ajouter des conditions initiales','Supprimer des conditions initiales','Menu pr�c�dent'};
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
            supr = input("Veuillez s�lectionner l'ensemble � supprimer : ",'s');
            if ~isempty(str2num(supr)) && size(etat_initial,2) ~= 1 && str2num(supr) <= size(etat_initial,2)
                etat_initial(:,str2num(supr)) = [];
                slct = true;
            end
        end
        % On r�initilaise les pendules
        init_pendules
        menu_CI
             
    case 4
        menu_princ
        
end

end

%% Fonction modif_CI
% Cr�e un menu interactif et modifie les conditions initiales de la
% simulation
function modif_CI(ci)

global etat_initial

% On cr�e le menu de commande qui va appara�tre, � partir des
% conditions initiales actuelles
cond_a_modif = strings([1 4*size(ci,2)]);
default_values = strings([1 4*size(ci,2)]);
for i = 1:length(ci)
    cond_a_modif((i-1)*4 + 1) = ['C' num2str(ci(i)) ' : theta_1'];
    default_values((i-1)*4 + 1) = num2str(etat_initial(1,ci(i)));
    cond_a_modif((i-1)*4 + 2) = ['C' num2str(ci(i)) ' : theta_2'];
    default_values((i-1)*4 + 2) = num2str(etat_initial(2,ci(i)));
    cond_a_modif((i-1)*4 + 3) = ['C' num2str(ci(i)) ' : theta_dot_1'];
    default_values((i-1)*4 + 3) = num2str(etat_initial(3,ci(i)));
    cond_a_modif((i-1)*4 + 4) = ['C' num2str(ci(i)) ' : theta_dot_2'];
    default_values((i-1)*4 + 4) = num2str(etat_initial(4,ci(i)));
end

slct = false;
while ~slct
    nouv_ci = inputdlg(cond_a_modif,'Modifier les conditions initiales',[1 35],default_values);
    slct = true;
    % On v�rifie ensuite les entr�e
    for i = 1:length(nouv_ci)
        if isempty(str2num(nouv_ci{i})) | length(str2num(nouv_ci{i})) ~= 1 % indique une entr�e multiple ou un "string"
            slct = false;
        end
    end
    if ~slct
        fprintf('Veuillez entrer des valeurs num�riques uniques')
        pause(2)
    end
end

% On a des entr�es valides, on remplace les CI par les nouvelles
% valeurs

for i = 1:length(nouv_ci)
    etat_initial((min(ci)-1)*4 + i) = str2num(nouv_ci{i});
end

end