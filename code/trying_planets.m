clc; clear variables; close all;

G = 6.674e-11;
ly = 9.461e15; % 1 ly/m
m_sun = 1e30; 
dataplanets = csvread('planetdata.csv');
N = length(dataplanets);
t0 = 0; 

% Final Time:
% seconds in a minute*mins in an hour* hours in a day* day in a year.
tf = 60*60*24*365*25; 

% Delta t 
dt = 24*60*60*1; % Movement per day.
%polarplot(0,0)
%hold on
newcolors = {'#0072BD'; '#D95319'; '#EDB120'; '#7E2F8E'; '#77AC30';
    '#4DBEEE';'#A2142F';'#000015'};
colororder(newcolors)
figure(1)
hold on
for i = 1:N
    x0 = dataplanets(i,:);
    [t, x] = RK4_ODE(@(t,x) mock_orbit(t,x, m_sun, G), dt, 0, tf, x0);
    %[theta, rho] = cart2pol(x(:,1), x(:,2));
    %polarplot(theta, rho)
    plot(x(:,1)/ly, x(:,2)/ly, 'linewidth',2)
end
% figure(2)
% plot(x(:,1), x(:,2))

xlim([-2e-4 2e-4])
ylim([-2e-4, 2e-4])
legend('Planet 1', 'Planet 2', 'Planet 3', 'Planet 4', 'Planet 5', ...
    'Comet 1', 'Comet 2', 'Comet 3')
title('Trajectory Plot (Ly: lightyears)')
xlabel('x(t) [Ly]')
ylabel('y(t) [Ly]')
grid on
set(gca,'FontName', 'Times', 'FontSize', 15)