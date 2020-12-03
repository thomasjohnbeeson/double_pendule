function modif_CI(ci)

global etat_initial

% On crée le menu de commande qui va apparaître, à partir des
% conditions initiales actuelles
cond_a_modif = strings([1 4*size(ci,2)]);
default_values = strings([1 4*size(ci,2)]);
for i = 1:length(ci)
    cond_a_modif((i-1)*4 + 1) = ['C' num2str(ci(i)) ' : theta_1'];
    default_values((i-1)*4 + 1) = num2str(etat_initial(1,ci(i)));
    cond_a_modif((i-1)*4 + 2) = ['C' num2str(ci(i)) ' : theta_2'];
    default_values((i-1)*4 + 2) = num2str(etat_initial(2,ci(i)));
    cond_a_modif((i-1)*4 + 3) = ['C' num2str(ci(i)) ' : theta_dot_1'];
    default_values((i-1)*4 + 3) = num2str(etat_initial(3,ci(i)));
    cond_a_modif((i-1)*4 + 4) = ['C' num2str(ci(i)) ' : theta_dot_2'];
    default_values((i-1)*4 + 4) = num2str(etat_initial(4,ci(i)));
end

slct = false;
while ~slct
    nouv_ci = inputdlg(cond_a_modif,'Modifier les conditions initiales',[1 35],default_values);
    slct = true;
    % On vérifie ensuite les entrée
    for i = 1:length(nouv_ci)
        if isempty(str2num(nouv_ci{i})) | length(str2num(nouv_ci{i})) ~= 1 % indique une entrée multiple ou un "string"
            slct = false;
        end
    end
    if ~slct
        fprintf('Veuillez entrer des valeurs numériques uniques')
        pause(2)
    end
end

% On a des entrées valides, on remplace les CI par les nouvelles
% valeurs

for i = 1:length(nouv_ci)
    etat_initial((min(ci)-1)*4 + i) = str2num(nouv_ci{i});
end

end