clc; clear variables; close all;

% RLC Discharging: expect an oscilating behavior. Eventually, all state
% variables will get to zero. 

C = 15e-6; L = 30e-3; R = 10; Vo = 100;

tf = 3e-2; dt = 1e-4;

A = [ 0 1; -1/L/C -R/L];
i0 = [0 Vo/L]';
G = @(t, x) A*x;
[t , i]    = RK4_ODE(G, dt, 0, tf, i0);
% Note that solving the problem is extremely easy and well defined with our
% functions for the numerical methods. Euler is failing with dt=1e-4. RK2
% and RK4 both behave well with 1e-4, with 1e-3, the answer is not smooth. 
% 
% For Cap Voltage:
figure(1)
hold on
plot(t*1000, i(1,:)*R + L*i(2,:),'r', 'LineWidth',2)
xlabel('Time [ms]')
ylabel('$V_c$ [V]', 'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on

% For Ind Current
figure(2)
plot(t*1000, -i(1,:),'b', 'LineWidth',2)
xlabel('Time [ms]')
ylabel('$I_L$ [A]', 'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on

% Also try with functions from the ODEsuite. The Results are considered
% good enough, as the capacitor's voltage and the inductor's current
% fulfill the initial conditions. Check also with a non-linear Differential
% Equation, like the start-up of an AC Motor. Maybe the dq0 equations, to
% make it easier to solve. 

%% Checking with ode45!!

[tode, iode] = ode45(G, 0:dt:tf, i0);
figure(3)
hold on
plot(t*1000, i(1,:)*R + L*i(2,:),'rx-', 'LineWidth',2, 'MarkerSize', 10)
plot(tode*1000, iode(:,1)*R + L*iode(:,2),'bo-', 'LineWidth',2)
legend('RK4', 'ode45','Location','best')
xlabel('Time [ms]')
ylabel('$V_c$ [V]', 'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on

% Note that the result is virtually the same. Why the slightly differences?
% probably the a's from ode45 are different from the classical RK4. Which
% would be expected.
