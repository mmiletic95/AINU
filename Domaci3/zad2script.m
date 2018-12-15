%% zad 2 

% Control the spacecraft with state feedback regulator

b=3;
m=1;

%real sistem
A=[0 1;0 -b/m];
B=[0;1/m];
C=[1 0];
D=[0;0];


T=2; % settling time
a=1/T;

% calculate gains of regulator
k=acker(A,B,[-a -a]);

% calculate observer gains

L=acker(A',C',[-4 -4])';

Ao=A-L*C;
Bo=[B L];
Co=[1 0; 0 1];

swN=0; % 1-noise
swD=0; % 1-disturbance

[tout,x,position]=sim('zad2',[0 30]);

figure;
plot(tout,position);
title('Control with state feedback regulator');
xlabel('time [s]');
ylabel('position [m]');

%% include noise
swN=1;
swD=0;

[tout,x,position]=sim('zad2',[0 30]);

figure;
plot(tout,position);
title('Control with state feedback regulator, include noise');
xlabel('time [s]');
ylabel('position [m]');

%% include distubance
swN=1;
swD=1;

[tout,x,position]=sim('zad2',[0 30]);

figure;
plot(tout,position);
title('Control with state feedback regulator, include noise and disturbance');
xlabel('time [s]');
ylabel('position [m]');
