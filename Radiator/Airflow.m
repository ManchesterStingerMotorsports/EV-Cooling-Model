function Q = Airflow(state)
    % Air flowrate calculation
    % https://ideaexchange.uakron.edu/cgi/viewcontent.cgi?article=1143&context=honors_research_projects  
    rho = interp1([0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 127], [1.293, 1.2473, 1.2047, 1.165, 1.1277, 1.0928, 1.0600, 1.0291, 1.0000, 0.9724, 0.9463, 0.8825], state.air_temp , "linear", "extrap");

    c1  = state.radiator.fans.y/(state.radiator.fans.x/3600);           % Fan coeff (slope of linear regression)
    kr  = 15.79;                                                        % Radiator pressure coeff (from paper, a bit of a guess)
    a1  = state.radiator.L*state.radiator.H;                            % Radiator frontal area
    a4  = state.radiator.fans.n * pi * state.radiator.fans.D^2 /4;      % Fan frontal area
    c0  = state.radiator.fans.y;                                        % Fan coeff (intercept of linear regression)
    v   = state.V_car; % Velocity of car
    
    if (state.radiator.fans.n == 0) % If there's no fans
        c1 = 0;
        c0 = 0;
        a4 = a1;
        state.radiator.fans.n = 1;
    end
    a = rho * 0.5 * ((kr/(a1^2)) + (1/(a4^2)));
    b = c1/state.radiator.fans.n;
    c = -(c0 + (0.5*rho*(v^2)));
    Q = (-b + sqrt(b^2 - 4*a*c))/(2*a);

end