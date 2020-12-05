l1 = 1 ; l2 = 1;
I1 =  1; I2 = 1;
m1 = 10 ; m2 = 10;
k1 = 0 ; k2 = 0;
g = 9.81;
tf = 1;
dt = [0.1 0.05 0.025 0.025/2 0.025/4];
params = [l1,l2,I1,I2,m1,m2,k1,k2,g,tf,dt,trajectoires];
etat_initial = [[3*pi/4;3*pi/4;0;0]];
sols = [];
for i = dt
    [t_ee, sol_ee] = EE(etat_initial,params,i,tf);
    [t_ei, sol_ei] = EI(etat_initial,params,i,tf);
    [t_ver, sol_ver] = Verlet(etat_initial,params,i,tf);
    [t_rk4, sol_rk4] = RK4(etat_initial,params,i,tf);
    sols(:,end+1) = [sol_ee(:,end);sol_ei(:,end);sol_ver(:,end);sol_rk4(:,end)]; 
end



