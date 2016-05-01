% developed by Baihan Lin, Apr 2014
% Ebola Modeling
% Data Fitting

function disc = sir_discrepancy(d0, Idat, Ddat, tspan)

p = d0(1:2);
y0 = d0(3:5);

[t, y] = ode45(@sir_ode,tspan,y0,[],p);
I = y(:, 2);
R = y(:, 3); % for test.m this can be ignored.

% disc = sum((I - Idat').^2);

disc = sum((I - Idat').^2) + sum((R - Ddat.').^2); 
% for test.m chose the above one.