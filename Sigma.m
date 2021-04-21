function sigma = Sigma(psi,m,epsilon)
% calculate sigma
N = size(psi,2);
sigma = sqrt((psi'*m).^2 + epsilon);
end

