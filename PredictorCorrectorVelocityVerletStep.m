function [F] = PredictorCorrectorVelocityVerletStep(S, A, H, I)
    T = S(1, I);
    X = S(2 : 5, I);
    V = S(6 : 9, I);

    A0 = A(X(1), X(2), X(3), X(4), V(1), V(2), V(3), V(4));

    T = T + H;
    X = X + H * (V + H * A0 / 2);
    V = V + H * A0;

    A1 = A(X(1), X(2), X(3), X(4), V(1), V(2), V(3), V(4));

    V = V + H * (A1 - A0) / 2;
    
    F = [T; X(1); X(2); X(3); X(4); V(1); V(2); V(3); V(4)];
end

