function [] = plots()
%PLOTS 

[Q,X,Y,T] = eulerImpl(500,400,0.05,20,'smooth');
for i = 1:21
    mesh(X,Y,Q(:,:,i));xlabel('xdirection');ylabel('ydirection');zlabel('Temperature');axis([0 1 0 1 0 0.15]);
    M(i) = getframe;
end
end

