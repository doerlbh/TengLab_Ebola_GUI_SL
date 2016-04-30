% This code uses least squares to identify two parameters in the
% SIR model:
% S_t = -aSI; I_t = aSI - bI; R_t = bI where
% a = "contagious" coefficient and
% b = "recovery" coefficient.
% The data is given in the vectors Sd, Id and Rd,
% and they are adjusted by a random variable.
% The data is used in the finite difference approximation of the above:
% (S_i+1 - S_i-1)/(2 dt) = -a S_i I_i
% (I_i+1 - I_i-1)/(2 dt) = a S_i I_i - b I_i and
% (R_i+1 - R_i-1)/(2 dt) = b I_i.
% Least squares is used to compute the linear polynomial coefficients.
% The first six data points are used.
%
% function [t y] = sirid
% global olda oldb
% yo = [99 1 0];
% to = 0;
% tf = 50;
% [t y] = ode45('ypsirid',[to tf],yo);
% end
%
%function ypsirid = ypsirid(t,y)
% global olda oldb
% ypsirid(1) = -olda*y(1)*y(2);
% ypsirid(2) = olda*y(1)*y(2) - oldb*y(2);
% ypsirid(3) = oldb*y(2);
% ypsirid = [ypsirid(1) ypsirid(2) ypsirid(3)]';
%

clear; clf(figure(1))
global olda oldb
olda = 0.010; oldb = 0.100;
td = [0.00 1.077 2.136 3.092 4.171 5.372 6.695 8.020 9.015...
10.293 11.271 15.039 20.590];
% Sd = [99.0 97.2 92.9 84.8 68.1 42.8 20.0 8.3 4.3 2.0 1.1 0.2 0.04];
Id = [1.00 2.59 6.39 13.65 28.20 48.76 64.00 66.93 64.38 ...
58.85 54.15 37.88 21.85];
Rd = [0.00 0.28 0.63 1.55 3.74 8.37 15.97 24.76 31.30 39.19...
44.72 61.92 78.11];
numdata = 13;
rvec = rand(1,numdata);
Id(2:numdata) = Id(2:numdata) + .1*rvec(1,2:numdata) - .05;
5
rvec = rand(1,numdata);
Rd(2:numdata) = Rd(2:numdata) + .1*rvec(1,2:numdata) - .05;
Sd = 100 - Id - Rd;
%
for i = 2:1:numdata-1
ii = (i-1)*3;
d(ii) = (Sd(i+1) - Sd(i-1))/(td(i+1) - td(i-1));
d(ii+1) = (Id(i+1) - Id(i-1))/(td(i+1) - td(i-1));
d(ii+2) = (Rd(i+1) - Rd(i-1))/(td(i+1) - td(i-1));
A(ii,1) = -Sd(i)*Id(i); A(ii,2) = 0;
A(ii+1,1)= Sd(i)*Id(i); A(ii+1,2) = -Id(i);
A(ii+2,1)= 0.0; A(ii+2,2) = Id(i);
end
%
meas = 6;
m = 3*meas + 1;
x = A(2:m,:)\d(2:m)';
%
[olda oldb]
[x(1) x(2)]
plot(td(1:1:meas+1),Sd(1:1:meas+1),'*',td(1:1:meas+1),Id(1:1:meas+1),'o',...
td(1:1:meas+1),Rd(1:1:meas+1),'s',td,Sd,'x',td,Id,'x',td,Rd,'x')
olda = x(1);
oldb = x(2);
[t y] = sirid;
hold on
plot(t, y(:,1), 'b',t, y(:,2), 'g',t,y(:,3), 'r')