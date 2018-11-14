% we know structure of TF , now we can calculate parameters
clear;
% sys= (b1*s + b0 )/ (s^2 + a1*s +a0)
%% create input signal and simulate model
SW=1;
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
system= (b1*s+b0)/(s^2+a1*s+a0);

%% 2.1 ABSOLUTE VALUE

% J= SUM{ Cip + Cim}

j=ones(1,2*length(eta(1:end/100)));
j1=zeros(1,size(fi,2));
j=[j,j1];
x=zeros(length(eta(1:end/100)),2*length(eta(1:end/100)));
for i = 1: length(eta(1:end/100));
    x(i,2*i-1)=1;
    x(i,2*i)=-1;
end

Aeq=[x,fi(1:end/100,:)];
Beq=eta(1:end/100);
Alb=[zeros(size(x)),-Inf*ones(size(fi(1:end/100,:)))];

xR=linprog(j,[],[],Aeq,Beq,Alb,[]);

