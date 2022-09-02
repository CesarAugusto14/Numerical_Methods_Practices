clc; clear variables; close all;
% Script for testing the three created functions to solve the given
% differential equation on example_2nd_order_ODE.m. The system is the same.
% Conditions of the problem
a = 1; b = 15; c = 4*pi^2;

% System of Equation F' = A*F
A = [0 1; -c/a -b/a];
dt = 0.05; t0 = 0; tf = 1; 

% Euler 
x0 = [0 1]';

% Given equation:
G = @(t, x) A*x;

% Exact Solution:
tplot = 0:1e-3:1; fplot = (exp(-1/2*(15 + sqrt(225 - 16*pi^2))*tplot).*(-1 ...
    + exp(sqrt(225 - 16*pi^2)*tplot)))/sqrt(225 - 16 *pi^2);


% Solutions:
[teuler, xeuler] = EulerODE(G, dt, t0, tf, x0);
[trk2 , xrk2]    = RK2_ODE(G, dt, t0, tf, x0);
[trk4 , xrk4]    = RK4_ODE(G, dt, t0, tf, x0);

% Plots:
figure(1)
hold on

% From The Numerical Solutions:
plot(teuler, xeuler(1, :), 'b^-', 'LineWidth', 2)
plot(trk2, xrk2(1, :), 'ro-', 'LineWidth', 2)
plot(trk4, xrk4(1, :), '+-', 'color', '#77AC30', 'LineWidth', 2,...
    'MarkerSize', 10)

% From the Exact Solution:
plot(tplot, fplot, 'LineWidth',3, 'color', 'black')

% Tweaking the Plot:
legend( "Euler's Method", 'RK2', 'RK4', 'Exact Solution')
ylabel('Solution, $f(t)$', 'Interpreter','latex')
xlabel('time, $t$', 'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on
hold off

% Script made by Cesar Sanchez, Fall 2022. 