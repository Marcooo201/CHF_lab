addpath(genpath('../../utils/'));

data = readtable('data.csv');

time = data.time;
power = data.cntrlvar110;
T_out = data.tempf555500000;

T_fuel_max_do = data.httemp555000101;
T_fuel_max_med = data.httemp555002501;
T_fuel_max_up = data.httemp555005001;

T_clad_max_do = data.httemp555000108;
T_clad_max_med = data.httemp555002508;
T_clad_max_up = data.httemp555005008;

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

p_drop = data.cntrlvar120;

HT_mode_do = floor(data.htmode555000101);
HT_mode_med = floor(data.htmode555002501);
HT_mode_up = floor(data.htmode555005001);



% Creo i plot
figure(1)
tiledlayout(3,2)

nexttile
plot(time,power, 'LineWidth', 1.3, 'Color', 'r');
title('TOTAL POWER [kW]')

nexttile
plot(time,T_out, 'LineWidth', 1.3, 'Color', 'r');
title('OUTLET TEMPERATURE [K]')

nexttile
hold on
plot(time,HT_mode_do, 'LineWidth', 1.3, 'Color', 'b');
plot(time,HT_mode_med, 'LineWidth', 1.3, 'Color', 'g');
plot(time,HT_mode_up, 'LineWidth', 1.3, 'Color', 'r');
hold off
legend('down', 'med', 'up')
title('HEAT TRANSFER MODE')


nexttile
hold on
plot(time,T_fuel_max_do, 'LineWidth', 1.3, 'Color', 'b');
plot(time,T_fuel_max_med, 'LineWidth', 1.3, 'Color', 'g');
plot(time,T_fuel_max_up, 'LineWidth', 1.3, 'Color', 'r');
hold off
legend('down', 'med', 'up')
title('MAX FUEL TEMPERATURE [K]')

nexttile
hold on
plot(time,T_clad_max_do, 'LineWidth', 1.3, 'Color', 'b');
plot(time,T_clad_max_med, 'LineWidth', 1.3, 'Color', 'g');
plot(time,T_clad_max_up, 'LineWidth', 1.3, 'Color', 'r');
hold off
legend('down', 'med', 'up')
title('MAX CLAD TEMPERATURE [K]')

figure(3)
radial_plot_fuel(table2array(T_profile), true)