function [sys,x0,str,ts]=model1(t,x,u,flag)
switch flag
    case 0
        sys=[2;0;1;1;0;0;1];
        x0=[0;0];
        str=[];
        ts=[0 0];
    case 1
        sys(1)=-x(1)-x(2)+u;
        sys(2)=x(1);
    case 3
        sys=x(1)+3*x(2);
    otherwise 
        sys=[];
end