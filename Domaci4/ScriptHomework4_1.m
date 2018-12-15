% servo motor
% G(s) = b/m / s*(s+b/m)

b=1/185;
m=1/185;
omega=1; % freq of periodic disturbance

%real sistem
A=[0 1;0 -b/m];
B=[0;1/m];
C=[1 0];

Td=1;
a=1/Td;

% calculate gains of regulator
k=acker(A,B,[-a -a]);

%% constant disturbance

% disturbance model
Aw=0;
Cw=1;

%create model including disturbance 
[Asd,Bsd,Csd]=buildModelWithDisturbance(A,B,C,Aw,Cw);

% chose poles
pole=-4*ones(1,size(Asd,1));

% calculate observer gains
L=acker(Asd',Csd',pole)';
Lw=L(end);
L=L(1:end-1);

swN=0; % 1-noise
swD=1; % 1- contant disturbance, 2-ramp , 3-periodic

kr=k(1);
T=0.01;

% r= 100 
% disturbance at 20-th second

[tout,x,position]=sim('homework4_1',[0 30]);
figure;
plot(tout,position);
title('Control with state feedback regulator, include constant disturbance');
xlabel('time [s]');
ylabel('position [m]');
