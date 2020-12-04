function y = analytique(x)
  
% __________________________________________________________________
% Fonction 'analytique' :
% Argument d'entrée :
% - x : vecteur composé des valeurs de la variable dépendante
% Arguments de sortie :
% - y : vecteur de la solution de l'équation différentielle y(x)
% __________________________________________________________________

y = 2.4 - 0.4*exp(-(10/1000)*x);

end