function result = cost(th,x,y)
[m,n] = size(x);
result = 0;
for i = 1:m
    result = result + (x(i,:)*th-y(i))^2;
end
result = result/2/m;
end