% Lax First Try:
clc; clear variables; close all; 

v = 100;
dx = 5e-3;
x = -.5:dx:2;

% CFS condition (Courant)
dt = .05*dx/abs(v);
t = 0:dt:1;

sig = 1/10;
mu = 0;
y = 1/sig/sqrt(2*pi)*exp(-(x-mu).^2./2/sig^2);
y = y/max(y);
plot(x,y)
u = zeros(length(t), length(y));
% Checking the Lax, Lax-Wendroff and Quick:
u(1,:) = y;
figure()
plot(ones(5,1),'k--')
for n = 1:length(t)
    for i = 2:length(x)-1
        % Lax:
        %u(n+1, i) = 1/2*(u(n, i+1) + u(n, i-1)) - v*dt/dx/2*(u(n, i+1) - u(n, i-1));

%         % Lax-Wendroff:
        u(n+1, i) = u(n, i) - v*dt/dx/2*(u(n, i+1) - u(n, i-1)) + ...
            0.5*dt^2/2/dx*(u(n, i+1) - 2*u(n,i) + u(n, i-1));
        u(n,1) = 0;
        u(n,end) = 0;
    end
    plot(x, u(n,:))
    grid on
    %ylim([0 1])
    pause(1e-3)
    if norm(u(n,:)) <1e-2 || norm(u(n,:)) > 1e2
        break
    end
end