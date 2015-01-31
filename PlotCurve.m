function [IM, MAXE, ME, STDE] = PlotCurve(S, U)
    Tau = S(1, :);
    T = S(2, :);
    R = S(3, :);
    Th = S(4, :);
    Ph = S(5, :);
    Td = S(6, :);
    Rd = S(7, :);
    Thd = S(8, :);
    Phd = S(9, :);
    
    N = length(Tau);
    
    IM = U(T, R, Th, Ph, Td, Rd, Thd, Phd);
    MAXE = max(abs(IM + 1));
    ME = mean(abs(IM + 1));
    STDE = std(abs(IM + 1));
    
    A = R .* sin(Th);
    X = A .* cos(Ph);
    Y = A .* sin(Ph);
    Z = R .* cos(Th);
    B = max(R);
    
    clf;
    P1 = subplot(1, 2, 1);
    hold on;
    i = floor(N / 100);
    j = N - i;
    
    for k = 1 : i : j
        plot3(X(k : k + i), Y(k : k + i), Z(k : k + i), 'Color', ...
              [k / j, 0.0, (j - k) / j]);
    end
    axis([-B B -B B -B B]);
    title('$R(x, y, z)$', 'Interpreter', 'LaTex', 'FontSize', 20);
    xlabel('$x$', 'Interpreter', 'LaTex', 'FontSize', 20);
    ylabel('$y$', 'Interpreter', 'LaTex', 'FontSize', 20);
    zlabel('$z$', 'Interpreter', 'LaTex', 'FontSize', 20);
    hold off;
    
    B1 = min(IM) - .1 * abs(min(IM));
    B2 = max(IM) + .1 * abs(max(IM));
    
    P2 = subplot(1, 2, 2);
    plot(Tau ./ max(Tau), IM);
    axis([0 1 B1 B2]);
    title('$u_{\mu}u^{\mu}$ vs. $\tau$', 'Interpreter', 'LaTex', 'FontSize', 20);
    xlabel('$\frac{\tau}{\tau_{f}}$', 'Interpreter', 'LaTex', 'FontSize', 20);
    ylabel('$u_{\mu}u^{\mu}$', 'Interpreter', 'LaTex', 'FontSize', 20);
end

