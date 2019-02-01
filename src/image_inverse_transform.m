function [I] = image_inverse_transform(X, n_rows, n_cols, upvpl_mean, upvpl_std)
    X = X(1:3, :);
    
    X(1:3,:) = X(1:3,:) .* upvpl_std + upvpl_mean;
    
    T = reshape(X', n_rows, n_cols, 3);
    
    T = applycform(T, makecform('upvpl2xyz'));
    I = xyz2rgb(T);
end