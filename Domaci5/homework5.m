%% homework 5 - build RST regulator for second order system

% build RST regulator to control system  G(s)= 1/m / (s(s+b/m))  
% include periodic and constant disturbance
% u= - S/R *y + T/R *r
% G=B/A  ==>
% Y/R= B*R / (A*R+B*S)
% A*R+B*S  --characteristic polinome

m=2;
b=3;
omega=1;
B=[1/m];
A=[1 b/m 0];

G=tf(B,A);

Td=1;
a=1/Td;

% system order-2
% observer order -2
% we can measure 1 state
% poles to eliminate constant disturbance 1
% poles to eliminate periodic disturbance 2 ==>
% Acl-> 6-th order
% A is second order then R will be 4-th order
% R= s*(s^2+omega^2)*(s+a0)
% S= b4*s^4+b3*s^3+b2*s^2+b1*s+b0

% A*R +B*S must be equal to Acl

% wanted poles positions
pole=[-1 -2 -3 -2 -4 -5];
Acl=poly(pole);

b0=Acl(end)*m;
b1=Acl(end-1)*m;
a0=Acl(2)-b/m;
b4=(Acl(3)-omega^2-a0*b/m)*m;
b3=(Acl(4)-omega^2*(b/m+a0))*m;
b2=(Acl(5)-omega^2*a0*b/m)*m;

s=tf('s');
R=s*(s^2+omega^2)*(s+a0);
S=b4*s^4+b3*s^3+b2*s^2+b1*s+b0;

%x=s*(s+b/m)*R+B*S;

T=b0;

Gff=T/R;
Gfb=S/R;

[numG,denG]=tfdata(G);
[numGff,denGff]=tfdata(Gff);
[numGfb,denGfb]=tfdata(Gfb);

[tout,x,position]=sim('homework5model',[0 30]);
figure;
plot(tout,position);
title('Control with RST regulator, include constant and periodic disturbance');
xlabel('time [s]');
ylabel('position [m]');


