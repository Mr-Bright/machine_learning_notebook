clear all;clc
feature = [2104 5 1 45;
    1416 3 2 40;
    1534 3 2 30;
    852 2 1 36
    ];
result = [460;232;315;178]; 

feature_mean = mean(feature);
feature_std = std(feature);
[m,n] = size(feature);
for i = 1:n
   feature(:,i) =  (feature(:,i)-feature_mean(i))/feature_std(i);
end


th = rand(n+1,1);
factor = [ones(m,1) feature];
alpha = 0.01;
times = 2000;
plot(0,cost(th,factor,result),'.r')
axis([0 2100 0 1000])
hold on;
for i = 1:times
    th = th - alpha * dec(th,factor,result);
    plot(i,cost(th,factor,result),'.r')
    hold on;
end
fin = result;
for i = 1:m
   fin(i) = factor(i,:)*th; 
end
cost(th,factor,result)
fin

