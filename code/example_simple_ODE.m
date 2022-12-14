clc; clear variables; close all;

% Code for testing the Euler Method. on a simple differential equation.
% (Stiff equation, from Dr. Stephen's class). The code will use 4 different
% time-steps, where we will use them to find an approximate answer to our
% equation. 
%
% The Outer for loop is to iterate through the vector of 4 different
% time-steps, and the inner for-loop is to perform the numerical method.
% Inside the outer for-loop I will plot the 4 different approximations.

deltat = [0.02, 0.05, 0.1, 0.2];
figure(1)
hold on
tmax = 2; tmin = 0;

for dt = deltat
    t = tmin:dt:tmax;
    N = length(t);
    % NOTE: An initial array of zeros is faster than an empty one.
    f = zeros(N,1);
    f(1) = 0;
    for i = 1:N-1
        f(i+1) = f(i) + dt*(2*f(i) + 4*t(i));
    end
    plot(t, f, 'o-')
end

% Plotting the exact solution, which was found by using Wolfram-Alpha:
tplot = 0:0.001:tmax;
fplot = -2*tplot + exp(2*tplot) - 1; % Exact Plot
plot(tplot, fplot, 'k', 'linewidth', 3)

% Tweaking the Plot. 
title('$\frac{df(t)}{dt} = 2f(t) + 4t$ solved by Euler', 'Interpreter',...
    'latex')
ylabel('Solution, $f(t)$', 'Interpreter','latex')
xlabel('time, $t$', 'Interpreter','latex')
legend('\Delta t = 0.02', '\Delta t = 0.05','\Delta t = 0.1', ...
   '\Delta t = 0.2','Exact Solution', 'Location','northwest')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on

%% Second part: Using Runge-Kutta Methods for ODEs.

% For this part, I will solve exactly the same ODE as in previous example,
% but now I will use the RK classical methods. Specifically RK2 and RK4.
%
% For Figure 2 I used both Midpoint Method and Heun's Method. They gave me
% the same result for this diferential equation. 
figure(2)
hold on
% Time Information
dt = .2;  t = tmin:dt:tmax;  N = length(t);
% Function vector
f = zeros(N,1);  f(1) = 0;
% Midpoint Method
for i = 1:N-1
    k1 = 2*f(i)+4*t(i);
    k2 = 2*(f(i)+k1*dt/2)+4*(t(i)+dt/2);
    f(i+1) = f(i) + dt*k2;
end
plot(t, f, '^--', 'LineWidth',2)

% Heun's Method
f = zeros(N,1);f(1) = 0;
for i = 1:N-1
    k1 = 2*f(i)+4*t(i);
    k2 = 2*(f(i)+k1*dt)+4*(t(i)+dt);
    f(i+1) = f(i) + dt/2*(k1+k2);
end
plot(t, f, 'o-.')
plot(tplot, fplot, 'k', 'linewidth', 3)

% Tweaking the plot
legend('RK2, Midpoint Method', "RK2, Heun's method", 'Exact Solution')

title('$\frac{df(t)}{dt} = 2f(t) + 4t$ solved by RK2 with $\Delta t$ = 0.1',...
    'Interpreter','latex')
ylabel('Solution, $f(t)$', 'Interpreter','latex')
xlabel('time, $t$', 'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on

% Please, note that both methods are following pretty well the exact
% function, with a fairly big time step. I will use now an RK4 to do the
% same. Heun's method is slightly more accurate and more CPU intensive! 

%% RK4 or Classical Runge-Kutta

figure(3)
hold on
plot(tplot, fplot, 'k', 'linewidth', 3)
dt = .1;  t = tmin:dt:tmax;  N = length(t);
f = zeros(N,1);
f(1) = 0;
for i = 1:N-1
    k1 = 2*f(i) + 4*t(i);
    k2 = 2*(f(i) + k1*dt/2) + 4*(t(i) +dt/2);
    k3 = 2*(f(i) + k2*dt/2) + 4*(t(i) +dt/2);
    k4 = 2*(f(i) + k3*dt) + 4*(t(i) +dt);
    f(i+1) = f(i) + dt/6*(k1 + 2*k2 + 2*k3 + k4);
end

plot(t, f, 'o-', 'LineWidth',2)
legend('RK4', 'Exact Solution')

title('$\frac{df(t)}{dt} = 2f(t) + 4t$ solved by RK4 with $\Delta t$ = 0.1',...
    'Interpreter','latex')
ylabel('Solution, $f(t)$', 'Interpreter','latex')
xlabel('time, $t$', 'Interpreter','latex')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on
fprintf('The error for RK4 is = %.4f percent at t=2 \n',...
    (1-f(end)/fplot(end))*100)
% Note that the RK4 is behaving way better than with the other two methods.
% This is the workhorse of the Numerical Methods. "When you don't know what
% to do, just RK4"
