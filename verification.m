% _____________________________________________________________ 
% Programme 'verification' :
%
% Description : 
% Ce script sert � v�rifier la validit� des fonctions EE, EI, RK4 et
% Verlet en effectuant une simulation sur un oscillateur harmonique dont on
% conna�t la solution analytique. Il utilise des clones des fonctions EE,
% EI, RK4 et Verlet en utilisant une fonction fonc_test (oscillateur
% harmonique) au lieu de la fonction f (double pendule). Le script g�n�re
% ensuite des graphes illustrant les solutions, l'erreur et l'�nergie pour
% chaque m�thode.
% Afin de ne pas ajouter de nombreux fichier non-n�cessaires au programme
% principal, toutes les fonctions utilis�es dans ce script sont d�clar�es
% en soius-fonctions � la fin du programme.
%
% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 4/12/2020
% -------------------------------------------------
% _____________________________________________________________


%% Param�tres
% param�tres
tf = 10;
dt = 0.01;
m = 0.5;
k = 5;
c = 0.1;
param = [k m c];

% �tat_initial
etat_initial = [3/4;0];

%% R�solution

% Solution analytique
% Initialisation
ta = [0:dt:tf+dt];
y_a = [];
% �quation diff�rentielle du mouvement = [m * x_dotdot] + [c * x_dot] + [k * x] = 0
% racines complexes de l'�quation
r1 = -c/(2*m) + sqrt(c^2 - 4*m*k)/(2*m);
r2 = -c/(2*m) - sqrt(c^2 - 4*m*k)/(2*m);

% Parties r�elles et complexes des racines
lambda = real(r1);
mu = imag(r1);

% Constantes d'int�gration
c1 = etat_initial(1);
c2 = (etat_initial(2) - lambda*etat_initial(1))/mu;

for i = ta
    % Solution g�n�rale de l'�quation diff�rentielle
    y_a(end+1) = c1*exp(lambda*i)*cos(mu*i) + c2*exp(lambda*i)*sin(mu*i);
end

% Euler Explicite
[t_ee, y_ee] = EE_test(etat_initial,param,dt,tf);

% RK4
[t_rk4, y_rk4] = RK4_test(etat_initial,param,dt,tf);

% Verlet
[t_ver, y_ver] = Verlet_test(etat_initial,param,dt,tf);

% Euler Implicite
[t_ei, y_ei] = EI_test(etat_initial,param,dt,tf);

%% Graphes
% graphe des solutions
figure
plot(ta,y_a,t_rk4,y_rk4(1,:),t_ee,y_ee(1,:),t_ver,y_ver(1,:),t_ei,y_ei(1,:),'LineWidth',2)
legend("Analytique","RK4","Euler explicite","Verlet","Euler implicite")
 xlabel("Temps (s)")
 ylabel("Amplitude (m)")
 title("Amplitude de l'oscillateur harmonique selon la m�thode � dt=0.01")
 set(gca,'FontSize',14)

% Graphes des erreurs
 figure
 erreur_rk4 = y_a-y_rk4(1,:);
 erreur_ee = y_a-y_ee(1,:);
 erreur_ver = y_a-y_ver(1,:);
 erreur_ei = y_a-y_ei(1,:);
 plot(ta,erreur_rk4,ta,erreur_ee,ta,erreur_ver,ta,erreur_ei,'LineWidth',2)
 legend("Erreur RK4","Erreur EE","Erreur Verlet","Erreur Ei")
 xlabel("Temps (s)")
 ylabel("Erreur (m)")
 title("Erreurs sur l'oscillateur harmonique � dt=0.01s")
 set(gca,'FontSize',14)
 
 % Graphes de l'�nergie
 figure
 energie_rk4 = energie(y_rk4(1,:),y_rk4(2,:),param);
 energie_ee = energie(y_ee(1,:),y_ee(2,:),param);
 energie_ver = energie(y_ver(1,:),y_ver(2,:),param);
 energie_ei = energie(y_ei(1,:),y_ei(2,:),param);
 plot(ta,energie_rk4,ta,energie_ee,ta,energie_ver,ta,energie_ei,'LineWidth',2)
 legend("�nergie RK4","�nergie EE","�nergie Verlet","�nergie EI")
 xlabel("Temps (s)")
 ylabel("�nergie (J)")
 title("�nergie de l'oscillateur selon la m�thode")
 set(gca,'FontSize',14)

%% Fonctions de test
% La fonction fonc_test() calcule la diff�rentielle d'un oscillateur
% harmonique, elle est l'�quivalent de la fonction f() pour le double
% pendule
function f = fonc_test(y,param)
% __________________________________________________________________
% Fonction 'fonc' :
% Arguments d'entr�e :
% - y : vecteur compos� de la position et de la vitesse
%      * x = y(1)         Position
%      * v = y(2)         Vitesse
% - param: parametres du probl�me
%      * k = param(1)     Constante de rappel du ressort 
%      * m = param(2)     Masse de l'objet accroch� au ressort
%      * c = param(3)     constante d'amortissment  
% Arguments de sortie :
% - f : vecteur ligne compos� des valeurs des �quations diff�rentielles
% __________________________________________________________________

%---------- Assignation des param�tres du probl�me ----------
k = param(1);%     Constante de rappel du ressort 
m = param(2); %   Masse de l'objet accroch� au ressort 
c = param(3);

%---------- Assignation des variables d�pendantes ----------
x = y(1); %       Position
v = y(2); %         Vitesse

%---------- �quations diff�rentielles ----------
f =[v,(-k*x - c*v)/m]';
  
end
% Les autres fonctions sont des CLONES des fonctions utilis�es pour le
% double pendule, qui utilisent fonc_test() (oscillateur) au lieu de f() 
% (double pendule).
% Fonctions d�finies:
% EE_test() ; RK4_test() ; Verlet_test ; EI_test ; Jac_test ; Residu_test ;
% energie(x,v,param) (Prise du TD5)
function [t, etat] = EE_test(etat_initial,params,dt,tf)
%_____________________________________________________________
% Fonction 'EE' :
%
% Description :
% La fonction 'EE' trouve les solutions pour les acc�l�rations angulaires (theta_dotdot) et les vitesses angulaires 
% pour un pendule double par la m�thode d'Euler explicite. Elle prend en
% entr�e l'�tat initial du syst�me, les param�tres du syst�me �tudi�, ainsi
% que le pas de temps et la dur�e de simulation.
%
% Arguments d'entr�e : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul (s)
% - tf : Temps de simulation (s)
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% syst�me d'�quations diff�rentielles a �t� �valu�, en incluant le temps 0.
% - etat : Matrice 4xn d�crivant l'�tat du syst�me dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] �valu�e �
% tous les temps pr�sents dans le vecteur t.

% -------------------------------------------------
% Auteur : Kevin Chau
% Date de cr�ation : 02/12/2020
% Derni�re modification (v1) : 02/12/2020
% -------------------------------------------------
% _____________________________________________________________

%On initialise les variables
t = 0;
etat = etat_initial;

%On applique la suite de r�currence pendant la dur�e souhait�e de la
%simulation
while t < tf
    etat(:,end + 1) = etat(:,end) + dt*fonc_test(etat(:,end),params);
    t(end + 1) = t(end) + dt;
end

end % Clone de EE
function [t, etat] = RK4_test(etat_initial,params,dt,tf)
% _____________________________________________________________ 
% Fonction 'RK4' :
%
% Description : 
% Cette fonction utilise la m�thode de Runge Kutta 4 explicite pour 
% r�soudre le syst�me d'�quations diff�rentielles dy/dt = f(t,y) sur une
% p�riode de temps [0;tf]. Les 4 �quations diff�rentielles qui composent
% dy/dt sont les vitesses angualaires theta_dot_1 et theta_dot_2, ainsi que
% les acc�l�rations angulaires theta_dotdot_1 et theta_dotdot_2.
%
% Arguments d'entr�e : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
% - tf : Temps de simulation
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% syst�me d'�quations diff�rentielles a �t� �valu�, en incluant le temps 0.
% - etat : Matrice 4xn d�crivant l'�tat du syst�me dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] �valu�e �
% tous les temps pr�sents dans le vecteur t.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

% On d�fini d'abord les conditions initiales
t = [0];
etat = [etat_initial];

% Boucle de resolution
while t(end) < tf
    k1 = dt*fonc_test(etat(:,end),params); % Pertinent de noter que f ne d�pend pas de t -> f(y)
    k2 = dt*fonc_test(etat(:,end) + k1/2 , params);
    k3 = dt*fonc_test(etat(:,end) + k2/2 , params);
    k4 = dt*fonc_test(etat(:,end) + k3 , params);
    etat(:,end+1) = etat(:,end) + (k1 + 2*k2 + 2*k3 + k4)/6;
    t(end+1) = t(end) + dt;
end

end % Clone de RK4
function [t, etat] = Verlet_test(etat_initial,params,dt,tf)
%_____________________________________________________________
% Fonction 'Verlet' :
%
% Description :
% La fonction 'Verlet' trouve les solutions pour les acc�l�rations angulaires (theta_dotdot) et les vitesses angulaires 
% pour un pendule double par la m�thode de Verlet. Elle prend en
% entr�e l'�tat initial du syst�me, les param�tres du syst�me �tudi�, ainsi
% que le pas de temps et la dur�e de simulation.
%
% Arguments d'entr�e : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul (s)
% - tf : Temps de simulation (s)
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% syst�me d'�quations diff�rentielles a �t� �valu�, en incluant le temps 0.
% - etat : Matrice 4xn d�crivant l'�tat du syst�me dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] �valu�e �
% tous les temps pr�sents dans le vecteur t.

% -------------------------------------------------
% Auteur : Kevin Chau
% Date de cr�ation : 02/12/2020
% Derni�re modification (v1) : 02/12/2020
% -------------------------------------------------
% _____________________________________________________________


%Initialisation 
t = 0;
etat = etat_initial;

%On calcule l'acc�l�ration initiale
accel = fonc_test(etat_initial,params);
accel = accel(2); % Juste l'�l�ment 2 de la fonction test

while t < tf
    v_half = etat(2,end) + 0.5*dt*accel;
    etat(1,end + 1) = etat(1, end) + dt*v_half; %Calcul de la position au temps t + dt
    accel = fonc_test([etat(1, end) ; v_half], params); %Calcul de la nouvelle acc�l�ration
    accel = accel(2);
    etat(2, end) = v_half + 0.5*dt*accel; %Calcul de la vitesse au temps t + dt
    t(end + 1) = t(end) + dt;
end
end % Clone de Verlt
function [t, etat] = EI_test(etat_initial,params,dt,tf)
% _____________________________________________________________ 
% Fonction 'EI' :
%
% Description : 
% Cette fonction utilise la m�thode de Euler implicite pour 
% r�soudre le syst�me d'�quations diff�rentielles dy/dt = f(t,y) sur une
% p�riode de temps [0;tf]. Les 4 �quations diff�rentielles qui composent
% dy/dt sont les vitesses angulaires theta_dot_1 et theta_dot_2, ainsi que
% les acc�l�rations angulaires theta_dotdot_1 et theta_dotdot_2.
% La fonction utilise la m�thode Newton-Raphson avec une Jacobienne 
% num�rique pour r�soudre les �quations non-lin�aires provenant de la forme
% en diff�rences finies implicites.
%
% Arguments d'entr�e : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
% - tf : Temps de simulation
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% syst�me d'�quations diff�rentielles a �t� �valu�, en incluant le temps 0.
% - etat : Matrice 4xn d�crivant l'�tat du syst�me dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] �valu�e �
% tous les temps pr�sents dans le vecteur t.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________


% On d�fini d'abord les conditions initiales
t = [0];
etat = [etat_initial];

% On defini ensuite les param�tres de r�solution d'�quations non-lin�aires
% par newton-Raphson
N = 1000; % Nombre d'it�rations maximales pour r�soudre une �quation non-lin�aire
tol = 1e-7; % Pr�cision vis�e par la r�solution non-lin�aire

% Boucle de r�solution des �quations diff�rentielles
while t(end) < tf
    
    % D�but de la r�solution du syt�me d'�quations non-lin�aire de
    % diff�rences finies par la m�thode de Newton-Raphson
    dx = 1; % Vecteur de correction dx initialis� comme = 1
    it = 0; % Compteur d'it�rations
    xi = etat(:,end);
    if any(xi == 0) % Cette condition assure que les estim�s initiaux ne comportent pas de z�ros, ce qui cr�e des erreurs dans la jacobienne
        x = xi + 0.01*ones(2,1);
    else
        x = xi;
    end
    % Boucle de r�solution non-lin�aire
    while norm(dx) > tol && it < N
        R = Residu_test(x,xi,dt,params);
        J = Jac_test(x,xi,dt,params,tol);
        dx = J\-R;
        x = x + dx;
        it = it+1;
    end    
    % Stockage des valeurs trouv�es par Newton-Raphson
    etat(:,end+1) = x;
    t(end+1) = t(end) + dt;
    
end

end % Clone de EI
function [J] = Jac_test(x_tdt,x_t,dt,params,tol)
% _____________________________________________________________ 
% Fonction 'Jac' :
%
% Description : 
% Cette fonction calcule la Jacobienne num�rique d'une �quation
% non-lin�aire, comme utilis�e dans la m�thode de r�solution
% Newton-Raphson. Pour estimer la jacobienne, on utilise un vecteur
% perturb�.
%
% Arguments d'entr�e : 
% - x_tdt : Vecteur colonne 4x1 contenant les
% valeurs au temps t+dt des deux angles et des deux vitesses telles que 
% x_tdt = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - x_t : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% x_t = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
% - tol : Tol�rance, valeur tr�s petite utilis�e comme perturbation pour le
% calcul de la Jacobienne num�rique.
%
% Arguments de sortie : 
% - J : Matrice Jacobienne 4x4.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

%Initialisatiuon de la Jacobienne
J = zeros(length(x_t));
for i = 1:length(x_t)
    % Calcul du vecteur perturb�
    etat_perturb = x_tdt;
    etat_perturb(i) = etat_perturb(i) + etat_perturb(i)*tol;
    
    % Remplissage de la Jacobienne num�rique
    J(:,i) = (Residu_test(etat_perturb,x_t,dt,params) - Residu_test(x_tdt,x_t,dt,params))/(x_tdt(i)*tol);
end

end % Clone de Jac
function [R] = Residu_test(x_tdt,x_t,dt,params)
% _____________________________________________________________ 
% Fonction 'Residu' :
%
% Description : 
% Cette fonction calcule l'expression R = x_t+dt - dt*f(x_t) - x_t, pour
% des valeurs de x aux temps t et t+dt, et une fonction f(x) qui �value la
% d�riv�e temporelle du vecteur x.
% Cette valeur correspond au r�sidu d'une �quation non-lin�aire, comme
% celle qui appara�t dans la m�thode de r�solution d'�quations
% diff�rentielles par Euler Implicite.
%
% Arguments d'entr�e : 
% - x_tdt : Vecteur colonne 4x1 contenant les
% valeurs au temps t+dt des deux angles et des deux vitesses telles que 
% x_tdt = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - x_t : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% x_t = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - params : Vecteur ligne 9x1 contenant les param�tre statiques du 
% probl�me tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
%
% Arguments de sortie : 
% - R : Vecteur colonne 4x1 du r�sidu.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

R = x_tdt - dt*fonc_test(x_tdt,params) - x_t;

end % Clone de Residu
function E = energie(x,v,param)
% __________________________________________________________________
% Fonction 'energie' :
% Arguments d'entr�e :
% - x : vecteur position
% - v : vecteur vitesse
% - param : vecteur des param�tres des �quations diff�rentielles
%          * k = param(1)     Constante de rappel du ressort 
%          * m = param(2)     Masse de l'objet accroch� au ressort 
% Arguments de sortie :
% - E : vecteur compos� de l'�nergie du syst�me (vecteur ligne)
% __________________________________________________________________

%---------- Assignation des param�tres ----------
k = param(1);%     Constante de rappel du ressort 
m = param(2);%     Masse de l'objet accroch� au ressort 

%---------- Calcul de l'�nergie ----------
E = [0.5*m*v.^2 + k*0.5*x.^2]' ;
     
end % Cette fonction est prise du TD5!
