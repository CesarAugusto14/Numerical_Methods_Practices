clc; clear variables; close all;

% Script for solving the circuit provided during the class of September 1st
% 2022. The data for the provided circuit is:

C = 2.85E-6; R1 = 0.1; L1 = 500E-9; L2 = 10E-6; R2 = 10;

% The initial voltage is of 30kV, on the capacitor C1.
V0 = 30E3;

% Time of Initial run:
dt = 1E-8;
t_sw = 10E-6;
tf = 20e-6;

% The Initial conditions for the Currents are:

I0 = [0 V0/(L1+L1)]';

% The state matrix A is:

A1 = [0 1; -1/(L1+L2)/C -R1/(L1+L2)];

% The State of the Circuit:
G = @(t, x) A1*x;

% Solving:

[t , i] = RK4_ODE(G, dt, 0, t_sw, I0);
t1 = t; iL = i;

% As we have two parts for the problem (one before the switching at t_sw,
% and one after the switching), we splitted the problem in two, so the
% secon part is listed below:

%% Second run:
t0 = t_sw+dt; 
I0 = iL(1,end); 
A2 = R2/L2;
G = @(t,x) -A2*x;
[t2 , i2] = RK4_ODE(G, dt, t0, tf, I0);

% Plotting:
figure(1)
plot(t*1e6, i(1,:)/1e3, 'k', 'LineWidth',3)
hold on
plot(t2*1e6, i2/1e3, 'r', 'LineWidth',3)
xlim([0 tf*1e6])
xlabel('Time [$\mu s$]','Interpreter','latex')
ylabel('$L_2$ Current [kA]','Interpreter','latex')
grid on
legend('t<t_{sw}','t>t_{sw}');
title('Current in Inductor L_2')
set(gca, 'FontName', 'Times', 'FontSize', 15)

% Note that the Current on L_2 will be in the first part the current on
% capacitor C_1, and after the switching, the current on the Load. 