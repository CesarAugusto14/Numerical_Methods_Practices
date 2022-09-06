function dx = railgun(t, x0, C, L, Ll, Rl, m)
    % Initial Conditions:
    I1 = x0(1); I2 = x0(2); x = x0(3); u = x0(4);
    
    dxdt = u;
    di1dt = I2; 
    dudt = 1/2/m*Ll*I1^2;
    di2dt = -1/(L+Ll*x)*((1/C + Rl*u + Ll*dudt)*I1 + (Rl*x+2*Ll*u)*I2);
    dx = [di1dt; di2dt; dxdt; dudt];
end
