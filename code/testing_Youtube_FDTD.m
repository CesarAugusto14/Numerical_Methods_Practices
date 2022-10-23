clc; clear variables; close all;

%% First, Figure Handles:
fig1 = figure;
fig1.Name = 'FDTD Analysis';
fig1.NumberTitle = 'off';
fig1.Color = [1 1 1];
fig1.Position = [1 1 2560/2 1440/2];

%% Non-Uniform-Partitioning:

x = linspace(-1, 1, 100);
y1 = x;
y2 = x.^2;
y3 = exp(-x.^2);

figure(fig1)
subplot(2, 2, 1)
plot(x, y1)

subplot(2,2,2)
plot(x, y2)

subplot(2,2, 3:4)
plot(x, y3)

close(fig1)
%% Better plots:

figure('Color', 'white');
h = plot(x, y2, '-b', 'LineWidth', 2);
h2 = get(h, 'Parent');
set(h2, 'FontSize', 14, 'Linewidth', 2, 'FontName', 'Times')
grid on
xlabel('x')
ylabel('y')
title('Better Plot')

% Set Tick Markings:
xm = -1: 0.5:1;
xt = {};
for m = 1:length(xm)
    xt{m} = num2str(xm(m), '%3.2f');
end
set(h2, 'XTick', xm, 'XTickLabel', xt)

%% 2D Graphics:
xa = linspace(-2, 2, 50); ya = linspace(-1, 1, 25); 
[X, Y] = meshgrid(xa, ya);
D = X.^2 + Y.^2;
fig3 = figure('color','w'); clf;
pcolor(xa, ya, D) % vs imagesc()
axis equal tight
shading interp    % Faceted vs Flat (very similar to imagesc) vs interp (interpolation of the colors) 
colormap jet