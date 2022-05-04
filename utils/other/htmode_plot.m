function [] = htmode_plot(data, animate, title_string, xlable_string, xlim_value)
% La funzione richiede i seguenti input:
%
%   - data: array contenente i dati che si vogliono plottare.
%           Se è un'animazione richiede una matrice, se non 
%           lo è serve un'array monodimensionale. La prima colonna 
%           della matrice è quella del timestep
%
%   - animate: booleano che indica se si vuole l'animazione o no
%
%   - htmode: è un booleano che indica se i dati da plottare indicano
%             il tipo di heat transfer 

ht_colors = [[3 132 252]; [3 132 252]; [99 214 71]; [99 214 71]; [242 236 65]; [242 236 65]; [255 52 41]; [255 52 41]; [235 52 225]]./255;
ht_texts = ["", "", "", "SAT", "", "SAT", "", "SAT", "VAP"];

if animate
    time = data(:,1);
    data = data(:,2:end);
    for i=2:length(time)
        patch([55 100 100 55], [0 0 1 1], [1 1 1])
        patch([0 45 45 0], [0 0 1 1], [1 1 1])
        hold on
        for j=1:length(data(i,:))
          patch([0 100 100 0], [j-1 j-1 j j]./length(data(i,:)), ht_colors(data(i,j),:), 'LineStyle', 'none')
          text(20,(i-0.5)/length(data),ht_texts(data(i)), 'FontSize', 8, 'FontWeight','bold')
          text(70,(i-0.5)/length(data),ht_texts(data(i)), 'FontSize', 8, 'FontWeight','bold')
        end
        hold off
        alpha(.75)
        patch([45 55 55 45], [0 0 1 1], [173 173 173]./255)
        patch([47 53 53 47], [0 0 1 1], 'k')
        title(title_string)

        dim = [.35 0 .1 .1];
        timestep = num2str(time(i));
        str = strcat('TIME:',{'  '}, timestep(1:4), ' s');
        annotation('textbox',dim,'String',str, 'FitBoxToText','on', 'BackgroundColor','w');

        drawnow 
    end
    
else
    data = floor(data);
    hold on
    for i=1:length(data)
        patch([0 100 100 0], [i-1 i-1 i i]./length(data), ht_colors(data(i),:), 'LineStyle', 'none')
        text(20,(i-0.5)/length(data),ht_texts(data(i)), 'FontSize', 8, 'FontWeight','bold')
        text(70,(i-0.5)/length(data),ht_texts(data(i)), 'FontSize', 8, 'FontWeight','bold')
    end
    hold off
    alpha(.75)
    patch([45 55 55 45], [0 0 1 1], [173 173 173]./255)
    patch([47 53 53 47], [0 0 1 1], 'k')
    title(title_string)
end
end

