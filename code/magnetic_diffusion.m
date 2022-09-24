clc; clear variables; close all;

sigma = 5.7e7; mu = 4*pi*1e-7;

D = 1/sigma/mu; 
I = 1e3;
y0 = 1e-3;
BC = [0 mu*I/y0];

tf = 10e-6; dx =  y0/50;
% here
dt = dx^2/2/D; 
f = 1e6;
% Time and space arrays:
t = 0:dt:tf; x = 0:dx:y0;
N = length(t); M = length(x);
% Creating matrix u:
u = zeros(N,M);
J = zeros(N,M);
for n = 1:N
    for i = 2:M-1
        u(n + 1, i) = u(n, i) + D*dt/dx^2*(u(n, i+1) - 2*u(n, i) + u(n, i-1));
        u(n+1, 1) = BC(1); u(n+1, end) = BC(2)*cos(2*pi*f*t(n));
        %disp(t(i))
    end
end

f = figure(1);
f.Position = [100 100 600 600];
for i = 2:length(u)
    plot(x, u(i, :), 'ro-', 'LineWidth',3)
    grid on
    xlabel('x')
    ylabel('u(x,t)')
    set(gca, 'fontname','times', 'FontSize',15)
    ylim([-BC(2) BC(2)])
    title('Skin Effect')
    pause(1e-2)
    
end