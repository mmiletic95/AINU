F=0.01;
Fs=100;
numOfHar=100;
duration=100;
t=0:1/Fs:duration;
x=createSignal(F,numOfHar,duration,Fs);
x1=cos(2*pi*t*0.1);
x1=x1+cos(2*pi*t*0.3);
x1=x1+cos(2*pi*t*0.5);
x1=x1+cos(2*pi*t*0.7);
%x=x+0.1;
%x=x+createSignal(0.1,9,duration,Fs);
%x=x+createSignal(1,49,duration,Fs);
%x=x+createSignal(10,4,duration,Fs);
N=20000;
Y=fft(x);

fo=0:Fs/length(Y):Fs/2;

p2=abs(Y/length(Y));
p1=p2(1:length(Y)/2+1);
p1(2:end)=2*p1(2:end);
subplot(3,1,1);
stem(fo,p1);
set(gca,'Xscale','log');
s=tf('s');
sys1=(s+3)/(s^2+s+1);
%xlim([0.01 20])
[y1,t1]=lsim(sys1,x,t);

Y1=fft(y1);
fo=0:Fs/length(Y1):Fs/2;

p22=abs(Y1/length(Y1));
p12=p22(1:length(Y1)/2+1);
p12(2:end)=2*p12(2:end);
subplot(3,1,2);
stem(fo,p1);

G=Y1'./Y;

%p2=abs(G/length(G));
%p1=p2(1:length(G)/2+1);
%p1(2:end)=2*p1(2:end);
subplot(3,1,3);
plot(fo,p12'./p1);
set(gca,'Xscale','log');
xlim([0.01 10])