data = readtable('data.csv');

t = table2array(data(:,1));
p = table2array(data(:, 2:51));
T = table2array(data(:, 52:101));

h = animatedline(T(1,:), 1:50, 'LineWidth', 1.5, 'Color', 'k');
ylim([1 50]);
xlim([173 800]);

for i = 1:length(t)
    i
    clearpoints(h);
    addpoints(h, T(i,:), 1:50);
    drawnow nocallbacks
    exportgraphics(gca,"movie.gif","Append",true)
    %pause(0.5)
end






%
% temp = data.tempf555170000;
%
% figure(1)
% plot(temp, 1:length(temp), 'LineWidth', 1.5, 'Color', 'k')
% ylim([3 length(temp)])
% xlim([273 700])
