clc; clear variables; close all;


% Constants of the Problem:
Dc = 17.9e-4;   % diffusion constant, in m^2/s;
A  = 1e-2;      % Surface area of the semiconductor.
gam1 = 1e5;     % Impurity, 1/s.
gam2 = 3.3e-21; % Radiative rec, m^3/s.
gam3 = 3.8e-43; % Auger rec, m^6/s.
h = 6.62e-34;   % Planck's constant.
c = 2.9979e8;   % Light speed.
P_light = 10;
%% First part.

lam = 900e-9;          % Lights wavelength in m.
del_light = 32.7e-6;   % Penetration depth in m.

dx = 1e-4; dy = dx; dz = 1e-6;

x = -5e-3:dx: 5e-3; Nx = length(x);
y = -5e-3:dy: 5e-3; Ny = length(y);
z = 0:dz:0.1e-3;    Nz = length(z); 

clear x y 
dt = 0.5*dx^2/Dc;
tf = 20e-6;

t = 0:dt:tf;

u = zeros(Nx, Ny, Nz);
time = 1;
for n = t
    for i = 2:Nx-1
        for j = 2:Ny-1
            for k = 2:Nz-1
                u(i,j,k) = u(i,j,k) + Dc*dt/dx^2*( ...
                    u(i+1,j,k) + u(i,j+1,k) - 4*u(i,j,k) + ...
                    u(i-1,j,k) + u(i,j-1,k)) + dt*(Dc/dz^2*( ...
                    u(i,j,k+1) - 2*u(i,j,k) + u(i,j,k-1)) + P_light/lam/h/c*( ...
                    exp(-z(k)/del_light)) - gam1*u(i,j,k) - gam2*u(i,j,k)^2 - gam3*u(i,j,k)^3);
            end
        end
    end
    f(time) = u(50,50,50);
    disp(u(50,50,1))
    time = time+1;
end