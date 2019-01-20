function [A, C, T] = mean_shift(X, kernel, h, epsilon)
    % Performes the mean shift algorithm with the
    % specified kernel and bandwidth h.
    %
    % INPUTS:
    %         X - an d by n array of data points
    %    kernel - the kernel used. 'gaussian' or 'uniform'
    %         h - the bandwidth used
    %   epsilon - the parameter for cluster pruning
    % OUTPUTS:
    %         A - an n by 1 array of cluster indices
    %         C - an d by n array of cluster centroids
    %         T - an n by 1 array of iterations needed
    %             for each data point
    tol = h * 1e-2; max_iter = 100;
    
    [d, n] = size(X);
    Z = zeros(d, n);
    T = zeros(n, 1);
        
    for i = 1:n
        x = X(:, i);
        for t = 1:max_iter
            switch kernel
                case 'gaussian'
                    w = exp(-0.5 * sum(((X - x) / h).^2, 1));
                case 'uniform'
                    w = sum(((X - x) / h).^2, 1) < 1;
            end

            x_next = X * w' / sum(w);

            if (norm(x_next - x) < tol)
                break
            end
            x = x_next;
        end
        Z(:, i) = x;
        T(i) = t;
    end
    
    [A, C] = connected_component(Z, epsilon);
end