clear all;clc
feature = [-62.8 -89.5 1.7
    3.3 -3.5 1.1
    -120.8 -103.2 2.5
    -18.1 -28.8 1.1
    -3.8 -50.6 0.9
    -61.2 -56.2 1.7
    -20.3 -17.4 1
    -194.5 -25.8 0.5
    20.8 -4.3 1
    -106.1 -22.9 1.5
    43 16.4 1.3
    47 16 1.9
    -3.3 4 2.7
    35 20.8 1.9
    46.7 12.6 0.9
    20.8 12.5 2.4
    33 23.6 1.5
    26.1 10.4 2.1
    68.6 13.8 1.6
    37.3 33.4 3.5
    ];
result = [0;0;0;0;0;0;0;0;0;0;1;1;1;1;1;1;1;1;1;1]; 

feature_mean = mean(feature);
feature_std = std(feature);
[m,n] = size(feature);
for i = 1:n
   feature(:,i) =  (feature(:,i)-feature_mean(i))/feature_std(i);
end


th = rand(n+1,1);
factor = [ones(m,1) feature];
alpha = 0.0001;
times = 2000;
plot(0,cost(th,factor,result),'.r')
axis([0 2100 0 1])
hold on;
for i = 1:times
    th = th - alpha * dec(th,factor,result);
    plot(i,cost(th,factor,result),'.r')
    hold on;
end
fin = result;
for i = 1:m
   fin(i) = 1/(1+exp(-factor(i,:)*th)); 
end
cost(th,factor,result)
fin

