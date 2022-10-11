clc; clear variables; close all;

% Constants of the Problem:
Dc = 17.9e-4;   % diffusion constant, in m^2/s;
A  = 1e-2*1e-2;      % Surface area of the semiconductor.
gam1 = 1e5;     % Impurity, 1/s.
gam2 = 3.3e-21; % Radiative rec, m^3/s.
gam3 = 3.8e-43; % Auger rec, m^6/s.
h = 6.626e-34;   % Planck's constant.
c = 3e8;   % Light speed.
P_light = [10, 30, 50, 100, 150, 200];

%% Part I & II
lam = 532e-9;          % Lights wavelength in m.
nu = c/lam;
d_light = 1.3e-6;
S_v = P_light/(A*h*nu);

% Number of Points per dimension;
Nz = 21; Ny = 21; Nx = Ny;

dz = .5e-11;
p =1.5;
z = 0;
dzplot =[];
for i =1:Nz-1
    if dz < 1e-9-dz
        dz = dz*p;
        dzplot(i) = dz;
        z(i+1) = z(i)+dz;
    else
        dz = 1e-9;
        dzplot(i) = dz;
        z(i+1) = z(i)+dz;
    end
end
x = linspace(-5e-3,5e-3,Nx); dx = x(2)-x(1);
y = linspace(-5e-3,5e-3,Ny); dy = y(2)-y(1);
%z = linspace(0,0.1e-3,Nz);   dz = z(2)-z(1);

clear x y 

dt = 1e-11;
Nc = zeros(Nx, Ny, Nz);

t = 0:dt:20e-6;
uplot = zeros(length(1),1);
SRV=10;
tic
f = figure(1);
f.Position = [100 100 1200 600];
for S = S_v
    tic
    for n = 1:length(t)
        for i = 2:Nx-1
            for j = 2:Ny-1
                for k = 2:Nz-1
                        % Update Equation.
                        Nc(i ,j ,k) = Nc(i, j, k) + ...
                        Dc*dt/dx^2*(Nc(i+1, j, k) - 2*Nc(i,j,k) + Nc(i-1,j,k)) + ...
                        Dc*dt/dy^2*(Nc(i, j+1, k) - 2*Nc(i,j,k) + Nc(i,j-1,k)) + ...
                        Dc*dt/(z(k+1)-z(k))^2*(Nc(i, j, k+1) - 2*Nc(i,j,k) + Nc(i,j,k-1)) + ...
                        dt*S*exp(-z(k)/d_light) - ... 
                        dt*(gam1*Nc(i,j,k) + gam2*Nc(i,j,k)^2 + gam3*Nc(i,j,k)^3);
                    
                        % Von Neumann Trivial Conditions -> Flux = 0.
                        Nc(1, j, k) = Nc(2, j, k);
                        Nc(i, 1, k) = Nc(i, 2, k);
                        %Nc(i, j, 1) = Nc(i, j, 2);
                        % Second Part:
                        Nc(i,j,1) = (1-dz*SRV/Dc)*Nc(i,j,2);

                        Nc(end, j, k) = Nc(end-1, j, k);
                        Nc(i, end, k) = Nc(i, end-1, k);
                        %Nc(i, j, end) = Nc(i, j, end-1);
                        Nc(i,j,end) = (1-(z(k+1)-z(k))*SRV/Dc)*Nc(i,j,end-1);

                end
            end
        end
    uplot(n) = Nc(11,11,1); % THE MIDDLE!
    end
    toc
    subplot(1,2,1)
    hold on
    plot(t*1e6, uplot, 'LineWidth',3)
    xlabel('Time [\mu s]')
    ylabel('Carrier Density [$m^{-3}$]','Interpreter','latex')
    set(gca,'FontName','times','fontsize',15)
    subplot(1,2,2)
    hold on
    plot(z*1e3,squeeze(Nc(11,11,:)), 'LineWidth', 3)
    xlabel('Depth of the Sample (z) [mm]')
    ylabel('Carrier Density [$m^{-3}$]','Interpreter','latex')
    set(gca,'FontName','times','fontsize',15)
end

subplot(1,2,1)
legend('P = 10 W','P = 30 W', 'P = 50 W', 'P = 100 W', 'P = 150 W', 'P = 200 W', 'Location','bestoutside')
subplot(1,2,2)
legend('P = 10 W','P = 30 W', 'P = 50 W', 'P = 100 W', 'P = 150 W', 'P = 200 W', 'Location','bestoutside')
