% developed by Baihan Lin, Apr 2014
% Ebola Modeling
% Data Fitting

% % To Do:
% 1. Open Excel
% 2. Read Data
% 3. Plot Data
% 4. Fit Model
% 5. Fit Parameters
% 6. Plot Model and Data

clear all;
close all;

filename = '/Users/DoerLBH/Dropbox/git/TengLab_Ebola_GUI_SL/Table1_for_code.xlsx';
xlRange = 'A2:E18';
GUI = xlsread(filename,1,xlRange);
SL  = xlsread(filename,2,xlRange);

t = 1:17;
GCase  = GUI(:, 2);
SCase  =  SL(:, 2);
GDeath = GUI(:, 3);
SDeath =  SL(:, 3);
GInf   = GUI(:, 4);
SInf   =  SL(:, 4);
GCFR   = GUI(:, 5);
SCFR   =  SL(:, 5);

fig1 = figure;
plot(t, GInf, 'r', 'LineWidth', 2); hold on
plot(t, SInf, 'b', 'LineWidth', 2);
plot(t, GDeath, 'r--', 'LineWidth', 2);
plot(t, SDeath, 'b--', 'LineWidth', 2);
title('Infectious & Death in GUI and SL');
xlabel('month');
ylabel('number');
legend('GInf','SInf', 'GDeath', 'SDeath','Location','northwest');
close(fig1);

% For GUI

% Initial conditions: 1997 susceptible, 2 infected, 0 recovered
y0 = [1997 3 0];

% tspan will hold the times for which to solve the system
% of ODEs. We want to solve it at the times that
% correspond to our data
tspan = t;

% Try solving the system at a guess for good parameter values
p0 = [.01 .1];

Gp_opt = sir_optimize(GInf.', GDeath.', tspan, y0, p0)
GR0 = Gp_opt(1) / Gp_opt(2)

[t,Gy] = ode45(@sir_ode, tspan, y0, [], Gp_opt);

fig2 = figure;
plot(t, Gy(:,1)/10000, 'linewidth', 2, 'Color',[0 0.4470 0.7410]); hold on;
plot(t, Gy(:,2), 'linewidth', 2, 'Color',[0.8500 0.3250 0.0980]);
plot(t, Gy(:,3), 'linewidth', 2, 'Color',[0.4660 0.6740 0.1880]);
plot(t, GInf,'*', 'markersize', 10, 'Color',[0.8500 0.3250 0.0980]);
plot(t, GDeath, '+', 'markersize', 10, 'Color',[0.4660 0.6740 0.1880]);
title('Prediction & Data in GUI');
xlabel('month');
ylabel('number');
legend('Pre-S', 'Pre-I', 'Pre-R', 'GInf', 'GDeath', 'Location', 'northwest');
set(gca, 'FontSize', 15);
% close(fig2);


% For SL

% Initial conditions: 9997 susceptible, 3 infected, 0 recovered
y0 = [9997 3 0];

% tspan will hold the times for which to solve the system
% of ODEs. We want to solve it at the times that
% correspond to our data
tspan = t;

% Try solving the system at a guess for good parameter values
p0 = [.01 .1];

Sp_opt = sir_optimize(SInf.', SDeath.', tspan, y0, p0)
SR0 = Sp_opt(1) / Sp_opt(2)

[t,Sy] = ode45(@sir_ode, tspan, y0, [], Sp_opt);

fig3 = figure;
plot(t, Sy(:,1)/10000, 'linewidth', 2, 'Color',[0 0.4470 0.7410]); hold on;
plot(t, Sy(:,2), 'linewidth', 2, 'Color',[0.8500 0.3250 0.0980]);
plot(t, Sy(:,3), 'linewidth', 2, 'Color',[0.4660 0.6740 0.1880]);
plot(t, SInf,'*', 'markersize', 10, 'Color',[0.8500 0.3250 0.0980]);
plot(t, SDeath, '+', 'markersize', 10, 'Color',[0.4660 0.6740 0.1880]);
title('Prediction & Data in SL');
xlabel('month');
ylabel('number');
legend('Pre-S', 'Pre-I', 'Pre-R', 'SInf', 'SDeath', 'Location', 'northwest');
set(gca, 'FontSize', 15);
% close(fig3);
