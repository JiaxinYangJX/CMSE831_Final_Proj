function m = nonConj_sparse(time,m,N,transducer,psi,lambda)
% solve G(m)*m = d based on non conjugate method
error_list = [];
error_change = 100;
epsilon = 0.1;
% initailize
alpha = 0.3;
beta  = 0.4;
% calculate G
i = 1
G = matrix(m,N,transducer);
sigma = Sigma(psi,m,epsilon);
residual       = G*m - time;
constrain      = lambda * psi * (diag(1./sigma)) * psi' * m;
grad_next      = 2 * G' * residual + constrain;
dire_conj_next = -grad_next;


% learning rate
t = 1;
cost_m = norm(residual)^2 + lambda * norm(psi'* m,1);
tmp = grad_next' * dire_conj_next;

while 1
    new_m = m+t*dire_conj_next;
    if min(new_m) <= 0
        t = beta*t;
        continue
    end
    G_t = matrix(new_m,N,transducer);
    cost_t = norm(G_t * new_m - time)^2 + lambda * norm(psi'* new_m,1);
    cond = cost_t - cost_m - alpha * t * tmp;
    if cond <= 0
        break
    end
    t = beta*t;
        
end

% update
m     = new_m;
error = cost_t
error_list = [error_list; error];

% plot
figure(1)
imagesc(reshape(m,N,N))
title(['Iteration = ', num2str(i), ' Learning rate is ',num2str(t), ' Loss is ',num2str(error)]);
colorbar;
pause(0.01)

% save
save('out_sparse.mat','m','error_list');

while (i < 1000) && (error_change > 0.1)
    i = i + 1
    dire_conj_prev = dire_conj_next;
    grad_prev      = grad_next;
    
    % calculate G
    G = G_t;

    % gradient
    sigma = Sigma(psi,m,epsilon);
    residual  = G*m - time;
    constrain = lambda * psi * (diag(1./sigma)) * psi' * m;
    grad_next = 2 * G' * residual + constrain;
    
    % gamma 
    gamma = norm(grad_next)^2 / norm(grad_prev)^2;
    
    dire_conj_next = -grad_next + gamma*dire_conj_prev;
    
    % learning rate
    t = 1;
    cost_m = norm(residual)^2 + lambda * norm(psi'* m,1);
    tmp = grad_next' * dire_conj_next;
    while 1
        new_m = m+t*dire_conj_next;
        if min(new_m) <= 0
            t = beta*t;
            continue
        end
        G_t = matrix(new_m,N,transducer);
        cost_t = norm(G_t * new_m - time)^2 + lambda * norm(psi'* new_m,1);
        cond = cost_t - cost_m - alpha * t * tmp;
        if cond <= 0
            break
        end
        t = beta*t;
    end
   
    
    % update
    m     = new_m;
    error = cost_t
    error_list = [error_list; error];
    error_change = error - error_list(i-1);
    % plot
    figure(1)
    imagesc(reshape(m,N,N))
    title(['Iteration = ', num2str(i), ' Learning rate is ',num2str(t), ' Loss is ',num2str(error)]);
    colorbar;
    pause(0.01)
    
    %save
    save('out_sparse.mat','m','error_list');
end

end

