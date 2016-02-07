function [Q,X,Y,Tax] = bound(m,n,ht,T)
%BOUND We implement a solver for the given non homogenous boundary
%conditions given. The solution is computed for the interior points
%(meaning that we have m(n-1) unknows). The source term used is always the 
%smooth one.
N = n-1;
hx = 1/m;
hy = 1/n;

%Definition of the axis
X = (0.5:m-0.5)'*hx;
Y = (1:N)'*hy; %the y-axis is shifted by half a cell
Tax = (0:T)'*ht;

%Construction of the stencil
e = ones(m,1);
M = spdiags([e -2*e e],-1:1,m,m);
M(1,1) = -1;
M(m,m) = -1;
A = kron(speye(N),M);
f = ones(n,1);
O = spdiags([f -2*f f],-1:1,N,N);
B = kron(O,speye(m));

C = A/(hx*hx)+B/(hy*hy);

%LU-decomposition
K = speye(N*m)-ht*C;
[L,U,P,V,R] = lu(K);

x = kron(ones(N,1),X);
y = kron(Y,ones(m,1));
q = zeros(N*m,T+1);
Q = zeros(N,m,T+1);

%The heat source is the smooth function    
S = exp(-((x-0.5).^2+(y-0.5).^2)/0.04);
%We have to also add b1 and b2 to S to keep boundary conditions
b1 = kron(ones(N,1),[1 spalloc(1,m-2,0) -1]'/hx);
b2 = [southBound(X);spalloc(m*(N-2),1,0);northBound(X)]/(hy*hy);
S = S+b1+b2;
for i = 1:T
    q(:,i+1) = V*(U\(L\(P*((q(:,i)+ht*S)./diag(R)))));
    Q(:,:,i+1) = reshape(q(:,i+1),m,N)';
end

end

function q0 = southBound(x)
q0 = ones(size(x));%sin(3*pi*x)./(3*pi) + 1;
end
function q1 = northBound(x)
q1 = 2*ones(size(x));%sin(3*pi*x)./(3*sin(pi*x)) + pi./(sin(pi*x));
end


