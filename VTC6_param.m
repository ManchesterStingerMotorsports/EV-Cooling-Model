%% Battery parameters

%% ModuleType1
ModuleType1.SOC_vecCell = [.1 .25 .5 .75 .9 1]; % Vector of state-of-charge values, SOC
ModuleType1.V0_vecCell = [2.89 3.27 3.53 3.74 3.84 3.99]; % Open-circuit voltage, V0(SOC), V
ModuleType1.V_rangeCell = [0, inf]; % Terminal voltage operating range [Min Max], V
ModuleType1.R0_vecCell = [13e-3 13e-3 13e-3 13e-3 13e-3 13e-3]; % Terminal resistance, R0(SOC), Ohm
ModuleType1.AHCell = 3; % Cell capacity, AH, A*hr
ModuleType1.thermal_massCell = 800 * 46.6e-3; % Thermal mass, J/K
ModuleType1.AmbientResistance = 25; % Cell level ambient thermal path resistance, K/W

%% ParallelAssemblyType1
ParallelAssemblyType1 = ModuleType1;
% ParallelAssemblyType1.SOC_vecCell = [.1 .25 .5 .75 .9 1]; % Vector of state-of-charge values, SOC
% ParallelAssemblyType1.V0_vecCell = [2.89 3.27 3.53 3.74 3.84 3.99]; % Open-circuit voltage, V0(SOC), V
% ParallelAssemblyType1.V_rangeCell = [0, inf]; % Terminal voltage operating range [Min Max], V
% ParallelAssemblyType1.R0_vecCell = [13e-3 13e-3 13e-3 13e-3 13e-3 13e-3]; % Terminal resistance, R0(SOC), Ohm
% ParallelAssemblyType1.AHCell = 3; % Cell capacity, AH, A*hr
% ParallelAssemblyType1.thermal_massCell = 800 * 46.6e-3; % Thermal mass, J/K
% ParallelAssemblyType1.AmbientResistance = 25; % Cell level ambient thermal path resistance, K/W
