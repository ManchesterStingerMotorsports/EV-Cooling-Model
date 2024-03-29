%% Battery parameters
% TSAC
TSAC.L = 0.31; % Meters
TSAC.W = 0.58;
TSAC.H = 0.187;

% Pack Config
Cell.parallel = 7;
Cell.series = 112;

% VTC6
Cell.SOC = [.1 .25 .5 .75 .9 1];
Cell.V = [2.89 3.27 3.53 3.74 3.84 3.99]; % Volts
%Cell.Resistance = 16.2e-3; % Ohms
Cell.Resistance = [21.5 19.5 19.3 19.8 20.7 21] * 1e-3; % Ohms
Cell.Capacity = 3; % Cell capacity, A*hr
Cell.mass = 390e-3 / Cell.parallel;%;46.6e-3; % Kg
Cell.SHC = 1040; %J/kgK