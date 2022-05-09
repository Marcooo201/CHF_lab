addpath(genpath('../../../../utils/'));
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')

clear all 
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                DATA EXCTRACTION               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lambdas = [0.01, 0.05, 0.1, 0.2];
scram_time = 101; % [s]

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
    data(i).ht_mode_axial = table2array(data(i).raw_data(:,72:121)); % []
    data(i).heat_flux_axial = table2array(data(i).raw_data(:,122:171))./1000; % [kW/m2]
    data(i).htc_axial = table2array(data(i).raw_data(:,172:221))./1000; % [kW/m2/°K]
    data(i).flow_regimes_axial = table2array(data(i).raw_data(:,222:271));  % []
    data(i).void_fraction_axial = table2array(data(i).raw_data(:,272:321)); % []
    data(i).quality_axial = table2array(data(i).raw_data(:,322:371));       % []
    data(i).enthalpy_f_axial = table2array(data(i).raw_data(:,372:421));    % [J/kg] (entalpia del LIQUIDO SATURO)
    data(i).pressure_axial = table2array(data(i).raw_data(:,422:471));      % [Pa]

    % CALCOLO CHF_W3 (devo fare un loop per come è implementata la
    % correlazione (richiede vettori, non matrici)
    for j=1:length(data(i).time)
        data(i).CHF_W3 = CHF_W3(data(i).pressure_axial(j,:), data(i).quality_axial(j,:), 0.335, data(i).enthalpy_f_axial(j,:), data(i).heat_flux_axial(j,:), 8.79e-5, 1.17808e-2, 3.876); % [kW/m2]
    end

    data(i).CHFR = data(i).CHF_W3./data(i).heat_flux_axial;
    data(i).CHF_W3 = data(i).CHF_W3(:,1:48);
    data(i).CHFR = data(i).CHFR(:,1:48);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                            %
%                           PLOTS                            %
%                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% ------ LEGEND LABELS -------
labels = [];
for i=1:length(lambdas)
    new = sprintf("\\lambda = %s", string(lambdas(i)));
    labels = [labels new];
end
labels = [labels "SCRAM"];



% ------ TOTAL POWER -------
f = figure('Position', [10 10 900 900], 'Visible','off');
hold on
for i=1:length(data)
    plot(data(i).time,data(i).power, 'LineWidth', 1.3);
end
xline(scram_time, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'k')
hold off
grid on, grid minor
xlabel('Time [s]')
title('TOTAL POWER EXCHANGED [kW]')
legend(labels)
%saveas(f, "TOTAL POWER.png")


% --- -OUTLET TEMPERATURE ----
figure('Position', [10 10 900 900])
hold on
for i=1:length(data)
    plot(data(i).time,data(i).outlet_temperature, 'LineWidth', 1.3);
end
xline(scram_time, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'k')
hold off
grid on, grid minor
xlabel('Time [s]')
title('OUTLET TEMPERATURE [K]')
legend(labels)




% ---- MAX FUEL TEMPERATURE ----
figure('Position', [10 10 900 900])
hold on
for i=1:length(data)
    plot(data(i).time,max(data(i).max_fuel_temp_axial, [], 2), 'LineWidth', 1.3);
end
xline(scram_time, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'k')
hold off
grid on, grid minor
xlabel('Time [s]')
title('MAX FUEL TEMPERATURE [K]')
legend(labels)


% ------- MDNBR -------
figure('Position', [10 10 900 900])
hold on
for i=1:length(data)
    plot(data(i).time,min(data(i).CHFR, [], 2), 'LineWidth', 1.3);
end
xline(scram_time, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'k')
hold off
grid on, grid minor
xlabel('Time [s]')
title('MDNBR (W-3 Correlation)')
legend(labels)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    ANIMATIONS                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ----- PROFILE CHFR -------
% idx = 2;
% figure('Position', [10 10 300 900])
% axial_plot(horzcat(data(idx).time, data(idx).CHFR), true, 'Animation Profile - CHFR (W3)', 'CHFR', 10)

% 
% % ----- PROFILE HTMODE -------
% idx = 1;
% f0 = 180; % initial frame (timestep)
% figure('Position', [10 10 300 900])
% htmode_plot(horzcat(data(idx).time(f0:end,:), data(idx).ht_mode_axial(f0:end,:)), true, 'Animation Profile - Heat Transfer Mode', '', 1)
%
% % ----- PROFILE HTC -------
% idx = 1;
% f0 = 1; % initial frame (timestep)
% figure('Position', [10 10 300 900])
% axial_plot(horzcat(data(idx).time(f0:end,:), data(idx).htc_axial(f0:end,:)), true, 'Animation Profile - HTC [kW/m^2/°K]', 'HTC [kW/m^2/°K]', 60)
%
% % ----- PROFILE VOID FRACTION -------
% idx = 1;
% f0 = 1; % initial frame (timestep)
% figure('Position', [10 10 300 900])
% axial_plot(horzcat(data(idx).time(f0:end,:), data(idx).void_fraction_axial(f0:end,:)), true, 'Animation Profile - Void Fraction ( \alpha )', 'Void Fraction ( \alpha )', 1)
%
% % ----- PROFILE RADIAL TEMPERATURE -------
% idx = 1;
% f0 = 1; % initial frame (timestep)
% figure(10)
% radial_plot_fuel(horzcat(data(idx).center_radial_temp_profile, data(idx).time), true, 'pwr')




