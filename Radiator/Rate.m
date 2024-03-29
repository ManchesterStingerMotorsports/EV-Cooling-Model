function q = Rate(T_in, V_car)
% Radiator Rating Tool %
% Tom Wilkinson tomwilkinson7@me.com %
%% THIS IS FLAWED BUT FUNCTIONAL %%
% This *does* work and has been tested against real data, but it has a
% level of error. Using the standard StPr correlation from K&L leads to a
% massive overestimate when coolant flow is laminar, but very good accuracy
% for turbulent, so I've generated one using real world data to use instead
% I haven't been able to validate it yet

%% DO NOT EDIT ANYTHING UNLESS YOU KNOW WHAT YOU'RE DOING %%
state = Radiator_settings;
state.V_car = V_car;
state.water_temp = T_in; % [degC]
fin_spacing = 25.4e-3 / (state.radiator.FPI/2);

% Abandon hope ye who enter here %
% Seriously, stop scrolling %

% Derived specs
tube_H_internal = state.radiator.tube_H - 2*state.radiator.wall_thickness; % [m] 
tube_W_internal = state.radiator.W - 2*state.radiator.wall_thickness; % [m] 
gap_H = (state.radiator.H - state.radiator.tubes_N * state.radiator.tube_H) / (state.radiator.tubes_N); % [m] Gap between adjacent fins
fins_N = state.radiator.tubes_N * round(state.radiator.L / fin_spacing); 
fin_length = ((fin_spacing/2)^2 + gap_H^2)^.5; % [m]


% Calculate the surface area for each fluid
A_c = 4*fin_length*state.radiator.W * fins_N + (state.radiator.tube_H + state.radiator.W * state.radiator.L * state.radiator.tubes_N * 2) ; % Air side
A_h = 2 * (tube_H_internal + tube_W_internal) * state.radiator.L * state.radiator.tubes_N; % Water side
% Uses data from Compact Heat Exchangers Third Edition, Kays and London
% (and a lot of linear interpolation)

% Air side - Surface 14.77
c_pc = interp1([0, 10, 20, 30, 40], [1004, 1004, 1004, 1005, 1005], state.air_temp , "linear", "extrap");
u_c = interp1([0, 10, 20, 30, 40], [17.2e-6, 17.69e-6, 18.17e-6, 18.64e-6, 19.11e-6], state.air_temp , "linear", "extrap"); 
Pr_c = interp1([0, 10, 20, 30, 40], [.717, .714, .712, .710, .709], state.air_temp , "linear", "extrap");
r_hc = (0.5*fin_spacing*gap_H)/(2*fin_length + fin_spacing);
sigma_c = 1 - (state.radiator.tubes_N*state.radiator.tube_H*state.radiator.L + fins_N*fin_length*2*state.radiator.fin_width)/(state.radiator.L*state.radiator.H);
rho_c = interp1([0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 127], [1.293, 1.2473, 1.2047, 1.165, 1.1277, 1.0928, 1.0600, 1.0291, 1.0000, 0.9724, 0.9463, 0.8825], state.air_temp , "linear", "extrap");

air_flowrate = Airflow(state); % [m^3/s]

G_c = (air_flowrate*rho_c)/(sigma_c * state.radiator.L * state.radiator.H); % Mass flowrate per unit area
Re_c = (4 * r_hc * G_c)/u_c;
Nu_c = .023 * Re_c^.8 * Pr_c^.4;
h_c = Nu_c*.026/r_hc;

% Water side - Surface FT-1
c_ph = interp1([0.01, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 140], [4217, 4193, 4182, 4179, 4179, 4181, 4185, 4190, 4197, 4205, 4216, 4285], state.water_temp, "linear", "extrap"); 
u_h = interp1([0.01, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 140], [17.91e-4, 13.08e-4, 10.03e-4, 79.77e-5, 65.31e-5, 54.71e-5, 46.68e-5, 40.44e-5, 35.49e-5, 31.50e-5, 28.22e-5, 19.61e-5], state.water_temp, "linear", "extrap"); 
Pr_h = interp1([0.01, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 140], [13.44, 9.42, 6.99, 5.42, 4.34, 3.57, 3.00, 2.57, 2.23, 1.97, 1.76, 1.23], state.water_temp, "linear", "extrap");
r_hh = (tube_W_internal*tube_H_internal)/(2*(tube_W_internal+tube_H_internal));
rho_h = interp1([0.01, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 140], [999.8, 999.8, 998.2, 995.6, 992.2, 998.0, 983.2, 977.7, 971.8, 965.3, 958.3, 926.1], state.water_temp, "linear", "extrap");
sigma_h = (state.radiator.tubes_N * tube_W_internal * tube_H_internal)/(state.radiator.H * state.radiator.W);

G_h = (state.water_flowrate/60)/(sigma_h * state.radiator.W * state.radiator.H);
Re_h = (G_h * 4 * r_hh)/(u_h);
% USING HOME MADE StPr_h VALUES BASED ON GT SUITE DATA
StPr_h = interp1([381 762 1144 1525 1906 2287 2668 3049 3431],[0.00145 0.00123 0.0013 0.0017 0.0022 0.0031 0.0045 0.008 0.02],Re_h,'linear','extrap');
St_h = StPr_h*Pr_h^(-2/3);
h_h = St_h * G_h * c_ph;

% Fin efficiency
m = ((2 * h_c)/(237 * state.radiator.fin_width))^.5; % Equation [2-5]
n_f = tanh(m*fin_length*0.5)/(m*fin_length*0.5); % Equation [2-4]
n_c = 1 - (4*fin_length/(state.radiator.tube_H * fin_spacing + 2*fin_spacing + 4*fin_length)) * (1-n_f); % Equation [2-3]
% Overall heat transfer coefficients, Equation [2-2] 
U_c = ((h_c*n_c)^-1 + (A_h*h_h/A_c)^-1)^-1; % Air side

% E-NTU Method
UA = U_c * A_c;
c_max = max((state.water_flowrate/60000) * rho_h * c_ph, air_flowrate * rho_c * c_pc); 
c_min = min((state.water_flowrate/60000) * rho_h * c_ph, air_flowrate * rho_c * c_pc); 

c_r = c_min / c_max;
NTU = UA / c_min;
effectiveness = 1 - exp(((NTU^0.22)/c_r) * (exp(-c_r*NTU^0.78)-1)); % https://www.semanticscholar.org/reader/0b0893aa2fad9bbd160f2fa2e5d1aa5c92eb6b7b
q = effectiveness * c_min * abs(state.water_temp - state.air_temp );

end