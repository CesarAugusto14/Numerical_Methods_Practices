function [t, x] = RK2_ODE(G, dt, t0, tf, x0)
% Function to compute the RK2 Method by using the theory from the class
% at TTU. The method will gather the derivative of the state variables and
% use it for generating the solution. 
% 
% G is the first derivative of the state vector. 
% dt is the time step. 
% t0 is the initial value in time.
% tf is the final value in time.
% x0 is the vector of initial conditions. 
%
    t = t0:dt:tf; N = length(t);
    x = zeros(length(x0), N);
    x(:,1) = x0;
    
    for i = 1:N-1
        k1 = G(t(i), x(:, i));
        k2 = G(t(i) + dt/2, x(:, i)+ k1*dt/2);
        x(:, i+1) = x(:, i) + k2*dt;
    end

% Code developed by Cesar Sanchez for Fall 2022. 
end
