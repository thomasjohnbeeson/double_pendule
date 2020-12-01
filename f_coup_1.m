function [theta_dotdot_1] = f_coup_1(theta,theta_dot,theta_dotdot_2,params)

    % Cette fonction évalue la valeur de theta_dotdot 1 en utilisatn l'équation
    % couplée. Elle doit être utilisée pour vérifier que la fonction f est la
    % bonne.

    %paramètres statiques
    l1 = params(1) ; l2 = params(2);
    I1 = params(3) ; I2 = params(4);
    m1 = params(5) ; m2 = params(6);
    k1 = params(7) ; k2 = params(8);
    g = params(9)  ;
    
    % Équation
    theta_dotdot_1 = ( - k1*theta_dot(1)...
                       + k2*theta_dot(2)...
                       - g*l1*sin(theta(1))*(m1+m2)...
                       - theta_dotdot_2*m2*l1*l2*cos(theta(1)-theta(2))...
                       - theta_dot(2)^2*m2*l1*l2*sin(theta(1)-theta(2))...
                     ) / (I1 + m1*l1^2 + m2*l2^2);
    
    
end