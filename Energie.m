function [E_sys] = Energie(etat, params, t)
%_____________________________________________________________
% Fonction 'Energie' :
%
% Description :
% La fonction 'Energie' calcule l'�nergie totale du syst�me pendule double
% � chaque instant t donn�.
%
% Arguments d'entr�e : 
% - etat : Vecteur 4xn contenant l'angle par rapport � la verticale et les vitesses angulaires � chaque
% instant t. Il prend la forme [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot2]
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% syst�me d'�quations diff�rentielles a �t� �valu�, en incluant le temps 0.
% Arguments de sortie : 
% - Energie : Vecteur ligne 1xn contenant l'�nergie totale du syst�me
% (cin�tique + potentielle) pour chaque instant de temps t.
% -------------------------------------------------
% Auteur : Kevin Chau
% Date de cr�ation : 02/12/2020
% Derni�re modification (v1) : 02/12/2020
% -------------------------------------------------
% _____________________________________________________________

%Extraction des param�tres depuis le vecteur 'params'
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
