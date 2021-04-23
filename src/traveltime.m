function u=traveltime(N,f,transducer)
u = Inf(N, N);
h = 2 /(N-1);
for t=1:1000
    for i = 1:N
        for j = 1:N
            if i == 1
                a = u(2,j);
            elseif i==N
                a = u(N-1,j);
            else
                a = min(u(i+1,j),u(i-1,j));
            end
            
            if j == 1
                b = u(i,2);
            elseif j==N
                b = u(i,N-1);
            else
                b = min(u(i,j+1),u(i,j-1));
            end
            
            if abs(a-b)>=f(i,j)*h
                unew(i,j) = min(a,b)+f(i,j)*h;
            else
                unew(i,j) = (a+b+sqrt(2*f(i,j)^2*h^2-(a-b)^2))/2;
            end
        end
    end
    u=min(unew,u);
    u(transducer)=0;
%    if mod(t,1000) == 0
%        imagesc(u)
%        title(t)
%        colorbar;
%        pause(0.01)
%    end
end
end