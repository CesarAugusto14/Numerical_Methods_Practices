clc; clear variables; close all;

dt = 5e-4; dx = 0.1; dy = 0.1;
t = 0:dt:1; x=-2:dx:2; y = -2:dy:2;
a = 5;
N = length(t); Iv = length(x); Jv = length(y);
u = zeros(N,Iv,Jv);


% N = 3.0;
% x=linspace(-N, N);
% y=x;
[X,Y]=meshgrid(x,y);
z=(exp(-((X).^2/.5)-((Y-1).^2/.5)))+(exp(-((X).^2/.1)-((Y+1).^2/.5)));
surf(X,Y,z);

% BC
BC = [0 0 0 0];
u(:,1,:) = BC(1); u(:,end,:) = BC(2);
u(:,:,1) = BC(3); u(:,:, end) = BC(4);
u(1,:,:) = z;

kernelx = [1 -2 1]; kernely = kernelx';
h = dx;

%% LOOP VERSION
tic
for n = 1:N
    for i = 2:Iv-1
        for j = 2:Jv-1
            u(n + 1, i, j) = u(n, i, j) + a*dt/h^2*(u(n,i+1,j) ...
                + u(n,i,j+1) - 4*u(n,i,j) + u(n,i-1,j) + u(n,i,j-1));
        end
    end
end
toc
figure(1)
for i = 2:N
    surf(X,Y, squeeze(u(i,:,:)))
    zlim([0 1])
    pause(1e-2)
    grid on
    xlabel('x')
    ylabel('y')
    zlabel('u(x,y,t)')
    set(gca, 'fontname','times', 'FontSize',15)
    title('Diffusion Equation solution')
    if norm(u(i, :,: ) - u(i-1, :, :),'fro') <= 5e-3
        break
    end
end