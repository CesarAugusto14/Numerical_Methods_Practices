clc; clear variables; close all;

x_max = 2;
Nx = 1000;
x = linspace(0,x_max,Nx);
Dx = x(2)-x(1);
xv = 1:Nx;
xvt = 2:Nx-1;
xvt2 = 3:Nx-2;
xvt3 = 4:Nx-3;

v = 1;

u(xv) = 0;

% Initial Condition #1 - Gaussian IC
wv = 1/80;
u(xv) = 1/sqrt(2*pi*wv*wv).*exp(-(xv*Dx-round(0.1*Nx)*Dx).^2./2./wv./wv);
u = u./max(u);

% Initial Condition #2 - Rectangle IC
% u(round(0.05*Nx):round(0.15*Nx)) = 1;

u2 = u;

Dt = .9*Dx/abs(v);
time_max = 2;
t = 0:Dt:time_max;
Nt = size(t,2);

Dt_exp = time_max/5;
t_exp = 0;
i_exp = 0;

u_e1(xv) = 0;
u_w1(xv) = 0;
u_e3(xv) = 0;
u_w3(xv) = 0;

FL(xv) = 0;

for j = 1:Nt-1
    if j*Dt > t_exp
        i_exp = i_exp + 1;
        t_exp = t_exp + Dt_exp;
        u_exp(xv,i_exp) = u(xv);
        time_exp = j*Dt;
    end    
    % Useful coefficients for the Tkalich schemes
    s = round(max(v/abs(v),0) + min(v/abs(v),0)); % Upwind index
    c = abs(v.*Dt./Dx); % Courant number
    % As your generous instructor, have a first-order scheme for free!
  u(xvt) = (1-c)*u(xvt) + c*u(xvt-s);

    % Second order Upwind (Eq 11):
%     u(xvt2) = (1/2*(1-c)*(2-c))*u(xvt2) + c*(2-c)*u(xvt2-s) -...
%         c/2*(1-c)*u(xvt2-2*s);

    % Third order Upwind or QUICKEST (Eq 12):
%     u(xvt2) = -c*(1-c)*(2-c)/6*u(xvt2+s) + (1-c^2)*(2-c)/2*u(xvt2) + ...
%         c*(1+c)*(2-c)/2*u(xvt2-s) - c/6*(1-c^2)*u(xvt2-2*s);

    % Fourth order reduced dispersion (FORD):
%     u(xvt3) = -1/12*c*(1 - c)*(2 - c)^2*u(xvt3 + s) + ...
%         1/6*c*(1 - c)*(2 - c)*(3 + 3*c - 2*c^2)*u(xvt3) + ...
%         1/2*c*(2 - c)*(1 + 2*c - c^2)*u(xvt3-s) - ...
%         1/6*c*(1 - c)*(1 + 5*c - 2*c^2)*u(xvt3-2*s) + ...
%         1/12*c^2*(1 - c)*(2 - c)*u(xvt3-3*s);
%    
end

figure1 = figure (1); clf;
set(figure1,'Color',[1 1 1]);             
axes1 = axes('Parent',figure1);
set(axes1,'FontName','Times New Roman','FontSize',16,'LineWidth',1.5);
hold on
box on
grid on
set(axes1,'MinorGridColor','w','GridLineStyle','--')
plot(x,u_exp,'LineWidth',1.5,'Color','r')
axis([0 x_max -1.1*max(max(u_exp)) 1.1*max(max(u_exp))])
xlabel('x-coordinate')
ylabel('Solution, u(x,t)')