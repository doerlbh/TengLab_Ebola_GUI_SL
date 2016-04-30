function disc = sir_discrepancy(p, Idat, Ddat, tspan, y0)

[t, y] = ode45(@sir_ode,tspan,y0,[],p);
I = y(:, 2);
R = y(:, 3); % for test.m this can be ignored.

% disc = sum((I - dat').^2);

disc = sum((I - Idat').^2) + sum((R - Ddat.').^2); 
% for test.m chose the above one.