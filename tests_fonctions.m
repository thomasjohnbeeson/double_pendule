
% PROGRAMME DE TEST SEULEMENT!!!
clc
clear all

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
tf = 40;
dt = 0.001;

[t_rk4,etat_rk4] = RK4(etat_initial,params,dt,tf);
[t_ei,etat_ei] = EI(etat_initial,params,dt,tf)

figure
hold on
plot(t_rk4,etat_rk4(1:2,:))
plot(t_ei,etat_ei(1:2,:))
legend("theta_1 RK4","theta_2 RK4","theta_1 EI","theta_2 EI")





