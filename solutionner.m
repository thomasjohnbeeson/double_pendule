function solutionner
global pendules
global params
global etat_initial

% Cette solutionne chaque pendule un par un
for i = 1:size(pendules,2)
            switch pendules{i}{6}
                case "EE" % Ce pendule utilise EE
                    [t, etat] = EE(etat_initial(:,pendules{i}{7}),params,params(11),params(10));
                    [x1 y1 x2 y2] = position(etat,params);
                    pendules{i}{2} = x1 ; pendules{i}{3} = y1 ; pendules{i}{4} = x2 ; pendules{i}{5} = y2 ; % On stocke les solutions dans les objets pendules 
                
                case "EI" % Ce pendule utilise EI
                    [t, etat] = EI(etat_initial(:,pendules{i}{7}),params,params(11),params(10));
                    [x1 y1 x2 y2] = position(etat,params);
                    pendules{i}{2} = x1 ; pendules{i}{3} = y1 ; pendules{i}{4} = x2 ; pendules{i}{5} = y2 ; % On stocke les solutions dans les objets pendules
                
                case "Verlet" % Ce pendule utilise Verlet
                    [t, etat] = Verlet(etat_initial(:,pendules{i}{7}),params,params(11),params(10));
                    [x1 y1 x2 y2] = position(etat,params);
                    pendules{i}{2} = x1 ; pendules{i}{3} = y1 ; pendules{i}{4} = x2 ; pendules{i}{5} = y2 ; % On stocke les solutions dans les objets pendules
                
                case "RK4" % Ce pendule utilise RK4
                    [t, etat] = RK4(etat_initial(:,pendules{i}{7}),params,params(11),params(10));
                    [x1 y1 x2 y2] = position(etat,params);
                    pendules{i}{2} = x1 ; pendules{i}{3} = y1 ; pendules{i}{4} = x2 ; pendules{i}{5} = y2 ; % On stocke les solutions dans les objets pendules
            end
            
        end

end