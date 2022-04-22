addpath(genpath('../../../utils/'));
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                DATA EXCTRACTION               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data = readtable('../out/data.csv');

% -----TIME-----
time = data.time;
% ----TOTAL POWER -----
power = data.cntrlvar110;
% ----OUTLET TEMPERATURE ---
T_out = data.tempf555500000;

% ----- MAX FUEL TEMP -----
T_fuel_max_do = data.httemp555000101;
T_fuel_max_med = data.httemp555002501;
T_fuel_max_up = data.httemp555005001;

% ----- MAX CLAD TEMP -----
T_clad_max_do = data.httemp555000108;
T_clad_max_med = data.httemp555002508;
T_clad_max_up = data.httemp555005008;


% ---- MIDDLE FUEL ROD RADIAL TEMPERATURE PROFILE ----
T_profile = data(:,{'httemp555002501', ...
                    'httemp555002502', ...
                    'httemp555002503', ...
                    'httemp555002504', ...
                    'httemp555002505', ...
                    'httemp555002506', ...
                    'httemp555002507', ...
                    'httemp555002508', ...
                    'httemp555002509', ...
                    'httemp555002510', ...
                    'tempf555250000', ...
                    'time'});

% ---- PRESSURE DROP ----
p_drop = data.cntrlvar120;

% ---- AXIAL PROFILE MAX FUEL TEMPERATURE ----
T_max_fuel_axial = table2array(data);
T_max_fuel_axial = T_max_fuel_axial(201,22:70);

% ---- AXIAL PROFILE HT MODE ------
HTMODE_axial = table2array(data);
HTMODE_axial = HTMODE_axial(201, 71:120);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                            %
%                           PLOTS                            %
%                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ----TOTAL POWER -----
figure('Position', [10 10 900 900])
plot(time,power, 'LineWidth', 1.3, 'Color', 'r');
xlabel('Time [s]')
title('TOTAL POWER EXCHANGED [kW]')

% ----OUTLET TEMPERATURE --
figure('Position', [10 10 900 900])
plot(time,T_out, 'LineWidth', 1.3, 'Color', 'r');
xlabel('Time [s]')
title('OUTLET TEMPERATURE [K]')

% ----- MAX FUEL TEMP -----
figure('Position', [10 10 900 900])
hold on
plot(time,T_fuel_max_do, 'LineWidth', 1.3, 'Color', 'b');
plot(time,T_fuel_max_med, 'LineWidth', 1.3, 'Color', 'g');
plot(time,T_fuel_max_up, 'LineWidth', 1.3, 'Color', 'r');
hold off
legend('bottom', 'center', 'top')
xlabel('Time [s]')
title('MAX FUEL TEMPERATURE [K]')

% ----- MAX CLAD TEMP -----
figure('Position', [10 10 900 900])
hold on
plot(time,T_clad_max_do, 'LineWidth', 1.3, 'Color', 'b');
plot(time,T_clad_max_med, 'LineWidth', 1.3, 'Color', 'g');
plot(time,T_clad_max_up, 'LineWidth', 1.3, 'Color', 'r');
hold off
legend('bottom', 'center', 'top')
xlabel('Time [s]')
title('MAX CLAD TEMPERATURE [K]')

% ----- AXIAL PROFILE MAX TEMP FUEL -------
figure('Position', [10 10 300 900])
axial_plot(T_max_fuel_axial, false, false, 'Axial Profile - Max Fuel Temperature', 'Fuel Temperature [K]', 3000)


% ----- AXIAL PROFILE HTMODE -------
figure('Position', [10 10 300 900])
axial_plot(HTMODE_axial, false, true, 'Axial Profile - Heat Transfer Mode', '', 1)

% figure(10)
% radial_plot_fuel(table2array(T_profile), true, 'pwr')