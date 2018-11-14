
clear all;
clc;
%% zad1 a1 
% Controlling "the spacecraft" with PD regulator, measuring position of the
% "spacecraft"
b=3;
m=1;

r=4;

ksi=0.7;
omega=3;

kd=-b+2*m*ksi*omega; % parameters for positioning poles of system
kp=m*omega^2;

sw=0; % 1 - include noise
swD=0; % 1- include disturbance
[tout,x,position,control]=sim('zad1a',[0 20]);

figure;
plot(tout,position);
title('PD regulator with derivative of position')
xlabel('time [s]');
ylabel('position [m]');

%% zad1 a2
% Controlling "the spacecraft" with PD regulator, measuring position and speed of the
% "spacecraft"
sw=0;
swD=0;
[tout,x,position,control]=sim('zad1b',[0 20]);

figure;
plot(tout,position);
title('PD regulator with measuring speed')
xlabel('time [s]');
ylabel('position [m]');

%% zad1 b1
% Controlling "the spacecraft" with PD regulator, measuring position of the
% "spacecraft", noise included
sw=1;
[tout,x,position,control]=sim('zad1a',[0 20]);
figure;
plot(tout,control);

title('PD regulator with derivative of position, noise included')
xlabel('time [s]');
ylabel('contol signal');

%% zad1 b2
% Controlling "the spacecraft" with PD regulator, measuring position and speed of the
% "spacecraft", noise included
sw=1;
[tout,x,position,control]=sim('zad1b',[0 20]);

figure;
plot(tout,control);

title('PD regulator with measuring speed, noise included')
xlabel('time [s]');
ylabel('control signal [m]');

%% zad1 c1
% Controlling "the spacecraft" with PD regulator, measuring position of the
% "spacecraft", noise and disturbance included
sw=1;
swD=1;
[tout,x,position,control]=sim('zad1a',[0 20]);

figure;
plot(tout,position);

title('PD regulator with derivative of position, noise and disturbance included')
xlabel('time [s]');
ylabel('position [m]');

%% zad1 c2
% Controlling "the spacecraft" with PD regulator, measuring position and speed of the
% "spacecraft", noise and disturbance included
sw=1;
swD=1;
[tout,x,position,control]=sim('zad1b',[0 20]);
figure;
plot(tout,position);
title('PD regulator with measuring speed, noise and disturbance included')
xlabel('time [s]');
ylabel('position [m]');