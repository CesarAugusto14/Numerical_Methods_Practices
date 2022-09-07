clc; clear variables; close all

C = 5; Vo = 100e3; L = 1e-6; Rl = 50e-3; Ll=0.7e-6;
m = 10;
x0 = [0;Vo/L;0;0];
dt = 1e-7;
tf = 10e-3;
%[t1, x1] = ode23(@(t,x) railgun(t,x, C, L, Ll, Rl, m), 0:dt:tf, x0);
[t2, x2] = RK4_ODE(@(t,x) railgun(t,x, C, L, Ll, Rl, m), dt, 0, tf, x0);

% Extracting the resulting vectors for Ode45:
% I1 = x1(:,1);
% dI1 = x1(:,2); 
% x_pos1 = x1(:,3);
% u1 = x1(:,4);

% Extracting the resulting vectors for RK4:
I2 = x2(:,1);
dI2 = x2(:,2); 
x_pos2 = x2(:,3);
u2 = x2(:,4);

% Plotting:
figure()
hold on
% plot(t1, I1/1000, 'r-x', 'linewidth', 2, 'MarkerSize', 8)
plot(t2, I2/1000, 'b-.', 'linewidth', 2)
legend('Solution from RK4')
xlabel('Time [s]','Interpreter','latex')
ylabel('Current on the Circuit [kA]','Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)
title('Current on the Railgun Circuit')
grid on 

figure(2)
plot(t2, u2)

figure(3)
plot(t2, x_pos2)
