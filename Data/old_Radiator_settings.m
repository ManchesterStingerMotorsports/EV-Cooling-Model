function state = Radiator_settings
%% Radiator
state.radiator.L = 0.185; % [m]
state.radiator.W = 0.040; % [m]
state.radiator.H = 0.176; % [m]
state.radiator.tubes_N = 17;
state.radiator.tube_H = 0.002;       % [m]
state.radiator.fin_spacing = 25.4e-3 / 16;   % [m]     if the fins are /\/\/\/\
state.radiator.wall_thickness = 1e-4; % [m]   /\ = 1 fin spacing
state.radiator.fin_width = 1.27e-4;      % [m]

%% Fans
state.radiator.fans.D = 0.182;   % Fan diameter [m]
state.radiator.fans.y = 300;     % dP at 0 Flowrate [Pa]
state.radiator.fans.x = 600;     % Flowrate at 0 dP [m3/h]
state.radiator.fans.n = 1;       % Number of fans

%% Fluid Properties
state.water_flowrate = 6; % [L/min]
state.air_temp = 20;      % [degC]