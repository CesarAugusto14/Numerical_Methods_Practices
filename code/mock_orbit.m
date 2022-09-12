function dx = mock_orbit(t, x0, m_sun, G)
    % This function computes the 
    posx = x0(1); posy = x0(2); velx = x0(3); vely = x0(4);

    r = [posx posy]'; lenr = norm(r,2);
    

    dpos = [velx vely]';
    dvel = -G*m_sun/lenr^3*r;
    dx = [dpos; dvel];
end
