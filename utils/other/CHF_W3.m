function CHF = CHF_W3(p, x_e, m_dot, h_f, q, A, D_e, L)
% W-3 CHF CORRELATION
%
% INPUTS:
%       - p     [Pa]
%       - x_e           : equilibrium quality (quale)
%       - m_dot [kg/s]  : mass flow rate (mflowj)
%       - h_f   [J/kg]  : specific sat. fluid enthalpy (sathf)
%       - q     [W/m^2] : heat flux (htrnr)
%       - A     [m^2]   : flow cross section area
%       - D_e   [m]     : hydraulic disameter
%       - L     [m]     : total lenght of the channel
%
%
%
% OUTPUT:
%       - CHF [kW/m^2]


% convert variables to desired units
p = p./1000000;      % from Pa to MPa
h_f = h_f./1000;         % from J/kg to kJ/kg

% compute derived variables
G = m_dot./A;
delta_Z = L/50;
Z = linspace(delta_Z/2, L - delta_Z/2, 50);
h_in = h_f(1);



%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Compute uniform CHF  %
%%%%%%%%%%%%%%%%%%%%%%%%%%

M1 = (2.022-0.06238.*p) + (0.1722 - 0.01427.*p).*exp((18.177 - 0.5987.*p).*x_e);
M2 = (0.1484 - 1.596.*x_e + 0.1729.*x_e.*abs(x_e)).*2.326.*G + 3271;
M3 = 1.157 - 0.869.*x_e;
M4 = 0.2664 + 0.8357.*exp(-124.1.*D_e);
M5 = 0.8258 + 0.0003413.*(h_f - h_in);

CHF_uniform = M1 .* M2 .* M3 .* M4 .* M5;



%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Compute factor  F    %
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compute C
C = 185.6.*((1-x_e).^(4.31))./(G.^0.478);

% Compute denominator
D = q.*(1-exp(-C.*Z));
D

% Compute integral
I = [];

for i=1:length(Z)
    I_i = 0;
    for j=1:i
        I_i = I_i + q(j)*exp(-C(i)*(Z(i)-Z(j)))*delta_Z;
    end
    I = [I I_i];
end
I

% Compute F
% I have to eliminate the last two elements since they do not produce power
% and kill the matlab computations dividing by zero
F = C.*I;
F = F(1:48)./D(1:48);
F(49) = 1000;
F(50) = 1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Compute   CHF      %
%%%%%%%%%%%%%%%%%%%%%%%%%%
CHF = CHF_uniform./F;

end
