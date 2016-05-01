% developed by Baihan Lin, Apr 2014
% Ebola Modeling
% Data Fitting

function dydt = seir_ode(t,y,p)

beta = p(1);
gamma = p(2);
k = p(3);
l = p(4); % for new
u = p(5); % for new

S = y(1);
E = y(2);
I = y(3);
R = y(4);
N = S + E + I + R; % for test.m get rid of N (in following as well)
% dydt = [-beta*I*S/N; beta*I*S/N-k*E; k*E-gamma*I; gamma*I];
dydt = [-beta*I*S+l-u*S; beta*I*S-(u+k)*E; k*E-gamma*I; gamma*I-u*R];

end

