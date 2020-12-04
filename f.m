function [y_dot] = f(etat,params)
% _____________________________________________________________
% Fonction 'f' :
%
% Description :
% Cette fonction �value l'expression dy/dt = f(t,y) o� y est le vecteur 4x1
% contenant les vitesses angulaires et les angles du double pendule. 
% Elle retourne donc la valeur des vitesses, et calcule les acc�l�rations
% angulaires � l'aide des �quations de mouvement coupl�es.
% La r�solution de ces �quations coupl�es est faite  en utilisant un 
% syst�me matriciel.
% On utilise comme param�tres les angles, les vitesses angulaires et
% les param�tres statiques du probl�me.
%
% Arguments d'entr�e :
% - etat : Vecteur colonne 4x1 contenant les valeurs des deux angles et des
% deux vitesses telles que etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
%
% Argument de sortie :
% - y_dot : Vecteur colonne 4x1 contenant l'expression des vitesses et des
% acc�l�rations telles que y_dot = [theta_dot_1 ; theta_dot_2 ; theta_dotdot_1 ; theta_dotdot_2]

% -------------------------------------------------
% Auteur : Thomas John Beeson
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________
        
% Param�tres statiques
l1 = params(1) ; l2 = params(2);
I1 = params(3) ; I2 = params(4);
m1 = params(5) ; m2 = params(6);
k1 = params(7) ; k2 = params(8);
g = params(9)  ;

% On a deux �quations coupl�es, on les combine dans un syst�me
% matriciel Ax = b pour les r�soudre
% Matrice des coefficients d'acc�l�ration (diagonale)
A = [I1 + l1^2*(m1 + m2) , m2*l1*l2*cos(etat(1)-etat(2))
     m2*l2*l1*cos(etat(1)-etat(2)) , I2 + m2*l2^2];

% Vecteur b (r�sidu des �quations coupl�es)
b = [-k1*etat(3) + k2*etat(4) - g*l1*sin(etat(1))*(m1+m2) - etat(4)^2*m2*l1*l2*sin(etat(1)-etat(2))
     -k2*etat(4) - m2*g*l2*sin(etat(2)) + etat(3)^2*m2*l2*l1*sin(etat(1)-etat(2))];

% R�solution
% On d�fini d'abord les deux valeurs de vitesse, d�j� donn�es en entree
y_dot = zeros(4,1);
y_dot(1) = etat(3);
y_dot(2) = etat(4);
% On effectue ensuite la r�solution matricielle pour les acc�l�rations 
y_dot(3:4) = A\b;
end
    
    