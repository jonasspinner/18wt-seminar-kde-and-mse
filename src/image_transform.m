function [X, n_rows, n_cols, upvpl_mean, upvpl_std] = image_transform(I)
    % Transform image to data matrix. It performs the
    % following steps:
    %   1. Convert rgb to 1976 CIE u'v'Y color space
    %      (also known as L*U*V* color space)
    %   2. Flatten image data into matrix
    %   3. Standardize luv coords to have zero mean
    %      and unit variance
    %   4. Add dimensions representing row/col
    %      coordinates with range [0, 1]
    %
    % INPUTS:
    %            I - an n_rows by n_cols by 3 image
    %                array in rgb color format
    % OUTPUTS:
    %            X - a 5 by n_rows * n_cols matrix
    %       n_rows - the number of image rows
    %       n_cols - the number of image columns
    %   upvpl_mean - a 3 by 1 vector. The mean vector
    %                of upvpl coordinates
    %    upvpl_std - a 3 by 1 vector. The std vector
    %                of upvpl coordindates
    %
    % Reference:
    %   See: https://en.wikipedia.org/wiki/CIELUV
    T = rgb2xyz(I);
    T = applycform(T, makecform('xyz2upvpl'));
    
    [n_rows, n_cols, ~] = size(T);
    n = n_rows * n_cols;
    X = reshape(T, n, 3)';
    
    upvpl_mean = mean(X, 2);
    upvpl_std = std(X, 0, 2);
    X(1:3,:) = (X(1:3,:) - upvpl_mean) ./ upvpl_std;
    
    row_vals = repmat(linspace(0,1,n_rows), 1, n_cols);
    col_vals = repmat(linspace(0,1,n_cols), n_rows, 1);
    X(4, :) = reshape(row_vals, n, 1)';
    X(5, :) = reshape(col_vals, n, 1)';
end