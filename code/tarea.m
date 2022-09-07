clc; clear variables; close all

% Circuit information:
C = 5; Vo = 100e3; Ls = 60e-3; Rl = 50e-3; Ll=700e-9;

% Projectile information:
m = 10;  % MASS

% Initial Conditions
x0 = [0;Vo/Ls;0;0];

% Time Conditions:
t0 = 0; dt = 1e-6; tf = 1;

% RK4 model. 
[t, x] = RK4_ODE(@(t,x) railgun(t,x, C, Ls, Ll, Rl, m), dt, 0, tf, x0);

% Extracting the resulting vectors for RK4:
I = x(:,1); dI = x(:,2); x_pos = x(:,3); u = x(:,4);

% Slicing the vectors:

maxind = find(x_pos == max(x_pos));
t(maxind:end) = [];
I(maxind:end) = [];
dI(maxind:end) = [];
x_pos(maxind:end) = [];
u(maxind:end) = [];

% Plotting:
figure(1)
subplot(2,2,1)
plot(t, I/1000, 'b', 'linewidth', 2)
xlabel('Time [s]','Interpreter','latex')
ylabel('i(t) [kA]','Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)

subplot(2,2,2)
plot(t, dI/1000, 'r', 'linewidth', 2)
xlabel('Time [s]','Interpreter','latex')
ylabel("i'(t) [kA/s]",'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)

subplot(2,2,3)
plot(t, x_pos, 'color', [0.4660 0.6740 0.1880], 'LineWidth',2)
xlabel('Time [s]','Interpreter','latex')
ylabel("x(t) [m]",'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)

subplot(2,2,4)
plot(t, u, 'color', '#D95319', 'linewidth', 2)
xlabel('Time [s]','Interpreter','latex')
ylabel("u(t) [m/s]",'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)

g = 9.81;
maxa = max(u)/max(t)/g;
fprintf('Maximum Acceleration = %.4f g \n',maxa)
fprintf('Maximum speed = %.4f [m/s] \n', max(u))