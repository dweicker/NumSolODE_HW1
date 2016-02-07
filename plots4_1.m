function [ ] = plots4_1( )
% Make plots for problem 4.1
m = 200;
n = 200;
[Q,X,Y,Tax] = eulerImpl(m,n,0.05,10,'dirac');
figure(1)
for i=2:10
    subplot(3,3,i-1)
    mesh(X,Y,Q(:,:,i))
    title(sprintf('Dirac Source, T = %g', Tax(i)))
    xlabel('x')
    ylabel('y')
    zlabel('Q')
end

[Q,X,Y,Tax] = eulerImpl(m,n,0.05,10,'other');
figure(2)
for i=2:10
    subplot(3,3,i-1)
    mesh(X,Y,Q(:,:,i))
    title(sprintf('Smooth Source, T = %g', Tax(i)))
    xlabel('x')
    ylabel('y')
    zlabel('Q')
end
end

