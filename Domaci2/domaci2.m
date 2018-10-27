% we know structure of TF , now we can calculate parameters
clear;
% sys= (b1*s + b0 )/ (s^2 + a1*s +a0)
%% create input signal and simulate model
SW=2;
F=0.01;
Fs=1000;
Tf=10;
numOfHar=1000;
duration=100;
t=0:1/Fs:duration;
x=createSignal(F,numOfHar,duration,Fs);

u.time=t';
u.signals.values=x';

sim('modelSys',[0 duration],simset('solver','ode5','FixedStep',1/Fs));

%% create eta, fi

% yf" = - yf' * a1 - yf * a0 + uf' b1 + uf b0

eta=yfDiffDiff.signals.values;
fi=[-yfDiff.signals.values,-yf.signals.values,ufDiff.signals.values,uf.signals.values];

%% calculate theta

theta=fi\eta;
a1=theta(1);
a0=theta(2);
b1=theta(3);
b0=theta(4);

%% RESULT
s=tf('s');
system= (b1*s+b0)/(s^2+a1*s+a0)

