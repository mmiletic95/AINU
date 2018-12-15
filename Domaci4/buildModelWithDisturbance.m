function [Asd,Bsd,Csd] = buildModelWithDisturbance(A,B,C,Aw,Cw)

%create model of the system including model of the disturbance

Asd=[A , B*Cw; zeros(size(Aw,1),size(A,1)), Aw];
Bsd=[B;zeros(size(Aw,1),size(B,2))];
Csd=[C,zeros(1,size(Aw,1))];

end

