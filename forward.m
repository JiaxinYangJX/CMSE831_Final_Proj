close all;
clear;clc;

h = 0.01;
x = (-1:h:1)';
N = length(x);
transducer = [];
for i = 1:N
    for j = 1:N
        if (mod(i,8)==1&&(j==1||j==N)) || (mod(j,8)==1&&(i==1||i==N))
            transducer=[transducer;(j-1)*N+i];
        end
    end
end

f = ones(N,N);
for i = 1:N
    for j = 1:N
        if (i-N/2)^2 + (j-N/2)^2 < 5000
            f(i,j)=1/2;
        end
    end
end

%f= sin(5*x).^2*ones(1,N)+ones(N,1)*cos(5*x)'.^2+1;
M = length(transducer);
time = [];
for i=1:M
    u = traveltime(N,f,transducer(i));
    time = [time;u(transducer(i+1:M))];
end
save forward_f1.mat