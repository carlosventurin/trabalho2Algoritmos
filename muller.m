function [raiz, hist] = rootMuller(x0, x1, x2, eps1, eps2, maxiter, func)
    fprintf('--- R A I Z  M E T O D O  D E  M U L L E R ---\n');
    k = 1;
    xseq = [x0, x1, x2]; % Vetor para armazenar as aproximações
    hist = {};
    
    while k <= maxiter
        f0 = func(x0);
        f1 = func(x1);
        f2 = func(x2);
        
        h1 = x1 - x0;
        h2 = x2 - x1;
        
        delta1 = (f1 - f0) / h1;
        delta2 = (f2 - f1) / h2;
        
        a = (delta2 - delta1) / (h2 + h1);
        b = a * h2 + delta2;
        c = f2;
        
        % Resolvendo a equação quadrática
        D = sqrt(b^2 - 4*a*c);
        if abs(b + D) > abs(b - D)
            x = x2 - (2 * c) / (b + D);
        else
            x = x2 - (2 * c) / (b - D);
        end
        
        xseq = [xseq, x]; % Armazena a nova aproximação
        d = abs(x - x2);
        fx = func(x);
        
        fprintf('iter=%4d  x= %26.20f  |x-xold|= %26.20f  f(x)= %26.20f\n', k, x, d, fx);
        
        if abs(fx) < eps1 || d < eps2
            break;
        end
        
        % Atualizar os pontos para a próxima iteração
        x0 = x1;
        x1 = x2;
        x2 = x;
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