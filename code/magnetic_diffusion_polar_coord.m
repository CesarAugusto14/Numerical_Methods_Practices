clc; clear variables; close all;

sigma = 5.7e7; mu = 4*pi*1e-7;

D = 1/sigma/mu; 
I = 1e3;
r0 = 1e-3;
BC = [0 mu*I/r0/2/pi];

tf = 10e-6; dr =  r0/50;
dt = dr^2/2/D*0.8; 

% Time and space arrays:
t = 0:dt:tf; r = 0:dr:r0;
N = length(t); M = length(r);
% Creating matrix B:
B = zeros(N,M);
%J = zeros(N,M);
f =1E6;
for n = 1:N
    for i = 2:M-1
        B(n+1, i) = B(n, i) + D*dt/dr^2*(B(n, i+1) - 2*B(n, i) + B(n, i-1)) + ...
            D/r(i)*dt/dr*(B(n, i+1) - B(n, i));

        B(n+1, 1) = BC(1); B(n+1, end) = BC(2)*cos(2*pi*f*t(n));
    end
end

f = figure(1);
f.Position = [100 100 600 600];
for i = 2:length(B)
    plot(r, B(i, :), 'ro-', 'LineWidth',3)
    grid on
    xlabel('x')
    ylabel('u(x,t)')
    set(gca, 'fontname','times', 'FontSize',15)
    ylim([-BC(2) BC(2)])
    title('Skin Effect')
    pause(1e-2)
    
end