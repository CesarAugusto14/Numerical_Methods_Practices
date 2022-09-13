clc; clear variables; close all;

% Specifications of the desired Circuit.
R = 2e3; C = 14e-6; Vs = 5; 

% Initial voltage.
Vo = 0;

% Let's use our knowledge on circuits to determine the ending time for the
% simulation. 
tau = R*C; 
tf = 5*tau;
F = @(t, v) 1/R/C*(Vs - v);

[t, v] = dp_rk45a_ODE(F, 0, tf, Vo, 1e-8, 4e-4);
[t2, v2] = RK4_ODE(F, 1e-5, 0, tf, Vo);

% Exact solution (known by our knowledge on Electrical Circuits):
tplot = 0:1e-5:tf; vplot = Vs + (Vo - Vs)*exp(-tplot/R/C);

figure(1)
hold on
plot(t*1000, v, 'r-', 'linewidth', 2, 'MarkerSize', 10)
plot(t2*1000, v2,'g-.','LineWidth',2)
plot(tplot*1000, vplot, 'k-', 'linewidth',2)
legend('RK45a', 'RK4','Exact Solution', 'Location','southeast')
title('Comparison Between Numerical and Exact with RK methods')
ylabel('$V_c$ [V]', 'Interpreter','latex')
xlabel('$t$ [ms]', 'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on