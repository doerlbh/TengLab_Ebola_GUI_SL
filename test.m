% Input the data and the time window. Data is the number
% of infected individuals at each time step.
data = [3 6 26 69 225 294 258 237 181 125 69 27 11 4];
time = 1:14;
% Initial conditions: 750 susceptible, 4 infected,
% 2 recovered
y0 = [1000 10 2];
% tspan will hold the times for which to solve the system
% of ODEs. We want to solve it at the times that
% correspond to our data
tspan = time;

% Try solving the system at a guess for good parameter values
p0 = [.01 .1];
[t,y] = ode45(@sir_ode,tspan,y0,[],p0);

figure(1), clf;
plot(t, y, 'linewidth', 2);
hold on;
plot(time, data, 'k*', 'markersize', 10);
legend('susceptible','infected','recovered','data')
set(gca, 'FontSize', 15)

