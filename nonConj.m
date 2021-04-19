function m = nonConj(time,m,N,transducer,epsilon)
% solve G(m)*m = d based on non conjugate method

% initailize
alpha = 0.3;
beta  = 0.5;
% calculate G
G = matrix(m,N,transducer);

residual       = G*m - time;
grad_next      = 2 * G.' * residual;
dire_conj_next = -grad_next;

% learning rate
t = 1;
cost_m = norm(residual);
while 1
    G_t = matrix(m+t*dire_conj_next,N,transducer);
    cost_t = norm(G_t * (m+t*dire_conj_next)-time);
    cond = cost_t - cost_m - alpha*t * grad_next.' * dire_conj_next;
    if cond <= 0
        break
    end
    t = beta*t;
        
end

% update
m     = m + t * dire_conj_next;
error = norm(t * dire_conj_next) / norm(m);
i = 0;

while (error > epsilon) && (i<1000)
    i = i + 1;
    dire_conj_prev = dire_conj_next;
    grad_prev      = grad_next;
    
    % calculate G
    G = matrix(m,N,transducer);

    % gradient
    residual  = G*m - time;
    grad_next = 2 * G.' * residual;
    
    % gamma 
    gamma = norm(grad_next)^2 / norm(grad_prev)^2;
    
    dire_conj_next = -grad_next + gamma*dire_conj_prev;
    
    % learning rate
    t = 1;
    cost_m = norm(residual);
    while 1
        G_t = matrix(m+t*dire_conj_next,N,transducer);
        cost_t = norm(G_t * (m+t*dire_conj_next)-time);
        cond = cost_t - cost_m - alpha*t * grad_next.' * dire_conj_next;
        if cond <= 0
            break
        end
        t = beta*t;
        
    end
   
    
    % update
    m     = m + t*dire_conj_next;
    error = norm(t * dire_conj_next) / norm(m);
    
    % plot
    figure(1)
    imagesc(reshape(1./m,N,N))
    title(['Iteration = ', num2str(i), 'Learning rate is ',num2str(t), 'Error is ',num2str(error)]);
    colorbar;
    pause(0.01)
    
end

end

