function [A, C] = connected_component(X, epsilon)
    [~, N] = size(X);
    A = zeros(1, N);
    C = [];
    c = 1;
    
    while any(A == 0)
        [~, i] = min(A);
        x = X(:, i);
        C = [C, x];
        d = sum((X - x).^2, 1);
        A(d < epsilon) = c;
        c = c + 1;
    end
end