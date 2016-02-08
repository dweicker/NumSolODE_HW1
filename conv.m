function [] = conv()
%CONV 
% close all;
% Convergence of Smooth Source
N = [40 80 160 320 640];
q = zeros(1,length(N));

for i = 1:length(N)
    Q = eulerImpl(N(i),N(i),0.05,30,'smo',1);
    q(i) = Q(1,1,30);
end
for i = 1:3
    orderSpace = log2(abs(q(i)-q(i+1))/abs(q(i+1)-q(i+2)));
end   
ht = [0.0004 0.0002 0.0001 0.00005 0.000025];
for i = 1:length(ht)
    T = round(0.3/ht(i));
    Q = eulerImpl(50,25,ht(i),T,'smo',1);
    q(i) = Q(1,1,T);
end
for i=1:3
    orderTemp = log2(abs(q(i)-q(i+1))/abs(q(i+1)-q(i+2)));
end


% Check convergence of Dirac
N = [40 80 160 320 640];
q = zeros(1,length(N));

for i = 1:length(N)
    Q = eulerImpl(N(i),N(i),0.05,30,'dirac',1);
    q(i) = Q(1,1,30);
end
for i = 1:3
    orderSpaceDirac = log2(abs(q(i)-q(i+1))/abs(q(i+1)-q(i+2)));
end   
ht = [0.0004 0.0002 0.0001 0.00005 0.000025];
for i = 1:length(ht)
    T = round(0.3/ht(i));
    Q = eulerImpl(50,25,ht(i),T,'dirac',1);
    q(i) = Q(1,1,T);
end
for i=1:3
    orderTempDirac = log2(abs(q(i)-q(i+1))/abs(q(i+1)-q(i+2)));
end


alpha = [10.^-[0:4] 10^-10]
for j = 1:length(alpha)
    N = [40 80 160 320 640];
q = zeros(1,length(N));

for i = 1:length(N)-1
    Q = eulerImpl(N(i),N(i),0.05,30,'dirac',alpha(j));
    q(i) = Q(1,1,30);
end
for i = 1:3-1
    orderSpaceDirac = log2(abs(q(i)-q(i+1))/abs(q(i+1)-q(i+2)))
end   
ht = [0.0004 0.0002 0.0001 0.00005 0.000025];
for i = 1:length(ht)-1
    T = round(0.3/ht(i));
    Q = eulerImpl(50,25,ht(i),T,'dirac',alpha(j));
    q(i) = Q(1,1,T);
end
for i=1:3-1
    orderTempDirac = log2(abs(q(i)-q(i+1))/abs(q(i+1)-q(i+2)))
end

end
end

