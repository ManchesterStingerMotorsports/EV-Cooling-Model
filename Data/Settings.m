clear
clc
close all

% Endurance Info
n_laps = 11;

%% You shouldn't need to edit this stuff
% Load Battery Parameters
Battery_settings

% Misc Setup
addpath(genpath('..'))

% Runtime Determination
laptime = OpenLAP;
runtime = laptime * n_laps;

% Cleanup
clear n_laps laptime