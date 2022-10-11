clc; clear variables; close all;
% Code Developed by Cesar Augusto Sanchez as a baseline trial of project 2.
% The current script serves as a exploratory solution to tune the
% simulation parameters of the 3D solution. Initially, we will set the
% constants, to get a clear picture of how the solution should look like
% without the other two dependant variables. Note that we expect them to
% not be that critical, as the source is independent of x and y. 

% Constants of the Problem:
Dc = 17.9e-4;           % diffusion constant, in m^2/s;
A  = 1e-2*1e-2;         % Surface area of the semiconductor.
gam1 = 1e5;             % Impurity, 1/s.
gam2 = 3.3e-21;         % Radiative rec, m^3/s.
gam3 = 3.8e-43;         % Auger rec, m^6/s.
h = 6.626e-34;          % Planck's constant.
c = 3e8;                % Light speed.

% The power of the source is given in W, we create a vector with all that
% information, and we will be iterating over that vector to plot a final
% result. 

P_light = [10, 30, 50, 100, 150, 200];

%% Q 1 and 2.
% Extra information that just for questions 1 and 2.
lam = 900e-9;           % Lights wavelength in m.
nu = c/lam;             % Frequency in Hz
d_light = 32.7e-6;      % Depth in m.

% The constant part of the source term:
S_v = P_light/(A*h*c/lam);


% Information of our simulation:
Nz = 30;                
z = linspace(0,.1e-3,Nz);
dz = z(2)-z(1);
lim = 0.9999*Dc*dz^2/2;
dt = 1e-9;
tic
t = 0:dt:80e-6;
u = zeros(Nz,1);
SRV=10;
% Loops for plotting:
f = figure(1);
f.Position = [200 200 1200 600];
for S = S_v
    for n = 2:length(t)
        for k = 2:Nz-1
            % Update Equation
            u(k) = u(k) + Dc*dt/dz^2*(u(k+1) - 2*u(k) + u(k-1)) + ...
            dt*S*exp(-z(k)/d_light) -...
            dt*(gam1*u(k) + gam2*u(k)^2 + gam3*u(k)^3);
            % Von Neumann BCs:
            u(end) = u(end-1)*(1-dz*SRV/Dc);
            u(1) = u(2)*(1-dz*SRV/Dc);
        end
        uplot(n) = u(1);
        %disp(uplot(n))
    end
    toc
    subplot(1,2,1)
    hold on
    plot(t*1e6,uplot, 'LineWidth',3)
    xlabel('Time [\mu s]')
    ylabel('Carrier Density [$m^{-3}$]','Interpreter','latex')
    set(gca,'FontName','times','fontsize',15)
    subplot(1,2,2)
    hold on
    plot(z*1e3,u, 'LineWidth', 3)
    xlabel('Depth of the Sample (z) [mm]')
    ylabel('Carrier Density [$m^{-3}$]','Interpreter','latex')
    set(gca,'FontName','times','fontsize',15)
end

% Adding Legend
subplot(1,2,1)
legend('P = 10 W','P = 30 W', 'P = 50 W', 'P = 100 W', 'P = 150 W', 'P = 200 W', 'Location','northeastoutside')
subplot(1,2,2)
legend('P = 10 W','P = 30 W', 'P = 50 W', 'P = 100 W', 'P = 150 W', 'P = 200 W', 'Location','bestoutside')
