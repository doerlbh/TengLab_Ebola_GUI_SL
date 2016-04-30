function dydt = sir_ode(t,y,p)

beta = p(1);
gamma = p(2);
S = y(1);
I = y(2);
R = y(3);
dydt = [-beta*I*S; beta*I*S - gamma*I; gamma*I];

end

