function [E_sys] = Energie(etat, params, t)
%_____________________________________________________________
% Fonction 'Energie' :
%
% Description :
% La fonction 'Energie' calcule l'énergie totale du système pendule double
% à chaque instant t donné.
%
% Arguments d'entrée : 
% - etat : Vecteur 4xn contenant l'angle par rapport à la verticale et les vitesses angulaires à chaque
% instant t. Il prend la forme [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot2]
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% système d'équations différentielles a été évalué, en incluant le temps 0.
% Arguments de sortie : 
% - Energie : Vecteur ligne 1xn contenant l'énergie totale du système
% (cinétique + potentielle) pour chaque instant de temps t.
% -------------------------------------------------
% Auteur : Kevin Chau
% Date de création : 02/12/2020
% Dernière modification (v1) : 02/12/2020
% -------------------------------------------------
% _____________________________________________________________

%Extraction des paramètres depuis le vecteur 'params'
l1 = params(1);
l2 = params(2);
I1 = params(3);
I2 = params(4);
m1 = params(5);
m2 = params(6);
k1 = params(7);
k2 = params(8);
g = params(9);

E_cin = 0.5*m1*l1^2.*(etat(3,:).^2) + 0.5*m2*l1^2.*(etat(3,:).^2) + 0.5*m2*l2^2.*(etat(4,:).^2) ...
    + 0.5*I1.*(etat(3,:).^2) + 0.5*I2.*(etat(4,:).^2) + m2*l1*l2.*etat(3,:).*etat(4,:).*cos(etat(1,:) - etat(2,:)); %?nergie cin?tique du syst?me
E_pot = -g*(l1*cos(etat(1,:)))*m1 - g*(l1*cos(etat(1,:)) + l2*cos(etat(2,:)))*m2; 

E_sys = E_cin + E_pot;
