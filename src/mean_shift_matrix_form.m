function [A, C] = mean_shift_matrix_form(X, kernel, epsilon)
    tol = 1e-1;
    max_iter = 100;
    
    Z = X;
    for t = 1:max_iter
        W = apply_kernel(X, Z, kernel);
        D = diag(sum(W, 1));
        Q = W * D^(-1);
        Z_next = X * Q;
        
        if (max(abs(Z_next - Z), [], 'all') < tol)
            break
        end
        Z = Z_next;
    end
    disp(t)
    
    [A, C] = connected_component(Z, epsilon);
end

function P = apply_kernel(X, Z, kernel)
    [~, N] = size(X);
    [~, M] = size(Z);
    P = zeros(N, M);
    for n = 1:N
        for m = 1:M
            P(n, m) = kernel(X(:,n), Z(:,m));
        end
    end
end
