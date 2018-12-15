function [Ao,Bo,Co,Do] = buildObserver(Asd,Bsd,Csd,L,systemOrder)

% define A,B,C,D matrices for observer

Ao=Asd-L*Csd;
Bo=[Bsd L];
Co=eye(systemOrder+1);
Co=[Co zeros( size(Co,1) , size(Ao,1)-size(Co,2) )];
Do=zeros(size(Co,1),size(Bo,2));
end

