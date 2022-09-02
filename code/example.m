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
    f = [];
    f(1) = 0;
    for i = 1:N-1
        f(i+1) = f(i) + dt*(2*f(i) + 4*t(i));
    end
    plot(t, f, 'o-')
end

% Plotting the exact solution, which was found by using Wolfram-Alpha:
tplot = 0:0.001:2;
fplot = -2*tplot + exp(2*tplot) - 1; % Exact Plot
plot(tplot, fplot, 'k', 'linewidth', 2)

% Tweaking the Plot. 
title('$\frac{df(t)}{dt} = 2f(t) + 4t$ solved by Euler', 'Interpreter',...
    'latex')
ylabel('Solution, $f(t)$', 'Interpreter','latex')
xlabel('time, $t$', 'Interpreter','latex')
legend('\Delta t = 0.02', '\Delta t = 0.05','\Delta t = 0.1', ...
   '\Delta t = 0.2','Exact Solution', 'Location','northwest')
set(gca, 'FontName', 'Times', 'FontSize', 15)
grid on