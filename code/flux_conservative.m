clc; clear variables; close all;

% Time and Space steps
v = 1e-2; dx =  0.1; a=1;
lim = dx^2/2/v*dx; 
dt = 1e-3; % For some reason, this works!

% Time and space arrays:
t = 0:dt:3; x = -1:dx:1;

% Dimensions:
N = length(t); M = length(x);

% Boundary Conditions:
BC = [0 0];
% Creating matrix u:
u = zeros(N,M);
% Initial Conditions:
u(1, :) = exp(-(x+2).^2/10);

for n = 1:N
    for i = 2:M-1
        u(n + 1, i) = 1/2*(u(n, i+1)+u(n, i-1)) + v*dt/dx*(u(n, i+1)-u(n, i-1));
    end
end

for i = 2:length(u)
    plot(x, u(i, :), 'ro-', 'LineWidth',3)
    grid on
    xlabel('x')
    ylabel('u(x,t)')
    set(gca, 'fontname','times', 'FontSize',15)
    ylim([-0.25 1.5])
    title('Diffusion Equation solution')
    pause(1e-3)
    if norm(u(i, :) - u(i-1, :),2) <= 1e-5
        break
    end
end