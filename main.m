% main.m
% Programa principal para comparar métodos de busca de raízes

% Limpar ambiente
clear;
clc;

% Definir a função e suas derivadas
f = @(x) x.^3 - 2*x.^2 - 5;
df = @(x) 3*x.^2 - 4*x;
ddf = @(x) 6*x - 4;

% Parâmetros comuns
eps1 = 1e-6;  % Tolerância para |f(x)|
eps2 = 1e-6;  % Tolerância para |x(k+1) - x(k)|
maxiter = 100; % Número máximo de iterações

% Método da Bissecção
a = 1; b = 3; % Intervalo inicial
[raiz_bissecc, hist_bissecc] = bisseccPosFalsa(false, f, a, b, eps1, maxiter);

%Método da Posição Falsa
[raiz_falsa, hist_falsa] = bisseccPosFalsa(true, f, a, b, eps1, maxiter);

% Método de Newton-Raphson
x0_newton = 2; % Valor inicial
[raiz_newton, hist_newton] = rootNewton(x0_newton, eps1, eps2, maxiter, f, df);

% Método das Secantes
x0_secante = 1; x1_secante = 3; % Valores iniciais
[raiz_secante, hist_secante] = rootSecante(x0_secante, x1_secante, eps1, eps2, maxiter, f);

% Método de Müller
x0_muller = 1; x1_muller = 2; x2_muller = 3; % Valores iniciais
[raiz_muller, hist_muller] = rootMuller(x0_muller, x1_muller, x2_muller, eps1, eps2, maxiter, f);

% Método de Householder
x0_householder = 2; % Valor inicial
[raiz_householder, hist_householder] = rootHouseholder(x0_householder, eps1, eps2, maxiter, f, df, ddf);

% Gerar gráficos
grafico(f, hist_bissecc, 'Bissecção', 1);
grafico(f, hist_falsa, 'Posição Falsa', 2);
grafico(f, hist_newton, 'Newton-Raphson', 3);
grafico(f, hist_secante, 'Secantes', 4);
grafico(f, hist_muller, 'Muller', 5);
grafico(f, hist_householder, 'Householder', 6);
