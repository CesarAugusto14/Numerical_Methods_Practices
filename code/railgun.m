function dx = railgun(t, x0, C, Ls, Ll, Rl, m)
    % Function for the simulation of the railgun circuit by doing any kind
    % of numerical integration technique. Note that theoretically, we could
    % use this script on any of the functions from the ode suite, built-in
    % in matlab, or use any of the already built methods given in classes.
    % Like RK2, RK4 and RK45a.
    %
    % It will need to receive as an input:
    % 
    % C : the charged capacitance [F].
    % L : the coil of the circuit [H].
    % Ll: the inductance per length of the rails in [H/m].
    % Rl: the resistance per length of the rails in [Ohm/m].
    %
    % Extracting the vector of previous conditions x0
    I1 = x0(1); I2 = x0(2); x = x0(3); u = x0(4);
    
    % Building the System of differential Equations.
    %
    % Where,
    %
    % I1 : The current on the railgun.
    % I2 : The first derivative of the current on the railgun.
    % x  : The position of the projectile in the rails (from 0 to 10).
    % u  : The velocity of the projectile in the rails. (LIMIT OF 100g).
    %
    % Please, check the report for more information about the proccess to
    % get those equations.
    dxdt = u;
    di1dt = I2; 
    dudt = 1/2/m*Ll*I1^2;
    di2dt = -1/(Ls+Ll*x)*((1/C + Rl*u + Ll*dudt)*I1 + (Rl*x+2*Ll*u)*I2);
    dx = [di1dt; di2dt; dxdt; dudt];
end
