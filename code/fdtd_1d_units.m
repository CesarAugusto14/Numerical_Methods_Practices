clc; clear variables; close all;

% FDTD with units:
f0 = 10e6;                % Frequency of source    [Hz]
e0 = 8.854*10^-12;       % Permittivity of vacuum [farad/meter]
u0 = 4*pi*10^-7;         % Permeability of vacuum [henry/meter]
c0 = 1/(e0*u0)^.5;       % Speed of light         [meter/second]
lam0  = c0/f0;           % Freespace Wavelength   [meter]
t0  = 1/f0;              % Source Period          [second]
k0 = 2*pi/lam0;          % Wavenumber
% Resolution:
Lmin = c0/f0;

% Spatial Domain:
Nl = 10;
dx = Lmin/Nl; Nx = 200; 
x  = linspace(0,10*lam0,Nx); 
xv = 1:Nx; xvt = 2:Nx-1;

% Time Domain:
t_max = 1e-6;
Nt = 1000;
r = 0.999; % Courant's Number
dt = dx/c0*r;
t = 0:dt:t_max;

% FDTD Scheme:
Hx(xv) = 0; Ey(xv) = 0;
E3 = 0; E2 = 0; E1 = 0; 
H3 = 0; H2 = 0; H1 = 0;
fig1 = figure('Color', 'white');
for n = 1:Nt
    % Update Magnetic:
    Hx(1:Nx-1) = Hx(1:Nx-1) + dt/e0/dx*(Ey((1:Nx-1)+1) - Ey(1:Nx-1));

    % Dirichlet's BCs:
    Hx(end) = Hx(end) + dt/e0/dx*(E3 - Ey(end));
    H3 = H2; H2 = H1; H1 = 0;

    Ey(1)   = Ey(1)   + dt/u0/dx*(Hx(1) - H3);

    % Update Electric:
    Ey(2:Nx) = Ey(2:Nx) + dt/u0/dx*(Hx(2:Nx) - Hx((2:Nx)-1));
    E3 = E2; E2 = E1; E1 = 0;
    % Source:
    Ey(round(Nx/2)) =  Ey(round(Nx/2)) + ... 
        3.*exp(-.5*((n-50)/4)^2); 
%     Ey(round(Nx/2)) = 1;
    
    % Plotting:
    figure(fig1)
    subplot(2,1,1)
    h = plot(x, Ey ,'r', 'linewidth', 2);
    h2 = get(h, 'Parent');
    set(h2, 'LineWidth', 2, 'FontSize', 18, 'FontName', 'Times')
    xlabel('x in [meters]')
    ylabel('E_y in [V/m]')
    xlim([min(x) max(x)])
    ylim([-3 3]); drawnow
    subplot(2,1,2)
    h3 = plot(x, Hx ,'b', 'linewidth', 2);
    h4 = get(h3, 'Parent');
    set(h4, 'LineWidth', 2, 'FontSize', 18, 'FontName', 'Times')
    xlabel('x in [meters]')
    ylabel('Hx in [A/m]')
    xlim([min(x) max(x)])
    ylim([-1500 1500]); drawnow
end
