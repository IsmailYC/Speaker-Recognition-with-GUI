function PlotResult(result)
[n,m]=size(result);
x=1:m;
figure;
grids= ceil(sqrt(n));
for i=1:n
    subplot(grids,grids,i);
    plot(x,result(i,:));
end;