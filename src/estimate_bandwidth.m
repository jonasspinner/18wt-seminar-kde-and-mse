function h = estimate_bandwidth(X, quantile)
    % Bandwidth estimation for kernel density estimates. The mean distance
    % of each data point to its (quantile * n)-nearest neighbor is used. A
    % quantile value of 0.5 means the median value of all pairwise
    % distances is used.
    % 
    % INPUTS:
    %          X - an d by n array with data points
    %   quantile - the quantile used; must be in [0, 1]
    %              the default value is 0.3
    % OUTPUTS:
    %          h - the estimated bandwidth
    %
    % Reference:
    %   See: scikit-learn implementation: https://github.com/scikit-learn/scikit-learn/blob/7389dba/sklearn/cluster/mean_shift_.py#L31
    % Example:
    %   X = [randn(3, 20) (randn(3, 40) + [2;0;6])];
    %   estimate_bandwidth(X)
    if nargin < 2
        quantile = 0.3;
    end

    [~, n] = size(X);
    K = ceil(n * quantile);
    [~, D] = knnsearch(X', X', 'K', K, 'Distance','euclidean');
    h = mean(D(:, K));
end