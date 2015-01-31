function F = FourVelocityMagnitude(g, xd)
    F = 0;
    for i = 1 : 4
        for j = i : 4
            F = F + g(i, j) * xd(i) * xd(j);
        end
    end
    F = simplify(F);
end

