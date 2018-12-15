%% zad 2 

% Control the spacecraft with state feedback regulator
% G(s) = 1/m / (s*(s+b/m))

b=3;
m=1;
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

%calculate observer matrices
[Ao,Bo,Co,Do]=buildObserver(Asd,Bsd,Csd,L,2);

swN=0; % 1-noise
swD=1; % 1- contant disturbance, 2-ramp , 3-periodic

[tout,x,position]=sim('homework4',[0 30]);
figure;
plot(tout,position);
title('Control with state feedback regulator, include constant disturbance');
xlabel('time [s]');
ylabel('position [m]');

%% ramp disturbance 

% disturbance model
Aw=[0 1; 0 0];
Cw=[1 0];

%create model including disturbance 
[Asd,Bsd,Csd]=buildModelWithDisturbance(A,B,C,Aw,Cw);

% chose poles
pole=-4*ones(1,size(Asd,1));

% calculate observer gains
L=acker(Asd',Csd',pole)';

%calculate observer matrices
[Ao,Bo,Co,Do]=buildObserver(Asd,Bsd,Csd,L,2);

swN=0; % 1-noise
swD=2; % 1- contant disturbance, 2-ramp , 3-periodic

[tout,x,position]=sim('homework4',[0 30]);
figure;
plot(tout,position);
title('Control with state feedback regulator, include  disturbance');
xlabel('time [s]');
ylabel('position [m]');

%% periodic disturbance 

% disturbance model
omega=1;
Aw=[0 1; -omega^2 0];
Cw=[1 0];

%create model including disturbance 
[Asd,Bsd,Csd]=buildModelWithDisturbance(A,B,C,Aw,Cw);

% chose poles
pole=-40*ones(1,size(Asd,1));

% calculate observer gains
L=acker(Asd',Csd',pole)';

%calculate observer matrices
[Ao,Bo,Co,Do]=buildObserver(Asd,Bsd,Csd,L,2);

swN=0; % 1-noise
swD=3; % 1- contant disturbance, 2-ramp , 3-periodic

[tout,x,position]=sim('homework4',[0 30]);
figure;
plot(tout,position);
title('Control with state feedback regulator, include periodic disturbance');
xlabel('time [s]');
ylabel('position [m]');