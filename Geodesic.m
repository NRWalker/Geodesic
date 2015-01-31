clear;
clc;

syms M J T R Th Ph Td Rd Thd Phd
x = [T R Th Ph];
xd = [Td Rd Thd Phd];
v = [T R Th Ph Td Rd Thd Phd];

dt = .01;
O = 2;
EV = J;
EO = 0;
AZ = 2 * pi * O;

g = sym(zeros(4));
g(1, 1) = - (1 - 2 * M  / R);
g(2, 2) = 1 / (1 - 2 * M / R);
g(3, 3) = R ^ 2;
g(4, 4) = R ^ 2 * sin(Th) ^ 2;
g(1, 4) = - 4 * J * sin(Th) / R;
g(4, 1) = g(1, 4);
g = simplify(g);
gi = simplify(inv(g));

U = simplify(FourVelocityMagnitude(g, xd));
AT = simplify(EquationofMotion(g, gi, x, xd, 1));
AR = simplify(EquationofMotion(g, gi, x, xd, 2));
ATh = simplify(EquationofMotion(g, gi, x, xd, 3));
APh = simplify(EquationofMotion(g, gi, x, xd, 4));

if EO > 0
    AT = simplify(taylor(AT, EV, 'Order', EO));
    AR = simplify(taylor(AR, EV, 'Order', EO));
    ATh = simplify(taylor(ATh, EV, 'Order', EO));
    APh = simplify(taylor(APh, EV, 'Order', EO));
end

M = 1.0;
J = 1.0;

t = 0.0;
r = 10.0;
th = pi / 2;
ph = 0.0;

rd = 0.0;
thd = 0.0;
phd = sqrt((r - 2 * M) / (r - 3 * M) - 1) / r;
a = 1 - 2 * M / r;
b = 4 * J * sin(th) ^ 2 * phd / r;
c = -(rd ^ 2  / (1 - 2 * M / r) + ...
      r ^ 2 * (thd ^ 2 + sin(th) ^ 2 * phd ^ 2) + 1);
td = (-b + sqrt(b ^ 2  - 4 * a * c)) / (2 * a);

U = matlabFunction(simplify(eval(U)), 'vars', v);
AT = matlabFunction(simplify(eval(AT)), 'vars', v);
AR = matlabFunction(simplify(eval(AR)), 'vars', v);
ATh = matlabFunction(simplify(eval(ATh)), 'vars', v);
APh = matlabFunction(simplify(eval(APh)), 'vars', v);

A = @(T, R, Th, Ph, Td, Rd, Thd, Phd)...
     [AT(T, R, Th, Ph, Td, Rd, Thd, Phd);...
      AR(T, R, Th, Ph, Td, Rd, Thd, Phd);...
      ATh(T, R, Th, Ph, Td, Rd, Thd, Phd);...
      APh(T, R, Th, Ph, Td, Rd, Thd, Phd)];
  
S = zeros(9, 1);
S(:, 1) = [0; t; r; th; ph; td; rd; thd; phd];
h = dt;
S(:, 2) = PredictorCorrectorVelocityVerletStep(S, A, h, 1);

i = 3;

W = waitbar(0, 'CALCULATING');

TS = tic;

while S(5, end) < AZ
    S(:, i) = BeemanStep(S, A, h, i - 1);
    waitbar(S(5, i) / AZ);
    i = i + 1;
end

TE = toc(TS);

close(W);

[IM, MAXE, ME, STDE] = PlotCurve(S, U);

disp(['TIME ELAPSED: ', num2str(TE)]);
disp(['MAXIMUM ERROR: ', num2str(MAXE)]);
disp(['MEAN ERROR: ', num2str(ME)]);
disp(['STANDARD DEVIATION ERROR: ', num2str(STDE)]);