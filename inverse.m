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

f = ones(N,N);
for i = 1:N
    for j = 1:N
        if (i-N/2)^2 + (j-N/2)^2 < 5000/4
            f(i,j)=1/2;
        end
    end
end


%f= sin(5*x).^2*ones(1,N)+ones(N,1)*cos(5*x)'.^2+1;
M = length(transducer);
load forward_f1.mat time

m=0.8*ones(N^2,1);

m = nonConj(time,m,N,transducer,0.1);

% rmse
sqrt(sum(sum(f-m)).^2)

