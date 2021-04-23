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
M = length(transducer);

%% load one specific forward problem
load forward_f1.mat time
% load forward_sin.mat time
% load forward_poly.mat time

m = 0.8*ones(N^2,1);
% m = 2*ones(N^2,1);
% m = 3*ones(N^2,1);

m = nonConj(time,m,N,transducer);


