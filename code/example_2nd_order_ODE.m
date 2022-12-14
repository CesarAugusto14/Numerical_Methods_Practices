clc; clear variables; close all;
% This is a script for studying a second order ODE, by using Euler's Method
% RK2, and RK4 methods. The second order equation will be:
%
% a*f''+b*f'+c*f = 0
% 
% We will use F1(t) = f(t) and F2(t) = df(t)/dt. f(0) = F1(0) = 0.
% 
% f'(0) = F2(0) = 1. Study the equation for a=1, b=15, c=4*pi^2. 

a = 1; b = 15; c = 4*pi^2;


% Exact Solution:
figure(1)
hold on
tplot = 0:1e-3:1; fplot = (exp(-1/2*(15 + sqrt(225 - 16*pi^2))*tplot).*(-1 + exp(sqrt(225 - 16*pi^2)*tplot)))/sqrt(225 - 16 *pi^2);
plot(tplot, fplot, 'LineWidth',3, 'color', 'black')

% Euler's Method:
% For this part, I will be creating a vectorized form to do it. In order to
% get the two variables at once.
dt = 0.05; t0 = 0; tf = 1; t = t0:dt:tf;

F = zeros(2, length(t));

F(:,1) = [0 1]';
A = [0 1; -c/a -b/a];
for i=1:length(t)-1
    F(:, i+1) = F(:, i) + dt*A*F(:, i);
end
plot(t, F(1, :), 'ro-')

% RK2 Method:
F = zeros(2, length(t));
F(:,1) = [0 1]';
A = [0 1; -c/a -b/a];
for i=1:length(t)-1
    k1 = A*F(:, i);
    k2 = A*(F(:,i) + k1*dt/2);
    F(:, i+1) = F(:, i) + dt*k2;
end
plot(t, F(1, :), 'b^-')

% RK4 Method
F = zeros(2, length(t));
F(:,1) = [0 1]';
A = [0 1; -c/a -b/a];
for i=1:length(t)-1
    k1 = A*F(:, i);
    k2 = A*(F(:,i) + k1*dt/2);
    k3 = A*(F(:,i) + k2*dt/2);
    k4 = A*(F(:,i) + k3*dt);
    F(:, i+1) = F(:, i) + dt/6*(k1+2*k2+2*k3+k4);
end
plot(t, F(1, :), '+-', 'color', '#77AC30', 'LineWidth',2)
legend('Exact Solution', "Euler's Method", 'RK2', 'RK4')
ylabel('Solution, $f(t)$', 'Interpreter','latex')
xlabel('time, $t$', 'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on

% NOTE: If this is like this, we can create a function to ask the
% space-state information from the user, and always get the solution of the
% equations. 