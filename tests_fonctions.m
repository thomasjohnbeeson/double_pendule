%Cette fonction sert à effectuer des tests sur les fonctions du projet

% TEST DE LA FONCTION f.m

    % Définition de paramètres
    l1 = 1.5 ; l2 = 2;
    I1 = 10 ; I2 = 20;
    m1 = 5 ; m2 = 2;
    k1 = 3 ; k2 = 5;
    g = 9.81;
    params = [l1,l2,I1,I2,m1,m2,k1,k2,g];

    %etat = [pi/2;pi/2;1;1];
    %tdd = f(etat,params);

    %tdd1_coup = f_coup_1(etat(1:2),etat(3:4),tdd(4),params);

    %tdd(3) - tdd1_coup;
    

% TEST DE LA FONCTION RK4

etat_initial = [pi/2;pi/2;0;0];
tf = 120;
dt = 0.01;

[t,etat] = RK4(etat_initial,params,dt,tf);
plot(t,etat)
legend("theta_1","theta_2","theta_dot_1","theta_dot_2")





