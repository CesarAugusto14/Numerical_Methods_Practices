clc; clear variables; close all;

% Specifications of the desired Circuit.
R = 20; C = 14e-6; Vs = 5; 

% Initial voltage.
Vo = 0;

% Let's use our knowledge on circuits to determine the ending time for the
% simulation. 
tau = R*C; 
tf = 5*tau;

F = @(t, v) 1/R/C*(Vs*sin(377*t) - v);


[t, x] = dp_rk45a_ODE(F, 0, tf, Vo, 1e-5)