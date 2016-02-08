function [orderSpace,orderTime] = varCoeffConv()
%VARCOEFF This function computes the order of convergence for space and
%time for the equation with variable coefficients. It also plots the 
%solution at different times for the most refined mesh.
close all;

%Space convergence
N = [40 80 160 320 640];
q = zeros(size(N));
n = length(N);
for i = 1:n;
    [Q,X,Y,T] = variableCoeff(N(i),N(i),0.05,20);
    q(i) = Q(end,end,end);
end
orderSpace = log2(abs(q(1:n-2)-q(2:n-1))./abs(q(2:n-1)-q(3:n)));

%Time convergence
ht = [0.08 0.04 0.02 0.01 0.005];
tend = 5*ht(1);
p = zeros(size(ht));
n = length(ht);
for i = 1:n
    [P,x,y,t] = variableCoeff(200,200,ht(i),round(tend/ht(i)));
    p(i) = P(end,end,end);
end
orderTime = log2(abs(p(1:n-2)-p(2:n-1))./abs(p(2:n-1)-p(3:n)));

%Plot of the solution
figure;
for i = 1:9;
    subplot(3,3,i);
    mesh(X,Y,Q(:,:,2*i));
    title(sprintf('Variable Coeff, T = %g', T(2*i)));
    xlabel('x');
    ylabel('y');
    zlabel('Q');
end
end

