function dydt = sir_ode(t,y,p)

beta = p(1);
gamma = p(2);
S = y(1);
I = y(2);
R = y(3);
N = S + I + R; % for test.m get rid of N (in following as well)
dydt = [-beta*I*S/N; beta*I*S/N - gamma*I; gamma*I];

end

