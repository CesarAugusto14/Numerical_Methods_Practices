clc; clear all; close all;
%%     PLANET 1; PLANET 2; PLANET 3; PLANET 4; PLANET 5;  COMET 1;  COMET 2;    COMET 3
mass= [1e27*ones(5,1); 1e3*ones(3,1)];
x0 =  [    1E11;     3E11;     7E11;        0;     9E11;     2E11;     4E11;      6E11];
y0 =  [       0;        0;        0;     8E11;        0;        0;        0;         0];
vx0 = [       0;        0;        0; -2.2834E4;        0;  0.548E4; 0.6459E3; -7.4564E3];
vy0 = [3.5522E4; 1.7898E4; 0.8788E4; 2.2834E4; 2.1528E4; 2.1921E4; 0.6459E4;  0.7457E4];

Xs = [x0 y0 vx0 vy0];

csvwrite('planetdata.csv',Xs)