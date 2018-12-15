function [x_hat,u,d_hat] = regulator(y,r,k,kr,A,B,L,C,Aw,Lw,Cw,T)
persistent  x_hat_p;
persistent w_hat_p;
if isempty(x_hat_p) || isempty(w_hat_p)
    x_hat_p=[0;0];
    w_hat_p=0;
end
d_hat=Cw*w_hat_p;
u=-k*x_hat_p+kr*r-d_hat;

x_hat=x_hat_p+T*(A*x_hat_p+B*(u+d_hat)+L*(y-C*x_hat_p));
w_hat_p=w_hat_p+T*(Aw*w_hat_p+Lw*(y-C*x_hat_p));
x_hat_p=x_hat;
end

