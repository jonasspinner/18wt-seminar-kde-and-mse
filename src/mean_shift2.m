function [A, C] = mean_shift2(X, kernel, epsilon)
    tol = 1e-2;
    max_iter = 100;
    
    [~, N] = size(X);
    Z = zeros(size(X));
        
    for i = 1:N
        x = X(:,i);
        for t = 1:max_iter
            x_next = m(x, X, kernel);

            if ((x_next - x)' * (x_next - x) < tol * tol)
                break
            end
            x = x_next;
        end
        Z(:, i) = x;
    end
    
    [A, C] = connected_component(Z, epsilon);
end

function x_next = m(x, X, kernel)
    [~, N] = size(X);
    w = zeros(N, 1);
    for i = 1:N
        w(i) = kernel(X(:,i), x);
    end
    
    x_next = X * w / sum(w);
end
