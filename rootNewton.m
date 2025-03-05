%%=======================================================
% Determinação de raiz usando método de Newton
% Autor: Thomas W. Rauber trauber@gmail.com , 2009 a 2017
%%=======================================================
%%
%% Input: Valor inicial x0, tolerância de f(x), tolerância de x,
%%			 número máximo de iterações, a função e sua derivada
%% Output: raiz sequencia
%%
function [raiz, hist] = rootNewton(x0, eps1, eps2, maxiter, func, dfunc)
    fprintf('--- R A I Z  M E T O D O  D E  N E W T O N - R A P H S O N ---\n');
    fprintf('Valor inicial = %7.2f\n', x0);
    k = 1;
    x = x0;
    fx = eps1 + 1;
    d = eps2 + 1;
    xold = x0;
    xseq = [x0]; % Vetor para armazenar as aproximações
    hist = {};

    while k <= maxiter && abs(fx) > eps1 && d > eps2 && abs(x) < Inf
        try
            fx = func(x);
            if ~isreal(fx), error('Valor f(x) eh complexo.'); end
            dfx = dfunc(x);
            if ~isreal(dfx), error('Valor df(x)/dx eh complexo.'); end
        catch err
            fprintf('Impossivel determinar raiz da funcao. Valor nao eh real.\n');
            raiz = NaN;
            hist{1} = xseq;
            return;
        end
        x = x - fx / dfx;
        d = abs(x - xold);
        xseq = [xseq, x]; % Armazena a nova aproximação
        fprintf('iter=%4d  x(%3d)= %21.15f  x(%3d)= %21.15f  |x-xold|= %24.15e  f(x(%3d))= %24.15e f''(x(%3d))=%24.15e\n',...
            k, k-1, xold, k, x, d, k-1, fx, k-1, dfx);
        xold = x;
        k = k + 1;
    end
    raiz = x;
    hist{1} = xseq; % Encapsula a sequência em uma célula

    fprintf('Razao(oes) de parada:\n');
    if k > maxiter, fprintf('\t\tNumero maximo de iteracoes %d atingido\n', k-1); end
    if abs(fx) <= eps1, fprintf('\t\tValor absoluto da funcao %e pequeno (menor que %e)\n', abs(fx), eps1); end
    if d <= eps2, fprintf('\t\tDistancia %e menor ou igual que limite %e apos %d iteracoes\n', d, eps2, k-1); end
    if (abs(x) == Inf || abs(x) == -Inf), fprintf('Divergencia\n'); end
end