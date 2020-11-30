function [theta_dotdot] = f(theta,theta_dot,params)
    % Cette fonction calcule l'expression des accélérations angulaires
    % découplées à partir de paramètres d'angle, de vitesse angulaire et
    % des paramètres statiques du problème
    
    % Paramètres statiques
    l1 = params(1) ; l2 = params(2);
    I1 = params(3) ; I2 = params(4);
    m1 = params(5) ; m2 = params(6);
    k1 = params(7) ; k2 = params(8);
    
    % Équations découplées
    theta_dotdot = zeros(2,1);
    theta_dotdot(1) = -k1*theta_dot(1)*(I2)

end
    
    