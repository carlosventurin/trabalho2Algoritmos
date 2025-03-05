% main.m
% Programa principal para comparar métodos de busca de raízes

% Limpar ambiente
clear;
clc;

% Definir a função e suas derivadas
f = @(x) x^3 - 2*x^2 - 5;  % Função f(x)
df = @(x) 3*x^2 - 4*x;      % Primeira derivada de f(x)
ddf = @(x) 6*x - 4;         % Segunda derivada de f(x)

% Parâmetros comuns
eps1 = 1e-6;  % Tolerância para |f(x)|
eps2 = 1e-6;  % Tolerância para |x(k+1) - x(k)|
maxiter = 100; % Número máximo de iterações

% Método da Bissecção
a = 1; b = 3; % Intervalo inicial
[raiz_bissecc, hist_bissecc] = bisseccPosFalsa(false, f, a, b, eps1, maxiter);

%Método da Posição Falsa
[raiz_bissecc, hist_bissecc] = bisseccPosFalsa(true, f, a, b, eps1, maxiter);

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
figure;
hold on;
plot(hist_bissecc{1}, 'DisplayName', 'Bissecção');
plot(hist_newton{1}, 'DisplayName', 'Newton-Raphson');
plot(hist_secante{1}, 'DisplayName', 'Secante');
plot(hist_muller{1}, 'DisplayName', 'Müller');
plot(hist_householder{1}, 'DisplayName', 'Householder');
xlabel('Iteração');
ylabel('Aproximação da raiz');
title('Evolução das Aproximações da Raiz');
legend;
grid on;
hold off;

% Exibir resultados finais
fprintf('\n=== Resultados Finais ===\n');
fprintf('Bissecção: raiz = %.10f\n', raiz_bissecc);
fprintf('Newton-Raphson: raiz = %.10f\n', raiz_newton);
fprintf('Secante: raiz = %.10f\n', raiz_secante);
fprintf('Müller: raiz = %.10f\n', raiz_muller);
fprintf('Householder: raiz = %.10f\n', raiz_householder);
