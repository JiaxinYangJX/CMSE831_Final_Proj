function [path,weight]=geodesic(N,u,endpoint)
U = Inf(N+4,N+4);
U(3:N+2,3:N+2)=u;
x=mod(endpoint-1,N)+1;
y=(endpoint-x)/N+1;
path = [(y-1)*N+x];
weight=[1];
mask = [0,sqrt(5),0,sqrt(5),0;
    sqrt(5),sqrt(2),1,sqrt(2),sqrt(5);
    0,1,0,1,0;
    sqrt(5),sqrt(2),1,sqrt(2),sqrt(5);
    0,sqrt(5),0,sqrt(5),0];
idx=find(mask==0);
while u(path(1))~=0
    localU=U(x:x+4,y:y+4)-U(x+2,y+2);
    localU=localU./mask;
    localU(idx)=NaN;
    argmin = find(localU==min(min(localU)));
    argmin = argmin(1);
    local_x=mod(argmin-1,5)+1;
    local_y=(argmin-local_x)/5+1;
    x = x+local_x-3;
    y = y+local_y-3;
    path = [(y-1)*N+x;path];
    weight = [mask(local_x,local_y);weight];
end
end


