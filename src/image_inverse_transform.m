function [I] = image_inverse_transform(X, w, h, m, s)
    X = X(1:3, :);
    
    X(1, :) = X(1, :) * s(1) + m(1);
    X(2, :) = X(2, :) * s(2) + m(2);
    X(3, :) = X(3, :) * s(3) + m(3);
    
    T = reshape(X', w, h, 3);
    
    T = applycform(T, makecform('uvl2xyz'));
    I = xyz2rgb(T);
end