% _____________________________________________________________ 
% Fonction 'animate' :
%
% Description : 
% Cette fonction sans arguments lance l'animation des pendules et des
% graphes d'�nergie. Il est crucial de lancer le programme 'main' avant.
%
% ------------------------------------------------- 
% Auteur : Thomas John Beeson 
% Date : 30/11/2020
% -------------------------------------------------
% _____________________________________________________________

function animate(pendules,dt,enregistrement)

global params

if enregistrement % Initialiser l'enregistrement
    set(gcf,'visible','off')
    filename = input("Veuillez entrer le nom du fichier � enregistrer : ",'s');
    % On assure la bonne extension au fichier
    if length(filename) < 5 | all(filename([end-3:end]) ~= '.mp4')
        filename = [filename '.mp4'];
    end
    % Cr�ation du fichier
    vidfile = VideoWriter(filename,'MPEG-4');
    vidfile.FrameRate = 1/dt; % On veut un framerate correspondant � la r�alit� physique
    open(vidfile);
end

% Boucle de l'animation
for frame = 1:length(pendules{1}{2}) 
    for obj = 1:size(pendules,2) % On veut s�lectionner tous les pendules � animer
        set(pendules{obj}{1}(1),'XData',[0,pendules{obj}{2}(frame)],'YData',[0 pendules{obj}{3}(frame)])
        set(pendules{obj}{1}(2),'XData',[pendules{obj}{2}(frame),pendules{obj}{4}(frame)],'YData',[pendules{obj}{3}(frame),pendules{obj}{5}(frame)])
        set(pendules{obj}{1}(3),'XData',pendules{obj}{2}(frame),'YData',pendules{obj}{3}(frame))
        set(pendules{obj}{1}(4),'XData',pendules{obj}{4}(frame),'YData',pendules{obj}{5}(frame))
        addpoints(pendules{obj}{1}(5),pendules{obj}{13}(frame),pendules{obj}{14}(frame))
        if params(12) % Tracer trajectoires ou pas (true/false)
            addpoints(pendules{obj}{1}(6),pendules{obj}{4}(frame),pendules{obj}{5}(frame))
        end
        drawnow limitrate
 
    end
    
    if enregistrement
        frame = getframe(gcf); % On capture le "frame"
        writeVideo(vidfile,frame) % On �crit le "frame" dans le fichier vid�o
    end
    pause(0.01)
end

if enregistrement
    set(gcf,'visible','on')
    close(vidfile);
end

end