function [theta] =recursive_least_squeres(eta,fi,ro)
persistent theta_p
persistent P_p
if isempty(theta_p)
    theta_p=zeros(size(fi));
    P_p=1000*eye(size(fi,1));
end
   P=1/ro*(P_p-P_p*fi * fi'*P_p/ (ro+fi'*P_p*fi));
   theta=theta_p+P*fi*(eta-fi'*theta_p);
   theta_p=theta;
   P_p=P;
end

