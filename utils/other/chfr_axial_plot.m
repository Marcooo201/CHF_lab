function [] = chfr_axial_plot(data, animate, title_string, xlable_string, xlim_value)
% La funzione richiede i seguenti input:
%
%   - data: array contenente i dati che si vogliono plottare.
%           Se Ã¨ un'animazione richiede una matrice, se non
%           lo Ã¨ serve un'array monodimensionale
%
%   - animate: booleano che indica se si vuole l'animazione o no

if animate
    time = data(:,1);
    data = data(:,2:end);
    h = animatedline('LineWidth', 1.5, 'Color', 'r');
    grid on
    grid minor
    ylim([1/length(data) 1])
    xlim([0 xlim_value])
    xlabel(xlable_string)
    title(title_string)
    for i=2:length(time)
        clearpoints(h);
        addpoints(h, data(i,:), (1:length(data(i,:)))./length(data(i,:)));
        drawnow nocallbacks

        dim = [.5 .1 .1 .1];
        timestep = num2str(time(i));
        str = strcat('TIME:',{'  '}, timestep(1:4), ' s');
        annotation('textbox',dim,'String',str, 'FitBoxToText','on', 'BackgroundColor','w');

        %pause(0.1)
    end
else
    look(:)=(data==12.34567);
    data(look==1)=NaN;
    plot(data,(1:length(data))./length(data), 'LineWidth', 1.5, 'Color', 'r')
    data(look==1)=12.34567;
    if(sum(data)==12.34567*length(data))
        patch([0 xlim_value xlim_value 0], [0 0 length(data) length(data)]./length(data), [143 143 143]./255, 'LineStyle', 'none')
    else
        logic=find(data~=12.34567)
        hold on
        patch([0 xlim_value xlim_value 0], [0 0 logic(1) logic(1)]./length(data), [143 143 143]./255, 'LineStyle', 'none')
        if(logic(1)-0~=0)
            text(xlim_value/2-5, (logic(1)+0)./(2*length(data)), 'UNDEFINED','FontSize',10,'FontWeight','bold')
        end
        patch([0 xlim_value xlim_value 0], [logic(end) logic(end) length(data) length(data)]./length(data), [143 143 143]./255, 'LineStyle', 'none')
        if(length(data)-logic(end)~=0)
            text(xlim_value/2-5, (length(data)+logic(end))./(2*length(data)), 'UNDEFINED','FontSize',10,'FontWeight','bold')
        end
        for i=1:length(logic)-1
            if(logic(i+1)-logic(i)~=1)
                patch([0 xlim_value xlim_value 0], [logic(i) logic(i) logic(i+1) logic(i+1)]./length(data), [143 143 143]./255, 'LineStyle', 'none')
                text(xlim_value/2-5, (logic(i+1)+logic(i))./(2*length(data)), 'UNDEFINED','FontSize',10,'FontWeight','bold')
            end
        end
    end
    hold off
    alpha(.30)
    ylim([1/length(data) 1])
    xlim([0 xlim_value])
    xlabel(xlable_string)
    title(title_string)
    grid on
    grid minor
end
end
