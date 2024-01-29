%function TestPower()
    clear all;close all;
    addpath('..');

    n=500;
    torques = linspace(0,150,n);
    RPMs = linspace(0,4000,n);
    results = zeros(n^2, 3);
    x = zeros(n^2, 1);
    y = zeros(n^2, 1);
    z = zeros(n^2, 1);
    for i = 1:n
        for j = 1:n
            eff = (MotorEfficiency(RPMs(j), torques(i)) * 0.0095);
            power = torques(i) * (2 * pi * RPMs(j)/60) / 1000;
            heat = max(-20, min((power/eff) - power, 20));
            x((i-1)*n + j) = torques(i);
            y((i-1)*n + j) = RPMs(j);
            z((i-1)*n + j) = heat;

            results((i-1)*n + j, 1) = torques(i);
            results((i-1)*n + j, 2) = RPMs(j);
            results((i-1)*n + j, 3) = heat;
            
        end
    end
    p = pointCloud(results);
    ax = pcshow(p);
    ax.DataAspectRatio = [1 10 .1];

    xlabel('Torque /Nm');
    ylabel('Motor Speed /RPM');
    zlabel('Heat /kW');
%end

% Shows heat*10 vs Torque vs RPM/10