% _____________________________________________________________ 
% Programme 'tests_convergence' :
%
% Description : 
% Ce script sert à calculer comment les différentes méthodes sont affectées
% par le pas de temps dt. Il simule le double pendule pendant une seconde à
% 6 pas de temps différent, et produit un graphe démontrant l'évolution des
% solutions.
%
% ATTENTION! Ce programme prend plusieurs minutes à simuler, il est
% déconseillé au correcteur de l'essayer.
%
% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 4/12/2020
% -------------------------------------------------
% _____________________________________________________________

l1 = 1 ; l2 = 1;
I1 =  1; I2 = 1;
m1 = 10 ; m2 = 10;
k1 = 0 ; k2 = 0;
g = 9.81;
tf = 1;
dt = [0.1 0.01 0.001 0.0001 0.00001 0.000001];

params = [l1,l2,I1,I2,m1,m2,k1,k2,g,tf,dt,trajectoires];
etat_initial = [[3*pi/4;3*pi/4;0;0]];
sols_theta_1 = [];
sols_theta_dot_1 = [];
for i = dt
    [t_ee, sol_ee] = EE(etat_initial,params,i,tf);
    [t_ei, sol_ei] = EI(etat_initial,params,i,tf);
    [t_ver, sol_ver] = Verlet(etat_initial,params,i,tf);
    [t_rk4, sol_rk4] = RK4(etat_initial,params,i,tf);
    sols_theta_1(:,end+1) = [sol_ee(1,end);sol_ei(1,end);sol_ver(1,end);sol_rk4(1,end)];
    sols_theta_dot_1(:,end+1) = [sol_ee(2,end);sol_ei(2,end);sol_ver(2,end);sol_rk4(2,end)];
end

semilogx(dt,sols_theta_1)
set(gca,'XDir','Reverse')
title("Valeur de theta_1 à 1 s selon le pas de temps")
xlabel("dt (s)")
ylabel("theta_1 (rad)")
legend("Euler explicite","Euler Implicite","Verlet","RK4")