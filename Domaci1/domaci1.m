% FIND THE TRANFER FUNCTION STRUCTURE

%% load system into simulink S-Function
load_system('model');
set_param('model/S-Function','FunctionName','model1');
save_system('model');
 
%% check is system dynamic or static

%simulate system with step
Fs=100;
duration=100;
t=0:1/Fs:duration;
u.time=t';
u.signals.values=ones(1,length(t))';
sim('model',[0 duration],simset('solver','ode5','FixedStep',1/Fs));

%plot the output dependent on the input
plot(u.signals.values,y.signals.values);
xlabel('u');
ylabel('y');
title('Output dependent on the input');
% we have a lot of different output values for the same input ->
% -> dynamic system

%% check is system linear and time invariant

% create signal with a lot of periodic components whitch has different freq

F=0.01;
Fs=1000;
numOfHar=1000;
duration=2000;
t=0:1/Fs:duration;

x=createSignal(F,numOfHar,duration,Fs,2);
u.time=t';
u.signals.values=x';

% calculate FT of signal
U=fft(u.signals.values);

% plot amplitude spectrum of signal
fo=0:Fs/length(U):Fs/2;

p2=abs(U/length(U));
p1=p2(1:length(U)/2+1);
p1(2:end)=2*p1(2:end);

figure;
subplot(2,1,1);
stem(fo,p1);
set(gca,'Xscale','log');
xlabel('f [Hz]');
ylabel('|U|');
title('Spectrum of input signal');

%simulate system 
sim('model',[0 duration],simset('solver','ode5','FixedStep',1/Fs));
%s=tf('s');
%sys=(s+3)/(s^2+s+1);
%[y1,t1]=lsim(sys,x,t);
% calculate FT of output signal
Y=fft(y.signals.values);

%plot spectrum of output signal
p22=abs(Y/length(Y));
p12=p22(1:length(Y)/2+1);
p12(2:end)=2*p12(2:end);

fo=0:Fs/length(Y):Fs/2;


subplot(2,1,2);
stem(fo,p12);
set(gca,'Xscale','log');
xlabel('f [Hz]');
ylabel('|Y|');
title('Spectrum of output signal');

%% calculate transfer function
F=0.01;
Fs=1000;
numOfHar=1000;
duration=100;
t=0:1/Fs:duration;

x=createSignal(F,numOfHar,duration,Fs,1);
u.time=t';
u.signals.values=x';

U=fft(u.signals.values);

sim('model',[0 duration],simset('solver','ode5','FixedStep',1/Fs));

Y=fft(y.signals.values);

G=Y./U;

p23=abs(G);
p13=p23(1:length(G)/2+1);
p13(2:end)=2*p13(2:end);

% plot bode diagram
figure;
fo=0:Fs/length(G):Fs/2;

subplot(2,1,1);
plot(fo,p13);
set(gca,'Xscale','log');
xlabel('f [Hz]');
ylabel('|G|');
title('Bode diagram of system');
xlim([0.01 10]);

subplot(2,1,2);

plot(fo,20*log10(p13));
set(gca,'Xscale','log');
xlabel('f [Hz]');
ylabel('|G| [dB]');
title('Bode diagram of system (dB)');
xlim([0.01 10])
