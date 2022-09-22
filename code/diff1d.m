clc; close all; clear variables; 
% Code for solving the Diffusion Equation in 1-D, by using the FTCS scheme
% on it. On it, we can check how it works for both kernelized an a for-loop
% version. Note that this thing is unstable, so I am forcing dt to fulfill
% the stability condition. 
%
% However, some values of dt are working properly, irrelevantly of the
% stability criteria! 

% Time and Space steps
a = .51; dx =  0.2;
lim = 0.9999*dx^2/2/a; 
dt = lim; % For some reason, this works!

% Time and space arrays:
t = 0:dt:20; x = -3:dx:3;

% Dimensions:
N = length(t); M = length(x);

% Boundary Conditions:
BC = [0 0];
% Creating matrix u:
u = zeros(N,M);
% Initial Conditions:
u(1, :) = 10*exp(-x.^2/2);

%% Kernelized version:
kernel = [1, -2, 1];
tic
for n = 1:N
    u(:, 1) = BC(1); u(:, end) = BC(2);
    u(n+1,:) = u(n,:) + a*dt/(dx^2)*convn(u(n, :), kernel, 'same');
end
t1 = toc;

%% For-loop version
tic
for n = 1:N
    for i = 2:M-1
        u(n + 1, i) = u(n, i) + a*dt/dx^2*(u(n, i+1) - 2*u(n, i) + u(n, i-1));
        u(:, 1) = BC(1); u(:, end) = BC(2);

    end
end
t2 = toc;

% PLOT
% figure(1)
% for i = 2:length(u)
%     plot(x, u(i, :), 'ro-', 'LineWidth',3)
%     grid on
%     xlabel('x')
%     ylabel('u(x,t)')
%     set(gca, 'fontname','times', 'FontSize',15)
%     ylim([-0.25 1.5])
%     title('Diffusion Equation solution')
%     pause(1e-3)
%     if norm(u(i, :) - u(i-1, :),2) <= 1e-5
%         break
%     end
% end

fprintf('The Required time for the Kernelized version is %.4f s\n', t1)
fprintf('The Required time for the Loop version is %.4f s\n', t2)

% For some reason, the kernelized version is not being as fast as expected.
% We will need to do further resarch on this. Script developed by Cesar
% Sanchez, for Fall 2022. 


figure(2)
[X,T] = meshgrid(x,t);
surf(T,X, u(1:end-1,:))
shading interp

xlabel('Time')
ylabel('Space')
zlabel('U')
