function F = EquationofMotion(g, gi, x, xd, l)
   F = 0;
   for u = 1 : 4
       for v = 1 : 4
           F = F - ConnectionCoefficient(g, gi, x, l, u, v) * xd(u) * xd(v);
       end
   end
   F = simplify(F);
end

