function [sys,x0,str,ts]=observer(t,x,u,flag,b,m,L)

switch flag
    case 0
        sys=[2;0;2;2;0;0;1];
        x0=[0;0];
        str=[];
        ts=[0 0];
    case 1
        sys(1)=x(2) +L(1)*(u(2)-x(1));
        sys(2)=-b/m*x(2)+1/m*u(1)+L(2)*(u(2)-x(1));
    case 3
        sys(1)=x(1);
        sys(2)=x(2);
    otherwise
        sys=[];
end
        