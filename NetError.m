function error= NetError(net,data,target)
output= net(data);
if(iscell(output))
    output= output{1,1};
end;
[~, n]= size(output);
error= target-output;
error= error*error';