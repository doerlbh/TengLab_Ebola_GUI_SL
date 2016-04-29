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