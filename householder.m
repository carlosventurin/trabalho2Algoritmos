function [raiz, hist] = rootHouseholder(x0, eps1, eps2, maxiter, func, dfunc, ddfunc)
    fprintf('--- R A I Z  P E L O  M E T O D O  D E  H O U S E H O L D E R ---\n');
    k = 1;
    x = x0;
    xseq = [x0]; % Vetor para armazenar as aproximações
    hist = {};
    
    while k <= maxiter
        fx = func(x);
        dfx = dfunc(x);
        ddfx = ddfunc(x);
        
        if abs(dfx) < eps2
            fprintf('Derivada primeira muito pequena. Parando...\n');
            break;
        end
        
        H = fx / dfx;
        G = ddfx / (2 * dfx);
        
        x_new = x - (H / (1 - H * G));
        d = abs(x_new - x);
        
        xseq = [xseq, x_new]; % Armazena a nova aproximação
        fprintf('iter=%4d  x= %26.20f  |x-xold|= %26.20f  f(x)= %26.20f\n', k, x_new, d, fx);
        
        if abs(fx) < eps1 || d < eps2
            break;
        end
        
        x = x_new;
        k = k + 1;
    end
    
    raiz = x;
    hist{1} = xseq; % Encapsula a sequência em uma célula
    
    fprintf('Razao(oes) de parada:\n');
    if k > maxiter, fprintf('\t\tNumero maximo de iteracoes %d atingido\n', k); end
    if abs(fx) <= eps1, fprintf('\t\tValor absoluto da funcao %e pequeno (menor que %e)\n', abs(fx), eps1); end
    if d <= eps2, fprintf('\t\tDistancia %e menor ou igual que limite %e apos %d iteracoes\n', d, eps2, k); end
    if (abs(x) == Inf || abs(x) == -Inf), fprintf('Divergencia\n'); end
end
