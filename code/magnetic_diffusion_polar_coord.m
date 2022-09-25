clc; clear variables; close all;

% Code to solve HW3 for the class on Numerical Methods at TTU, delivered by
% Dr. Jacob Stephesn. 

% Data of the problem:
sigma = 5.7e7; mu = 4*pi*1e-7;
D = 1/sigma/mu; 
I = 1e3;
r0 = 1e-3;

% Dirichlet's Boundary for B.
BC = [0 mu*I/r0/2/pi];

% Creation of the time and space steps. 
tf = 10e-6; dr =  r0/100;
lim = dr^2/2/D*.8; 
dt = 2.5e-9;
% Time and space arrays (mesh/grid):
t = 0:dt:tf; r = 0:dr:r0;
N = length(t); M = length(r);
B = zeros(N,M);
J = zeros(N,M);
J(:,M) = I/2/pi/r0^2;
% Frequency:
f =1E6;

% FTCS Scheme:
for n = 1:N
    for i = 2:M-1
        % Magnetic Field (AL FIN):
        B(n+1, i) = B(n, i)  + ... 
        D*dt*(B(n, i+1) - 2*B(n,i) + B(n, i-1))/dr^2 + ...
        D*dt/r(i)*(B(n,i+1) - B(n,i))/dr - ...
        D*dt/r(i)^2*B(n,i);
        % Dirichlet:
        B(n+1, 1) = BC(1); B(n+1, end) = BC(2);
        % Von Neumann
        B(n+1, 2) = B(n+1,1);

        % Density Current:
        J(n, i) = 1/mu*(B(n, i+1) - B(n,i))/dr;
        % Dirichlet
        J(n, 1) = J(n, 2);
        % Von Neumann
        J(n,end) = J(n,end-1); 
    end
end

% Plotting:
f = figure(1);
f.Position = [100 100 900 600];
rplot = 0:dr:r0;
Bplot = mu*rplot*I/2/pi/r0^2;
% hold on 
% plot(rplot, Bplot, 'k')
% plot(r,B(end,:), 'b+')
for i = 2:length(B)-1
    if mod(t(i)/100,dt) == 0
        sgtitle(strcat('For t = ', num2str(t(i)/1e-9), 'ns'))
        subplot(2,1,1)
        plot(r, B(i, :)/mu, 'r-', 'LineWidth',3)
        grid on
        xlabel('r')
        ylabel('$H_{\varphi} (r,t)$', 'Interpreter','latex')
        set(gca, 'fontname','times', 'FontSize',15)
        %ylim([-BC(2) BC(2)])
        title('Field in the Conductor')

    
        subplot(2,1,2)
        plot(r, J(i, :), 'b-', 'LineWidth',3)
        grid on
        xlabel('r')
        ylabel('J(r,t)')
        set(gca, 'fontname','times', 'FontSize',15)
        %ylim([-3e9 3e9])
        %ylim([0 1e3])
        title('Current Density in the Conductor')
        pause(1e-1)
    end
end
