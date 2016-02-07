function [] = conv()
%CONV 
% close all;
N = [40 80 160];
q = zeros(1,length(N));

for i = 1:length(N)
    Q = eulerImpl(N(i),N(i),0.05,30,'smooth');
    q(i) = Q(1,1,30);
end
orderSpace = log2(abs(q(1)-q(2))/abs(q(2)-q(3)));display(q(2)-q(3));display(q(2)-q(1));
display(orderSpace);
    
ht = [0.0004 0.0002 0.0001];
for i = 1:length(ht)
    T = round(0.3/ht(i));
    Q = eulerImpl(50,25,ht(i),T,'dirac');
    q(i) = Q(1,1,T);
    display(ht(i));
end
orderTemp = log2(abs(q(1)-q(2))/abs(q(2)-q(3)));
display(orderTemp);

end

