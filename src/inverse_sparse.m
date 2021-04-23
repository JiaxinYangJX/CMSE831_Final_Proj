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

load forward_poly.mat time

% calculate psi
[X,Y] = meshgrid(x,x);

psi = zeros(N^2, 6);
psi(:,1) = ones(N^2,1);
psi(:,2) = reshape(X,[],1);
psi(:,3) = reshape(Y,[],1);
psi(:,4) = reshape(X.^2,[],1);
psi(:,5) = reshape(X.*Y,[],1);
psi(:,6) = reshape(Y.^2,[],1);

[psi,~] = qr(psi,0);

m = 3*ones(N^2,1);

% different sparse algorithms
m = nonConj_sparse(time,m,N,transducer,psi,0.1);
m = nonConj_sparse_new(time,m,N,transducer,psi,0.1);

