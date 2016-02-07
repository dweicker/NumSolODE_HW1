function [ aa ] = plot4_2( )
%(0.25,0.25)
m = 9*3^3
n = m;
delta_t = 0.05; 
values = zeros(1,10);
time_steps = 2;
for i = 1:4
    [Q,X,Y,Tax] = eulerImpl(m,n,delta_t,time_steps,'other');
    values(i) = Q((X == 0.5),(Y == 0.5), end);
    %m = m*3;
    %n = m;
    time_steps = time_steps*2; 
    delta_t = delta_t/2;
end

j = 2;
(values(j) - values(j+1))/(values(j+1)-values(j+2))
%(values(2) - values(3))/(values(3)-values(4))
%(values(7) - values(6))/(values(8)-values(7))
end

