addpath(genpath('../../../../utils/'));
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')

clear all 
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                DATA EXCTRACTION               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lambdas = [0.01, 0.05, 0.1, 0.2];

% Creo una struct. Ogni elemento di questa struct rappresenta un
% esperimento di depressurizzazione. Esiste un field principale detto
% raw_data
data = struct([]);

for i=1:length(lambdas)
    filename = sprintf("../lambda_%s/out/data.csv", string(lambdas(i)));
    new = readtable(filename);
    data(i).lambda = lambdas(i);
    data(i).raw_data = new;
end

% Per ogni esperimento creo un field con dati di interesse
for i=1:length(lambdas)
    data(i).time = table2array(data(i).raw_data(:,1));  % [s]
    data(i).power = table2array(data(i).raw_data(:,2)); % [kW]
    data(i).outlet_temperature = table2array(data(i).raw_data(:,3));   % [°K]
    data(i).max_fuel_temp_bct = table2array(data(i).raw_data(:,4:6));  % [°K]
    data(i).max_clad_temp_bct = table2array(data(i).raw_data(:, 7:9)); % [°K]
    data(i).center_radial_temp_profile = table2array(data(i).raw_data(:, 10:20)); % [°K]
    data(i).max_fuel_temp_axial = table2array(data(i).raw_data(:,22:71)); % [°K]
end

% ---- TOTAL POWER -----
figure('Position', [10 10 900 900])
hold on
plot(data(1).time,data(1).power, 'LineWidth', 1.3);
plot(data(2).time,data(2).power, 'LineWidth', 1.3);
plot(data(3).time,data(3).power, 'LineWidth', 1.3);
plot(data(4).time,data(4).power, 'LineWidth', 1.3);
grid on, grid minor
xlabel('Time [s]')
title('TOTAL POWER EXCHANGED [kW]')


% ----- ANIMATION PROFILE MAX TEMP FUEL -------
% figure('Position', [10 10 300 900])
% axial_plot(horzcat(data(1).time, data(1).max_fuel_temp_axial), true, 'Animation Profile - Max Fuel Temperature', 'Fuel Temperature [K]', 3000)







