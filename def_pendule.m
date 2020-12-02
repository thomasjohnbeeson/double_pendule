function [pendule_obj] = def_pendule(x1_i,y1_i,x2_i,y2_i,couleur)

pendule_obj = [line([0,x1_i],[0 y1_i],'LineStyle','-','Color',couleur,'LineWidth',2) , ... % Tige 1
                      line([x1_i,x2_i],[y1_i,y2_i],'LineStyle','-','Color',couleur,'LineWidth',2) , ... % Tige 2
                      line(x1_i,y1_i,'Marker','.','LineStyle','none','Color',couleur,'MarkerSize',30) , ... % Masse 1
                      line(x2_i,y2_i,'Marker','.','LineStyle','none','Color',couleur,'MarkerSize',30)]; % Masse 2
                  
end