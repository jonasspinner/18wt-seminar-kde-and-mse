function [A, C] = connected_component(X, epsilon)
    % Performes data pruning. An implicit neighborhood
    % graph is constructed in which x_i and x_j are
    % connected if ||x_i - x_j|| < epsilon. Then points
    % are randomly chosen and all its neighbors are
    % assigned to the same cluster.
    %
    % INPUTS:
    %         X - a d by n matrix with data points
    %   epsilon - the distance in which points are merged
    % OUTPUTS:
    %         A - a n by 1 vector with cluster indices
    %         C - a d by max(A) matrix with cluster
    %             representatives
    [d, n] = size(X);
    A = zeros(n, 1);
    C = zeros(d, n);
    % the number of connected components found yet
    c = 0;
    
    while any(A == 0)
        c = c + 1;
        % find i for which x_i has not yet been assigned
        i = find(~A, 1);
        x = X(:, i);
        C(:, c) = x;
        d = sum((X - x).^2, 1).^0.5;
        A(d < epsilon) = c;
    end
    C = C(:, 1:c);
end