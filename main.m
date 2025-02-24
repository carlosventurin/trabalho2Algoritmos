f = @(x) x.^3 - 9*x + 3;  % Função escolhida
df = @(x) 3*x.^2 - 9;
df2 = @(x) 6*x;
a = 0;
b = 2;
eps = 1e-6; % Tolerância máxima
maxiter = 10; % Número máximo de iterações

% Executar método da bissecção
[raizBissec, histBissec] = bisseccPosFalsa(false, f, a, b, eps, maxiter);

% Executar método da posição falsa
[raizPosFalsa, histPosFalsa] = bisseccPosFalsa(true, f, a, b, eps, maxiter);

disp("Resultados - Método da Bissecção:");
tabela = [(1:length(histBissec{1}))', histBissec{1}', [NaN, abs(diff(histBissec{1}))]'];
fprintf('%12s | %10s | %10s | %15s |\n', 'Iteração', 'x(k)', 'f(x(k))', '|x(k+1) - x(k)|');
fprintf('--------------------------------------------------------\n');
for i = 1:size(tabela,1)
    fprintf('%10d | %10.6f | %10.6f | %15.6f |\n', i, tabela(i,2), f(tabela(i,2)), tabela(i,3));
end