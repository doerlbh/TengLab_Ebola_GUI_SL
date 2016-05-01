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
y0 = [1997 0 3 0];

% tspan will hold the times for which to solve the system
% of ODEs. We want to solve it at the times that
% correspond to our data
tspan = t;

% Try solving the system at a guess for good parameter values
p0 = [.01 .1 1 0.1 0.1];

Gp_opt = seir_optimize(GInf.', GDeath.', tspan, y0, p0)
Gb = Gp_opt(1);
Gg = Gp_opt(2);
Gk = Gp_opt(3);
Gl = Gp_opt(4);
Gu = Gp_opt(5);
GR0 = Gk*Gb*Gl/(Gu*(Gk+Gu)*(Gg+Gu))

[t,Gy] = ode45(@seir_ode, tspan, y0, [], Gp_opt);

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
% close(fig2);


% For SL

% Initial conditions: 9997 susceptible, 0 exposed, 3 infected, 0 recovered
y0 = [9997 0 3 0];

% tspan will hold the times for which to solve the system
% of ODEs. We want to solve it at the times that
% correspond to our data
tspan = t;

% Try solving the system at a guess for good parameter values
p0 = [.01 .1 1 0.1 0.1];

Sp_opt = seir_optimize(SInf.', SDeath.', tspan, y0, p0)
Sb = Sp_opt(1);
Sg = Sp_opt(2);
Sk = Sp_opt(3);
Sl = Sp_opt(4);
Su = Sp_opt(5);
SR0 = Sk*Sb*Sl/(Su*(Sk+Su)*(Sg+Su))

[t,Sy] = ode45(@seir_ode, tspan, y0, [], Sp_opt);

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
% close(fig3);

% Explore how population size can affect models
figure;

ind = 1;
for i = 0.5:0.1:2
    psi = 1.08*i;    
    R0(ind) = (1/(gamma1+psi))*(beta1*Pop + (beta3*Pop*psi/gamma2) + (beta2*Pop*rho1*gamma1));

    odejac = @(t,u,up) jac(u, alpha, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega); 
    odefun =@(t,u) SEIHRRR(t, u, alpha, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega);
    opts = odeset('Jacobian', odejac);
    %[t,y] = ode23s(odefun, tSpan, y0, opts);
    [t,y] = ode15s(odefun, tSpan, y0,opts);

    %plot(t, y(:,3)+y(:,4))

    Infected(:,ind) = y(:,3)+y(:,4);
    plot(t, log10(Infected(:,ind)),'--')
    hold on
    ind = ind+1;
end
plot(t, log10(Infected(:,6)),'r')
axis([289,349,2.8,3.8])
xlabel('$t$ (days)','Interpreter','LaTex','FontSize',14), ylabel('$\log_{\ 10}I(t)$','Interpreter','LaTex','FontSize',14)
title('Guinea','Interpreter','LaTex','FontSize',14)

