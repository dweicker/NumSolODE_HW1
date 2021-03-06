function [Q,X,Y,Tax] = eulerImpl(m,n,ht,T,fct,alpha)
%EULERIMPL Solves the problem with n cells in the x-direction and m cells
%in the y-direction
hx = 1/m;
hy = 1/n;

%Construction of the stencil
e = ones(m,1);
M = spdiags([e -2*e e],-1:1,m,m);
M(1,1) = -1;
M(m,m) = -1;
A = kron(speye(n),M);
f = ones(n,1);
N = spdiags([f -2*f f],-1:1,n,n);
N(1,1) = -1;
N(n,n) = -1;
B = kron(N,speye(m));
C = A/(hx*hx)+B/(hy*hy);

%LU-decomposition
K = speye(n*m)-ht*C;
[L,U,P,V,R] = lu(K);

%Definition of the axis
X = (0.5:m-0.5)'*hx;
Y = (0.5:n-0.5)'*hy;
Tax = (0:T)'*ht;

x = kron(ones(n,1),X);
y = kron(Y,ones(m,1));
q = zeros(n*m,T+1);
Q = zeros(n,m,T+1);
%The heat source is the dirac function
if strcmp(fct,'dirac')
    ep = alpha*sqrt(max([hx hy]));
    r = sqrt((x-0.5).^2+(y-0.5).^2);
    delta = (1+cos(pi*r))./(2*ep).*(r<ep);
    for i = 1:T
        S = 2*delta*(i*ht < 0.25);
        q(:,i+1) = V*(U\(L\(P*((q(:,i)+ht*S)./diag(R)))));
        Q(:,:,i+1) = reshape(q(:,i+1),m,n)';
    end
%The heat source is the smooth function    
else
    S = exp(-((x-0.5).^2+(y-0.5).^2)/0.04);
    for i = 1:T
        q(:,i+1) = V*(U\(L\(P*((q(:,i)+ht*S)./diag(R)))));
        Q(:,:,i+1) = reshape(q(:,i+1),m,n)';
    end
end

end
