function F = ConnectionCoefficient(g, gi, x, l, u, v)
    F = 0;
    for k = 1 : 4
        F = F + gi(l, k) * (diff(g(k, u), x(v)) + diff(g(k, v), x(u)) - diff(g(u, v), x(k))) / 2;
    end
end

