function [consSmooth,consDirac] = conserv()
%CONSERV This function checks conservation for both heat source
m =10;
n = 10;
ht = 0.00005;

%Conservation for smooth source
[Q,X,Y,T] = eulerImpl(m,n,ht,2/ht,'smooth',1);
x = kron(ones(n,1),X);
y = kron(Y,ones(m,1));
S = exp(-((x-0.5).^2+(y-0.5).^2)/0.04);
heatGiven = 2*sum(S)/(m*n);
heatSys = sum(sum(Q(:,:,end)))/(m*n);
consSmooth = abs(heatGiven-heatSys);

%Conservation for dirac source
[Q,X,Y,T] = eulerImpl(m,n,ht,2/ht,'dirac',1);
ep = sqrt(max([1/m 1/n]));
r = sqrt((x-0.5).^2+(y-0.5).^2);
delta = (1+cos(pi*r))./(2*ep).*(r<ep);
S = 2*delta;
heatGiven = 0.25*sum(S)/(m*n);
heatSys = sum(sum(Q(:,:,end)))/(m*n);
consDirac = abs(heatGiven-heatSys);

end

