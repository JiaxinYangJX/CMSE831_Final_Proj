close all;
clear;clc;

h = 0.02;
x = (-1:h:1)';
N = length(x);
transducer = [];
for i = 1:N
    for j = 1:N
        if (mod(i,4)==1&(j==1|j==N)) | (mod(j,4)==1&(i==1|i==N))
            transducer=[transducer;(j-1)*N+i];
        end
    end
end
f= sin(5*x).^2*ones(1,N)+ones(N,1)*cos(5*x)'.^2+1;
M = length(transducer);
load forward_iter1000.mat time

m=ones(N^2,1);

for i=1:1000
    G=matrix(m,N,transducer);
    
    % what to do
    m = ridge(time,G,0.1);
    
    figure(1)
    imagesc(reshape(1./m,N,N))
    title(i);
    colorbar;
    pause(0.01)
    
end

