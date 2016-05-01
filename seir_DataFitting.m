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

% Initial conditions: 1997 susceptible, 0 exposed, 3 infected, 0 recovered
Gy0 = [1997 0 3 0];

% tspan will hold the times for which to solve the system
% of ODEs. We want to solve it at the times that
% correspond to our data
tspan = t;

% Try solving the system at a guess for good parameter values
p0 = [.01 .1 1 0.1 0.1];

Gp_opt = seir_optimize(GInf.', GDeath.', tspan, Gy0, p0)
Gb = Gp_opt(1);
Gg = Gp_opt(2);
Gk = Gp_opt(3);
Gl = Gp_opt(4);
Gu = Gp_opt(5);
GR0 = Gk*Gb*Gl/(Gu*(Gk+Gu)*(Gg+Gu))

[t,Gy] = ode45(@seir_ode, tspan, Gy0, [], Gp_opt);

fig2 = figure;
plot(t, Gy(:,1), 'linewidth', 2, 'Color',[0 0.4470 0.7410]); hold on;
plot(t, Gy(:,2), 'linewidth', 2, 'Color',[0.8500 0.3250 0.0980]);
plot(t, Gy(:,3), 'linewidth', 2, 'Color',[0.4660 0.6740 0.1880]);
plot(t, GInf,'*', 'markersize', 10, 'Color',[0.8500 0.3250 0.0980]);
plot(t, GDeath, '+', 'markersize', 10, 'Color',[0.4660 0.6740 0.1880]);
title('Prediction & Data in GUI');
xlabel('month');
ylabel('number');
legend('Pre-S', 'Pre-I', 'Pre-R', 'GInf', 'GDeath', 'Location', 'northwest');
set(gca, 'FontSize', 15);
close(fig2);


% For SL

% Initial conditions: 9997 susceptible, 0 exposed, 3 infected, 0 recovered
Sy0 = [9997 0 3 0];

% tspan will hold the times for which to solve the system
% of ODEs. We want to solve it at the times that
% correspond to our data
tspan = t;

% Try solving the system at a guess for good parameter values
p0 = [.01 .1 1 0.1 0.1];

Sp_opt = seir_optimize(SInf.', SDeath.', tspan, Sy0, p0)
Sb = Sp_opt(1);
Sg = Sp_opt(2);
Sk = Sp_opt(3);
Sl = Sp_opt(4);
Su = Sp_opt(5);
SR0 = Sk*Sb*Sl/(Su*(Sk+Su)*(Sg+Su))

[t,Sy] = ode45(@seir_ode, tspan, Sy0, [], Sp_opt);

fig3 = figure;
plot(t, Sy(:,1), 'linewidth', 2, 'Color',[0 0.4470 0.7410]); hold on;
plot(t, Sy(:,2), 'linewidth', 2, 'Color',[0.8500 0.3250 0.0980]);
plot(t, Sy(:,3), 'linewidth', 2, 'Color',[0.4660 0.6740 0.1880]);
plot(t, SInf,'*', 'markersize', 10, 'Color',[0.8500 0.3250 0.0980]);
plot(t, SDeath, '+', 'markersize', 10, 'Color',[0.4660 0.6740 0.1880]);
title('Prediction & Data in SL');
xlabel('month');
ylabel('number');
legend('Pre-S', 'Pre-I', 'Pre-R', 'SInf', 'SDeath', 'Location', 'northwest');
set(gca, 'FontSize', 15);
close(fig3);

% Explore how population size can affect models
fig4 = figure;
ind = 1;
for add = 0:0.1:1
    Gy1 = Gy0 + 10000*add;
    [t, Gy2] = ode45(@seir_ode, tspan, Gy1, [], Gp_opt);
    plot(t, Gy2(:,2), '--','linewidth', 2, 'Color',[0 0 0.1+0.9*add]); hold on;
    plot(t, Gy2(:,3), '--','linewidth', 2, 'Color',[0.1+0.9*add 0 0]);
    hold on
    ind = ind+1;
end
plot(t, GInf,'*', 'markersize', 10, 'Color',[0 0 1]);
plot(t, GDeath, '+', 'markersize', 10, 'Color',[1 0 0]);
title('Sensitivity of Prediction & Data in GUI');
xlabel('month');
ylabel('number');
legend('I0.1','R0.1','I0.2','R0.2','I0.3','R0.3','I0.4','R0.4','I0.5','R0.5','I0.6','R0.6','I0.7','R0.7','I0.8','R0.8','I0.9','R0.9','I1.0','R1.0', 'GInf', 'GDeath', 'Location', 'east');

fig5 = figure;
ind = 1;
for add = 0:0.1:1
    Sy1 = Sy0 + 10000*add;
    [t, Sy2] = ode45(@seir_ode, tspan, Sy1, [], Sp_opt);
    plot(t, Sy2(:,2), '--','linewidth', 2, 'Color',[0 0 0.1+0.9*add]); hold on;
    plot(t, Sy2(:,3), '--','linewidth', 2, 'Color',[0.1+0.9*add 0 0]);
    hold on
    ind = ind+1;
end
plot(t, SInf,'*', 'markersize', 10, 'Color',[0 0 1]);
plot(t, SDeath, '+', 'markersize', 10, 'Color',[1 0 0]);
title('Sensitivity of Prediction & Data in SL');
xlabel('month');
ylabel('number');
legend('I0.1','R0.1','I0.2','R0.2','I0.3','R0.3','I0.4','R0.4','I0.5','R0.5','I0.6','R0.6','I0.7','R0.7','I0.8','R0.8','I0.9','R0.9','I1.0','R1.0', 'SInf', 'SDeath', 'Location', 'east');

