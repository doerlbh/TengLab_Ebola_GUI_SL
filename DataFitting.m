% developed by Baihan Lin
% Ebola Modeling
% Data Fitting

% % To Do:
% 1. Open Excel
% 2. Read Data
% 3. Plot Data
% 4. Fit Model
% 5. Fit Parameters
% 6. Plot Model and Data

filename = '/Users/DoerLBH/Dropbox/git/TengLab_Ebola_GUI_SL/Table1_for_code.xlsx';
xlRange = 'A2:D18';
GUI = xlsread(filename,1,xlRange);
SL  = xlsread(filename,2,xlRange);

t = 1:17;
GCase  = GUI(:, 2);
SCase  =  SL(:, 2);
GDeath = GUI(:, 3);
SDeath =  SL(:, 3);
GCFR   = GUI(:, 4);
SCFR   =  SL(:, 4);

fig1 = figure;
plot(t, Gcase,'LineWidth', 2); hold on
plot(t, Scase,'LineWidth', 2);
plot(t, GDeath,'LineWidth', 2);
plot(t, SDeath,'LineWidth', 2);
title('Case & Death in GUI and SL');
xlabel('month');
ylabel('number');
legend('GCase','SCase', 'GDeath', 'GDeath','Location','northwest');


