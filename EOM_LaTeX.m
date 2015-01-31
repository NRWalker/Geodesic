clear;
clc;

syms M J t r th ph td rd thd phd

x = [t r th ph];
xd = [td rd thd phd];

g = sym(zeros(4));
g(1, 1) = - (1 - 2 * M  / r);
g(2, 2) = 1 / (1 - 2 * M / r);
g(3, 3) = r ^ 2;
g(4, 4) = r ^ 2 * sin(th) ^ 2;
g(1, 4) = - 4 * J * sin(th) ^ 2 / r;
g(4, 1) = g(1, 4);
g = simplify(g);
gi = simplify(inv(g));

ct = sym(zeros(4));
cr = sym(zeros(4));
cth = sym(zeros(4));
cph = sym(zeros(4));

for i = 1 : 4
    for j = 1 : 4
        ct(i, j) = simplify(ConnectionCoefficient(g, gi, x, 1, i, j));
        cr(i, j) = simplify(ConnectionCoefficient(g, gi, x, 2, i, j));
        cth(i, j) = simplify(ConnectionCoefficient(g, gi, x, 3, i, j));
        cph(i, j) = simplify(ConnectionCoefficient(g, gi, x, 4, i, j));
    end
end

u = collect(simplify(FourVelocityMagnitude(g, xd)), J);
at = collect(simplify(EquationofMotion(g, gi, x, xd, 1)), J);
ar = collect(simplify(EquationofMotion(g, gi, x, xd, 2)), J);
ath = collect(simplify(EquationofMotion(g, gi, x, xd, 3)), J);
aph = collect(simplify(EquationofMotion(g, gi, x, xd, 4)), J);

uf = collect(simplify(taylor(u, J, 'Order', 2)), J);
atf = collect(simplify(taylor(at, J, 'Order', 2)), J);
arf = collect(simplify(taylor(ar, J, 'Order', 2)), J);
athf = collect(simplify(taylor(ath, J, 'Order', 2)), J);
aphf = collect(simplify(taylor(aph, J, 'Order', 2)), J);

a = cellstr(['\mathrm{th} ';...
             '\mathrm{ph} ';...
             '\mathrm{td} ';...
             '\mathrm{rd} ';...
             '\mathrm{thd}';
             '\mathrm{phd}']);
b = cellstr(['\theta      ';...
             '\phi        ';...
             '\dot{t}     ';...
             '\dot{r}     ';...
             '\dot{\theta}';...
             '\dot{\phi}  ']);
n = length(a);

G = latex(g);
GI = latex(gi);
CT = latex(ct);
CR = latex(cr);
CTH = latex(cth);
CPH = latex(cph);
U = latex(u);
AT = latex(at);
AR = latex(ar);
ATH = latex(ath);
APH = latex(aph);
UF = latex(uf);
ATF = latex(atf);
ARF = latex(arf);
ATHF = latex(athf);
APHF = latex(aphf);

for i = 1 : n
    G = strrep(G, a(i), b(i));
    GI = strrep(GI, a(i), b(i));
    CT = strrep(CT, a(i), b(i));
    CR = strrep(CR, a(i), b(i));
    CTH = strrep(CTH, a(i), b(i));
    CPH = strrep(CPH, a(i), b(i));
    U = strrep(U, a(i), b(i));
    AT = strrep(AT, a(i), b(i));
    AR = strrep(AR, a(i), b(i));
    ATH = strrep(ATH, a(i), b(i));
    APH = strrep(APH, a(i), b(i));
    UF = strrep(UF, a(i), b(i));
    ATF = strrep(ATF, a(i), b(i));
    ARF = strrep(ARF, a(i), b(i));
    ATHF = strrep(ATHF, a(i), b(i));
    APHF = strrep(APHF, a(i), b(i));
end

G = G{1};
GI = GI{1};
CT = CT{1};
CR = CR{1};
CTH = CTH{1};
CPH = CPH{1};
U = U{1};
AT = AT{1};
AR = AR{1};
ATH = ATH{1};
APH = APH{1};
UF = UF{1};
ATF = ATF{1};
ARF = ARF{1};
ATHF = ATHF{1};
APHF = APHF{1};