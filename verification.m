% _____________________________________________________________ 
% Programme 'verification' :
%
% Description : 
% Ce script sert à vérifier la validité des fonctions EE, EI, RK4 et
% Verlet en effectuant une simulation sur un oscillateur harmonique dont on
% connaît la solution analytique. Il utilise des clones des fonctions EE,
% EI, RK4 et Verlet en utilisant une fonction fonc_test (oscillateur
% harmonique) au lieu de la fonction f (double pendule). Le script génère
% ensuite des graphes illustrant les solutions, l'erreur et l'énergie pour
% chaque méthode.
% Afin de ne pas ajouter de nombreux fichier non-nécessaires au programme
% principal, toutes les fonctions utilisées dans ce script sont déclarées
% en soius-fonctions à la fin du programme.
%
% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 4/12/2020
% -------------------------------------------------
% _____________________________________________________________


%% Paramètres
% paramètres
tf = 10;
dt = 0.01;
m = 0.5;
k = 5;
c = 0.1;
param = [k m c];

% état_initial
etat_initial = [3/4;0];

%% Résolution

% Solution analytique
% Initialisation
ta = [0:dt:tf+dt];
y_a = [];
% équation différentielle du mouvement = [m * x_dotdot] + [c * x_dot] + [k * x] = 0
% racines complexes de l'équation
r1 = -c/(2*m) + sqrt(c^2 - 4*m*k)/(2*m);
r2 = -c/(2*m) - sqrt(c^2 - 4*m*k)/(2*m);

% Parties réelles et complexes des racines
lambda = real(r1);
mu = imag(r1);

% Constantes d'intégration
c1 = etat_initial(1);
c2 = (etat_initial(2) - lambda*etat_initial(1))/mu;

for i = ta
    % Solution générale de l'équation différentielle
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
 title("Amplitude de l'oscillateur harmonique selon la méthode à dt=0.01")
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
 title("Erreurs sur l'oscillateur harmonique à dt=0.01s")
 set(gca,'FontSize',14)
 
 % Graphes de l'énergie
 figure
 energie_rk4 = energie(y_rk4(1,:),y_rk4(2,:),param);
 energie_ee = energie(y_ee(1,:),y_ee(2,:),param);
 energie_ver = energie(y_ver(1,:),y_ver(2,:),param);
 energie_ei = energie(y_ei(1,:),y_ei(2,:),param);
 plot(ta,energie_rk4,ta,energie_ee,ta,energie_ver,ta,energie_ei,'LineWidth',2)
 legend("Énergie RK4","Énergie EE","Énergie Verlet","Énergie EI")
 xlabel("Temps (s)")
 ylabel("Énergie (J)")
 title("Énergie de l'oscillateur selon la méthode")
 set(gca,'FontSize',14)

%% Fonctions de test
% La fonction fonc_test() calcule la différentielle d'un oscillateur
% harmonique, elle est l'équivalent de la fonction f() pour le double
% pendule
function f = fonc_test(y,param)
% __________________________________________________________________
% Fonction 'fonc' :
% Arguments d'entrée :
% - y : vecteur composé de la position et de la vitesse
%      * x = y(1)         Position
%      * v = y(2)         Vitesse
% - param: parametres du problème
%      * k = param(1)     Constante de rappel du ressort 
%      * m = param(2)     Masse de l'objet accroché au ressort
%      * c = param(3)     constante d'amortissment  
% Arguments de sortie :
% - f : vecteur ligne composé des valeurs des équations différentielles
% __________________________________________________________________

%---------- Assignation des paramètres du problème ----------
k = param(1);%     Constante de rappel du ressort 
m = param(2); %   Masse de l'objet accroché au ressort 
c = param(3);

%---------- Assignation des variables dépendantes ----------
x = y(1); %       Position
v = y(2); %         Vitesse

%---------- Équations différentielles ----------
f =[v,(-k*x - c*v)/m]';
  
end
% Les autres fonctions sont des CLONES des fonctions utilisées pour le
% double pendule, qui utilisent fonc_test() (oscillateur) au lieu de f() 
% (double pendule).
% Fonctions définies:
% EE_test() ; RK4_test() ; Verlet_test ; EI_test ; Jac_test ; Residu_test ;
% energie(x,v,param) (Prise du TD5)
function [t, etat] = EE_test(etat_initial,params,dt,tf)
%_____________________________________________________________
% Fonction 'EE' :
%
% Description :
% La fonction 'EE' trouve les solutions pour les accélérations angulaires (theta_dotdot) et les vitesses angulaires 
% pour un pendule double par la méthode d'Euler explicite. Elle prend en
% entrée l'état initial du système, les paramètres du système étudié, ainsi
% que le pas de temps et la durée de simulation.
%
% Arguments d'entrée : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul (s)
% - tf : Temps de simulation (s)
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% système d'équations différentielles a été évalué, en incluant le temps 0.
% - etat : Matrice 4xn décrivant l'état du système dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] évaluée à
% tous les temps présents dans le vecteur t.

% -------------------------------------------------
% Auteur : Kevin Chau
% Date de création : 02/12/2020
% Dernière modification (v1) : 02/12/2020
% -------------------------------------------------
% _____________________________________________________________

%On initialise les variables
t = 0;
etat = etat_initial;

%On applique la suite de récurrence pendant la durée souhaitée de la
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
% Cette fonction utilise la méthode de Runge Kutta 4 explicite pour 
% résoudre le système d'équations différentielles dy/dt = f(t,y) sur une
% période de temps [0;tf]. Les 4 équations différentielles qui composent
% dy/dt sont les vitesses angualaires theta_dot_1 et theta_dot_2, ainsi que
% les accélérations angulaires theta_dotdot_1 et theta_dotdot_2.
%
% Arguments d'entrée : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
% - tf : Temps de simulation
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% système d'équations différentielles a été évalué, en incluant le temps 0.
% - etat : Matrice 4xn décrivant l'état du système dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] évaluée à
% tous les temps présents dans le vecteur t.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

% On défini d'abord les conditions initiales
t = [0];
etat = [etat_initial];

% Boucle de resolution
while t(end) < tf
    k1 = dt*fonc_test(etat(:,end),params); % Pertinent de noter que f ne dépend pas de t -> f(y)
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
% La fonction 'Verlet' trouve les solutions pour les accélérations angulaires (theta_dotdot) et les vitesses angulaires 
% pour un pendule double par la méthode de Verlet. Elle prend en
% entrée l'état initial du système, les paramètres du système étudié, ainsi
% que le pas de temps et la durée de simulation.
%
% Arguments d'entrée : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul (s)
% - tf : Temps de simulation (s)
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% système d'équations différentielles a été évalué, en incluant le temps 0.
% - etat : Matrice 4xn décrivant l'état du système dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] évaluée à
% tous les temps présents dans le vecteur t.

% -------------------------------------------------
% Auteur : Kevin Chau
% Date de création : 02/12/2020
% Dernière modification (v1) : 02/12/2020
% -------------------------------------------------
% _____________________________________________________________


%Initialisation 
t = 0;
etat = etat_initial;

%On calcule l'accélération initiale
accel = fonc_test(etat_initial,params);
accel = accel(2); % Juste l'élément 2 de la fonction test

while t < tf
    v_half = etat(2,end) + 0.5*dt*accel;
    etat(1,end + 1) = etat(1, end) + dt*v_half; %Calcul de la position au temps t + dt
    accel = fonc_test([etat(1, end) ; v_half], params); %Calcul de la nouvelle accélération
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
% Cette fonction utilise la méthode de Euler implicite pour 
% résoudre le système d'équations différentielles dy/dt = f(t,y) sur une
% période de temps [0;tf]. Les 4 équations différentielles qui composent
% dy/dt sont les vitesses angulaires theta_dot_1 et theta_dot_2, ainsi que
% les accélérations angulaires theta_dotdot_1 et theta_dotdot_2.
% La fonction utilise la méthode Newton-Raphson avec une Jacobienne 
% numérique pour résoudre les équations non-linéaires provenant de la forme
% en différences finies implicites.
%
% Arguments d'entrée : 
% - etat_inital : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% etat = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2] 
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
% - tf : Temps de simulation
%
% Arguments de sortie : 
% - t : Vecteur ligne 1xn contenant les n valeurs de temps auxquelles le 
% système d'équations différentielles a été évalué, en incluant le temps 0.
% - etat : Matrice 4xn décrivant l'état du système dans le temps, soit la
% solution y = [theta_1 ; theta_2 ; theta_dot_1 ; theta_dot_2] évaluée à
% tous les temps présents dans le vecteur t.

% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________


% On défini d'abord les conditions initiales
t = [0];
etat = [etat_initial];

% On defini ensuite les paramètres de résolution d'équations non-linéaires
% par newton-Raphson
N = 1000; % Nombre d'itérations maximales pour résoudre une équation non-linéaire
tol = 1e-7; % Précision visée par la résolution non-linéaire

% Boucle de résolution des équations différentielles
while t(end) < tf
    
    % Début de la résolution du sytème d'équations non-linéaire de
    % différences finies par la méthode de Newton-Raphson
    dx = 1; % Vecteur de correction dx initialisé comme = 1
    it = 0; % Compteur d'itérations
    xi = etat(:,end);
    if any(xi == 0) % Cette condition assure que les estimés initiaux ne comportent pas de zéros, ce qui crée des erreurs dans la jacobienne
        x = xi + 0.01*ones(2,1);
    else
        x = xi;
    end
    % Boucle de résolution non-linéaire
    while norm(dx) > tol && it < N
        R = Residu_test(x,xi,dt,params);
        J = Jac_test(x,xi,dt,params,tol);
        dx = J\-R;
        x = x + dx;
        it = it+1;
    end    
    % Stockage des valeurs trouvées par Newton-Raphson
    etat(:,end+1) = x;
    t(end+1) = t(end) + dt;
    
end

end % Clone de EI
function [J] = Jac_test(x_tdt,x_t,dt,params,tol)
% _____________________________________________________________ 
% Fonction 'Jac' :
%
% Description : 
% Cette fonction calcule la Jacobienne numérique d'une équation
% non-linéaire, comme utilisée dans la méthode de résolution
% Newton-Raphson. Pour estimer la jacobienne, on utilise un vecteur
% perturbé.
%
% Arguments d'entrée : 
% - x_tdt : Vecteur colonne 4x1 contenant les
% valeurs au temps t+dt des deux angles et des deux vitesses telles que 
% x_tdt = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - x_t : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% x_t = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
% - tol : Tolérance, valeur très petite utilisée comme perturbation pour le
% calcul de la Jacobienne numérique.
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
    % Calcul du vecteur perturbé
    etat_perturb = x_tdt;
    etat_perturb(i) = etat_perturb(i) + etat_perturb(i)*tol;
    
    % Remplissage de la Jacobienne numérique
    J(:,i) = (Residu_test(etat_perturb,x_t,dt,params) - Residu_test(x_tdt,x_t,dt,params))/(x_tdt(i)*tol);
end

end % Clone de Jac
function [R] = Residu_test(x_tdt,x_t,dt,params)
% _____________________________________________________________ 
% Fonction 'Residu' :
%
% Description : 
% Cette fonction calcule l'expression R = x_t+dt - dt*f(x_t) - x_t, pour
% des valeurs de x aux temps t et t+dt, et une fonction f(x) qui évalue la
% dérivée temporelle du vecteur x.
% Cette valeur correspond au résidu d'une équation non-linéaire, comme
% celle qui apparaît dans la méthode de résolution d'équations
% différentielles par Euler Implicite.
%
% Arguments d'entrée : 
% - x_tdt : Vecteur colonne 4x1 contenant les
% valeurs au temps t+dt des deux angles et des deux vitesses telles que 
% x_tdt = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - x_t : Vecteur colonne 4x1 contenant les
% valeurs initiales des deux angles et des deux vitesses telles que 
% x_t = [theta1 ; theta2 ; theta_dot_1 ; theta_dot_2]
% - params : Vecteur ligne 9x1 contenant les paramètre statiques du 
% problème tels que params = [l1,l2,I1,I2,m1,m2,k1,k2,g]
% - dt : Pas de temps en choisi pour le calcul 
%
% Arguments de sortie : 
% - R : Vecteur colonne 4x1 du résidu.

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
% Arguments d'entrée :
% - x : vecteur position
% - v : vecteur vitesse
% - param : vecteur des paramètres des équations différentielles
%          * k = param(1)     Constante de rappel du ressort 
%          * m = param(2)     Masse de l'objet accroché au ressort 
% Arguments de sortie :
% - E : vecteur composé de l'énergie du système (vecteur ligne)
% __________________________________________________________________

%---------- Assignation des paramètres ----------
k = param(1);%     Constante de rappel du ressort 
m = param(2);%     Masse de l'objet accroché au ressort 

%---------- Calcul de l'énergie ----------
E = [0.5*m*v.^2 + k*0.5*x.^2]' ;
     
end % Cette fonction est prise du TD5!
