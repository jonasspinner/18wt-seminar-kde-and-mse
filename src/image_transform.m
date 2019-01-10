function [X, w, h, m, s] = image_transform(I)
    T = rgb2xyz(I);
    T = applycform(T, makecform('xyz2uvl'));
    
    [w, h, ~] = size(T);
    X = reshape(T, w * h, 3)';
    
    m = mean(X, 2);
    s = std(X, 1, 2);
    X(1, :) = (X(1, :) - m(1)) / s(1);
    X(2, :) = (X(2, :) - m(2)) / s(2);
    X(3, :) = (X(3, :) - m(3)) / s(3);
    
    X(4, :) = reshape(repmat((1:w) / w, 1, h), w * h, 1)';
    X(5, :) = reshape(repmat((1:h) / h, w, 1), w * h, 1)';
end