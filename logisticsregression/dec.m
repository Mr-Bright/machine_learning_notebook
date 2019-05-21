function result = dec(th,x,y)
[m,n] = size(x);
result = th;
for i = 1:n
   temp = 0;
   for j = 1:m
      temp = temp+(1/(1+exp(-x(j,:)*th-y(j))))*x(j,i);
   end
    result(i) = temp/m;
end
end