function [choix] = disp_menu(options,title)
width = 30; % Largeur du menu
slct = false;
while ~slct % Le menu recommence tant qu'une option n'est pas s�lectionn�e
    clc
    fprintf([title '\n'])
    bar(1:width) = '*';
    fprintf([bar '\n'])
    for i = 1:length(options)
        blank = [];
        blank(1:width-7-length(options{i})) = ' ';
        line = ['* ' num2str(i) ' - ' options{i} blank '*' '\n'];
        fprintf(line)
    end
    fprintf([bar '\n'])
        choix = str2num(input('Veuillez s�lectionner une option : ','s'));
    if ~isempty(choix) && any(choix == [1:length(options)]) % l'option choisie doit �tre num�rique et dans les choix
        slct = true;
    else
        fprintf("S�lectionnez une option valide!")
        pause(0.5)
        fprintf('.')
        pause(0.5)
        fprintf('.')
        pause(0.5)
        fprintf('.')
        pause(0.5)
    end
end
end