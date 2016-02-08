function [] = conv()
%CONV 
% close all;
N = [40 80 160 320 640];
q = zeros(1,length(N));

for i = 1:length(N)
    Q = eulerImpl(N(i),N(i),0.05,30,'smooth');
    q(i) = Q(1,1,30);
end
orderSpace1 = log2(abs(q(1)-q(2))/abs(q(2)-q(3)))
orderSpace2 = log2(abs(q(2)-q(3))/abs(q(3)-q(4)))
orderSpace3 = log2(abs(q(3)-q(4))/abs(q(4)-q(5)))
    
ht = [0.0004 0.0002 0.0001 0.00005 0.000025];
for i = 1:length(ht)
    T = round(0.3/ht(i));
    Q = eulerImpl(50,25,ht(i),T,'dirac');
    q(i) = Q(1,1,T);
    
end
orderTemp1 = log2(abs(q(1)-q(2))/abs(q(2)-q(3)))
orderTemp2 = log2(abs(q(2)-q(3))/abs(q(3)-q(4)))
orderTemp3 = log2(abs(q(3)-q(4))/abs(q(4)-q(5)))

end

