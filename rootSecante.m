%%=======================================================
% Determina��o de raiz usando m�todo de Secante
% Autor: Thomas W. Rauber trauber@gmail.com , 2009 a 2017
%%=======================================================
%%
%% Input: Valores iniciais x0, x1, toler�ncia de f(x), toler�ncia de x,
%%			 n�mero m�ximo de itera��es, a fun��o
%% Output: raiz sequência
%%
function [raiz, hist] = rootSecante(x0, x1, eps1, eps2, maxiter, func)
    fprintf('--- R A I Z  M E T O D O  D A  S E C A N T E ---\n');
    k = 1;
    fx0 = func(x0);
    fx1 = func(x1);
    fx = fx1;
    x = x1;
    xold0 = x0;
    xold1 = x1;
    d = eps2 + 1;
    denom = 1;
    xseq = [x0, x1]; % Vetor para armazenar as aproximações
    hist = {};

    fprintf('Secante x0= %.3f  x1= %.3f  eps |f(x)|= %.3e  eps |x-xold|= %.3e  maxiter=%d\n',...
             x0, x1, eps1, eps2, maxiter);

    while k <= maxiter && abs(fx) > eps1 && d > eps2 && abs(x) < Inf && abs(denom) > 0
        denom = fx1 - fx0;
        if denom == 0
            fprintf('Denominador (numericamente) zero. Parando ...\n');
        else
            num = xold0 * fx1 - xold1 * fx0;
            x = num / denom;
        end
        fprintf('\nx_%d = (x_%d f(x_%d) - x_%d f(x_%d)) / (f(x_%d)-f(x_%d)) = (%.4f*%.4f - %.4f*%.4f) / (%.4f-%.4f) = %.4e\n',...
            k+1, k-1, k, k, k-1, k, k-1, xold0, fx1, xold1, fx0, fx1, fx0, x);
        d = abs(x - xold1);
        fx = func(x);
        xseq = [xseq, x]; % Armazena o novo valor na sequência
        fprintf('iter=%4d  xold0= %26.20f  xold1= %26.20f  x= %26.20f  |x-xold1|= %26.20f  f(x)= %26.20f\n',...
            k, xold0, xold1, x, d, fx);
        xold0 = xold1; fx0 = fx1;
        xold1 = x; fx1 = fx;
        k = k + 1;
    end
    raiz = x;
    hist{1} = xseq; % Encapsula a sequência em uma célula

    fprintf('Razao(oes) de parada:\n');
    if k > maxiter, fprintf('\t\tNumero maximo de iteracoes %d atingido\n', k-1); end
    if abs(fx) <= eps1, fprintf('\t\tValor absoluto da funcao %e pequeno (menor que %e)\n', abs(fx), eps1); end
    if d <= eps2, fprintf('\t\tDistancia %e menor ou igual que limite %e apos %d iteracoes\n', d, eps2, k); end
    if (abs(x) == Inf || abs(x) == -Inf), fprintf('Divergencia\n'); end
    if (denom == 0), fprintf('\t\tDenominador numericamente zero\n'); end
end
