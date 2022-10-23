clc; clear variables; close all; 

% 1D FDTD in Unitless domain!
Nx = 300; 
x = 1:1:Nx;
Nt = 700;

mid = 150;

S = 1;

e0 = 1;
mu0 = 1;
c = 1;

dx = 1; 
dt = S*dx/c;

xv = 1:Nx; xvt = 2:Nx-1;

Ey(xv) = 0; Hx(xv) = 0;

for n = 1:Nt

    Hx(xvt) = Hx(xvt) + (dt/dx/mu0)*(Ey(xvt+1) - Ey(xvt));

    Ey(xvt) = Ey(xvt) + (dt/dx/e0)*(Hx(xvt) - Hx(xvt-1));
    if n<=35
        Ey(mid) = (10-15*cos(n*pi/20)+6*cos(2*n*pi/20)-cos(3*n*pi/20))/32;
    end
    plot(x,Ey)
    title(strcat('Step',num2str(n)))
    pause(0.1)
end