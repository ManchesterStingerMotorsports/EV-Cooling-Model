function TestPower()
    clear all;close all;
    
    n=500;
    torques = linspace(0,150,n);
    RPMs = linspace(0,4000,n);
    results = zeros(n^2, 3);
    for i = 1:n
        for j = 1:n
            eff = (MotorEfficiency(RPMs(j), torques(i)) * 0.0095);
            %eff = max(0, min(eff, 1));
            power = torques(i) * (2 * pi * RPMs(j)/60) / 1000;
            heat = max(-20, min((power/eff) - power, 20));
            results((i-1)*n + j,1) = torques(i);
            results((i-1)*n + j,2) = RPMs(j)/10;
            results((i-1)*n + j,3) = heat*10;
        end
    end
    p = pointCloud(results);
    pcshow(p)
end
