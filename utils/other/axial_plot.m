function [] = axial_plot(data, animate, title_string, xlable_string, xlim_value)
% La funzione richiede i seguenti input:
%
%   - data: array contenente i dati che si vogliono plottare.
%           Se è un'animazione richiede una matrice, se non 
%           lo è serve un'array monodimensionale
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
    plot(data,(1:length(data))./length(data), 'LineWidth', 1.5, 'Color', 'r')
    ylim([1/length(data) 1])
    xlim([0 xlim_value])
    xlabel(xlable_string)
    title(title_string)
    grid on
    grid minor
end
end

