function result = cost(th,x,y)
[m,n] = size(x);
result = 0;
for i = 1:m
    result = result -y(i)*log(1/(1+exp(-x(i,:)*th)))-(1-y(i))*log(1-1/(1+exp(-x(i,:)*th)));
end
result = result/m;
end