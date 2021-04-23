function G=matrix(m,N,transducer)
M=length(transducer);
G=sparse(M*(M-1)/2,N^2);
count=0;
for i = 1:M
    u = traveltime(N,reshape(m,N,N),transducer(i));
    for j=i+1:M
        count=count+1;
        endpoint = transducer(j);
        [path,weight]=geodesic(N,u,endpoint);
        G(count,path)=weight;
    end
end
G = G*2/(N-1);
end