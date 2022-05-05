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
T_profile = table2array(T_profile);

% ---- PRESSURE DROP ----
p_drop = data.cntrlvar120;

% ---- AXIAL PROFILE MAX FUEL TEMPERATURE ----
T_max_fuel_axial = table2array(data);
T_max_fuel_axial = T_max_fuel_axial(:,22:71);

% ---- AXIAL PROFILE HT MODE ------
HTMODE_axial = table2array(data);
HTMODE_axial = HTMODE_axial(:, 72:121);

% ---- HEAT FLUX [kW/mq] ------
heat_flux_axial = table2array(data);
heat_flux_axial = heat_flux_axial(:,122:171)./1000;

% -------- HTC [kW/mq/K]--------
htc_axial = table2array(data);
htc_axial = htc_axial(:, 172:221)./1000;

% ---- FLOW REGIMES ----
flow_reg_axial = table2array(data);
flow_reg_axial = flow_reg_axial(:, 222:271);

% ---- VOID FRACTION ----
void_axial = table2array(data);
void_axial = void_axial(:, 272:321);


% ---- AXIAL CHFR ------
% chfr = table2array(data);
% chfr = chfr(:,122:171);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                            %
%                           PLOTS                            %
%                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---- TOTAL POWER -----
figure('Position', [10 10 900 900])
plot(time,power, 'LineWidth', 1.3, 'Color', 'r');
str = strcat({'   '}, num2str(power(end),3));
text(time(end), power(end), str, "FontSize", 12, 'FontWeight','bold');
grid on, grid minor
xlabel('Time [s]')
title('TOTAL POWER EXCHANGED [kW]')

% --- -OUTLET TEMPERATURE ----
figure('Position', [10 10 900 900])
plot(time,T_out, 'LineWidth', 1.3, 'Color', 'r');
str = strcat({'   '}, num2str(T_out(end),3));
text(time(end), T_out(end), str, "FontSize", 12, 'FontWeight','bold');
grid on, grid minor
xlabel('Time [s]')
title('OUTLET TEMPERATURE [K]')

% ----- MAX FUEL TEMP -----
figure('Position', [10 10 900 900])
hold on
plot(time,T_fuel_max_do, 'LineWidth', 1.3, 'Color', 'b');
plot(time,T_fuel_max_med, 'LineWidth', 1.3, 'Color', 'g');
plot(time,T_fuel_max_up, 'LineWidth', 1.3, 'Color', 'r');
hold off
str = strcat({'   '}, num2str(T_fuel_max_med(end),3));
text(time(end), T_fuel_max_med(end), str, "FontSize", 12, 'FontWeight','bold');
str = strcat({'   '}, num2str(T_fuel_max_do(end),3));
text(time(end), T_fuel_max_do(end), str, "FontSize", 12, 'FontWeight','bold');
str = strcat({'   '}, num2str(T_fuel_max_up(end),3));
text(time(end), T_fuel_max_up(end), str, "FontSize", 12, 'FontWeight','bold');
grid on, grid minor
legend('bottom', 'center', 'top','Location','northwest')
xlabel('Time [s]')
title('MAX FUEL TEMPERATURE [K]')

% ----- MAX CLAD TEMP -----
figure('Position', [10 10 900 900])
hold on
plot(time,T_clad_max_do, 'LineWidth', 1.3, 'Color', 'b');
plot(time,T_clad_max_med, 'LineWidth', 1.3, 'Color', 'g');
plot(time,T_clad_max_up, 'LineWidth', 1.3, 'Color', 'r');
hold off
str = strcat({'   '}, num2str(T_clad_max_do(end),3));
text(time(end), T_clad_max_do(end), str, "FontSize", 12, 'FontWeight','bold');
str = strcat({'   '}, num2str(T_clad_max_med(end),3));
text(time(end), T_clad_max_med(end), str, "FontSize", 12, 'FontWeight','bold');
str = strcat({'   '}, num2str(T_clad_max_up(end),3));
text(time(end), T_clad_max_up(end), str, "FontSize", 12, 'FontWeight','bold');
grid on, grid minor
legend('bottom', 'center', 'top','Location','northwest')
xlabel('Time [s]')
title('MAX CLAD TEMPERATURE [K]')

% ----- AXIAL PROFILE MAX TEMP FUEL -------
figure('Position', [10 10 300 900])
axial_plot(T_max_fuel_axial(end,:), false, 'Axial Profile - Max Fuel Temperature', 'Fuel Temperature [K]', 3000)


% ----- AXIAL PROFILE HTMODE -------
figure('Position', [10 10 300 900])
htmode_plot(HTMODE_axial(end,:), false, 'Axial Profile - Heat Transfer Mode', '', 1)

% ----- AXIAL PROFILE HEAT FLUX -------
figure('Position', [10 10 300 900])
axial_plot(heat_flux_axial(end,:), false, 'Axial Profile - Heat Flux [kW/m^2]', 'Heat Flux [kW/m^2]', 1000)

% ----- AXIAL PROFILE HTC -------
figure('Position', [10 10 300 900])
axial_plot(htc_axial(end,:), false, 'Axial Profile - HTC [kW/m^2/K]', 'Heat Transfer Coefficient [kW/m^2/K]', 100)

% ----- AXIAL PROFILE FLOW REGIME -------
figure('Position', [10 10 300 900])
flowreg_plot(flow_reg_axial(end,:), false, 'Axial Profile - Flow Regime', '', 1)

% ----- AXIAL PROFILE VOID FRACTION -------
figure('Position', [10 10 300 900])
axial_plot(void_axial(end,:), false, 'Axial Profile - Void Fraction', 'Void Fraction', 1)

% ----- PROFILE RADIAL TEMP FUEL ------
figure()
radial_plot_fuel(T_profile(end,:), false, 'pwr')

% ----- AXIAL CHFR -------
% figure('Position', [10 10 300 900])
% chfr_axial_plot(chfr(end,:), false, 'Axial Profile - CHFR', 'CHFR', 30)

% ----- ANIMATION PROFILE MAX TEMP FUEL -------
% figure('Position', [10 10 300 900])
% axial_plot(horzcat(time, T_max_fuel_axial), true, 'Animation Profile - Max Fuel Temperature', 'Fuel Temperature [K]', 3000)

% ----- ANIMATION PROFILE HTMODE -------
% figure('Position', [10 10 300 900])
% htmode_plot(horzcat(time, HTMODE_axial), true, 'Animation Profile - Heat Transfer Mode', '', 1)

% ----- ANIMATION PROFILE RADIAL TEMP FUEL ------
% figure(10)
% radial_plot_fuel(T_profile, true, 'pwr')