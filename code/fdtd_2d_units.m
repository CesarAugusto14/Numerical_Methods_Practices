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
dx = Lmin/Nl;
dy = dx;
[Lmax_x, Lmax_y] = deal(10*lam0, 10*lam0);
x = 0:dx:Lmax_x;
y = 0:dx:Lmax_y;
Nx = length(x); Ny = length(y);

% Time Domain:
Nt = 700;
r = 0.99;  % Courant's Number.
dt = (dx^-2+dy^-2)^-(1/2)/c0*r;


[Hx, Hy, Ez] = deal(zeros(Nx,Ny));
[udy,udx]  = deal(dt/u0/dy,dt/u0/dx);
[edx,edy]  = deal(dt/e0/dx,dt/e0/dy);

fig1 = figure('Color', 'white');
for n = 1:Nt

    % Magnetic Field:
    Hx(1:Nx-1, 1:Ny-1) = Hx(1:Nx-1, 1:Ny-1) - udy*diff(Ez(1:Nx-1, :), 1, 2);
    Hy(1:Nx-1, 1:Ny-1) = Hy(1:Nx-1, 1:Ny-1) + udx*diff(Ez(:, 1:Ny-1), 1, 1);

    % Electric Field Update:
    Ez(2:Nx-1,2:Ny-1) = Ez(2:Nx-1, 2:Ny-1) + ...
        edx*diff(Hy(1:Nx-1, 2:Ny-1), 1, 1) - ... 
        edy*diff(Hx(2:Nx-1, 1:Ny-1), 1, 2);
    
    % Source
    Ez(40, 40) = Ez(round(Nx/2), round(Ny/2))+...
        5*exp(-.5*((n-20)/8)^2);
    
    pcolor(x,y,Ez'); colormap jet; shading interp; axis off; drawnow; 
end