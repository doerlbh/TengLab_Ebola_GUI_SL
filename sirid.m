function [t y] = sirid

global olda oldb
yo = [99 1 0];
to = 0;
tf = 50;
[t y] = ode45('ypsirid',[to tf],yo);

end