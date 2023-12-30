%Test
function TestRate()
    clear all; close all;
    n = 100;
    speeds = linspace(0, 40, n);
    temps = linspace(20, 100, n);
    
    results = zeros(n^2, 3);
    
    for i = 1:n
        for j = 1:n
            results((i-1)*n + j,1) = speeds(i);
            results((i-1)*n + j,2) = temps(j);
            results((i-1)*n + j,3) = Rate(speeds(i), temps(j))/1000;
        end
    end
    
    p = pointCloud(results);
    pcshow(p)
end

