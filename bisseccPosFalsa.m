%%=========================================================%%
%% Determinação de raiz de função: Bissecção e Posição Falsa
%% R.-L. p. 41 e p. 47
%% Autor: Thomas W. Rauber trauber@gmail.com , 2008 a 2021
%%
%% Input:
%%		1)	Variável lógica 'posfalsa'. Se for verdadeira,
%%			use Posição Falsa, caso contrário, use Bissecção
%%		2)	Função de qual se quer obter (um)a raiz, um argumento f(x)
%%		3)	Intervalo inicial [a,b]
%%		4)	Precisão de aproximação. Se for atingida, pare a execução
%%		5)	Número máximo de iterações
%%
%% Output:
%%		1)	raiz
%%		1)	aproximações
%%
%%=========================================================

function [raiz, hist] = bisseccPosFalsa( posfalsa, func, a, b, eps, maxiter )
	if posfalsa
		fprintf('Determinacao de raiz pelo metodo de Posicao Falsa no intervalo [%.2f,%.2f]\n',a,b);
		fprintf('Nova posição x = (a*fb - b*fa) / (fb - fa)\n');
	else
		fprintf('Determinacao de raiz pelo metodo da Bisseccao no intervalo [%.2f,%.2f]\n',a,b);
	end
	hist = {}
	xseq = []; % sequência de valores

	fprintf('Eps = %e  --- Numero maximo de iteracoes = %d\n', eps, maxiter );
	fa = func(a)
	fb = func(b)
	trocaSinal = fa * fb < 0.0;
	fprintf('Valor da funcao no limite inferior %f = %f\n', a, fa );
	fprintf('Valor da funcao no limite superior %f = %f\n', b, fb );
	if trocaSinal
		fprintf('Ha troca de sinal, entao tem raiz.\n');
	else
		fprintf('Nao ha troca de sinal, talvez tenha raiz. ');
		fprintf('Nao posso aplicar biseccao. Saindo...\n'); r = NaN;
		return;
	end

	k = 0; d = eps + 1; fx = fa; x = a;
	if ~posfalsa
		fprintf('=== Estimativa de número de iterações na bissecção === \n');
		if eps <= 0.0
			fprintf('Eps=0 ===> Somente pára, se (b_k - a_k) numericamente zero.\n');
		else
			kmin = (log2(b-a) - log2(eps)) / log2(2);
			fprintf('k > [log2(b_0 - a_0) - log2(eps)] / log2(2) = [log2(%.2f - %.2f) - log2(%.2e)] / log2(2) = %.5e <= %d\n',...
				b, a, eps, kmin, ceil(kmin));
		end
	end

	while k < maxiter && d > eps && abs(fx) > eps
		if ~posfalsa
			x = (a+b) / 2.0;			%%% BISSECÇÂO
		else
			x = (a*fb - b*fa) / (fb - fa);		%%% POSIÇÂO FALSA
		end
		fx = func(x);
		d = b-a;
		fprintf('Iter=%3d  a(%3d)=%11.7f  b(%3d)=%11.7f  dist=%11.7e  x(%3d)=%11.7f  f(a)=%11.7f  f(b)=%11.7f  f(x)=%11.7f ==> ',...
							k+1, k, a, k,b, d, k,x, fa, fb, fx );
		if fa * fx < 0.0  % Troca de sinal acontece no subintervalo esquerdo
			b = x;
			fprintf('a(%3d)=a(%3d)=%11.7f b(%3d)=x(%3d)=%11.7f\n',k+1,k,a,k+1,k,b);
			fb = fx;
		else				% fx * fb < 0.0
			a = x;
			fprintf('a(%3d)=x(%3d)=%11.7f b(%3d)=b(%3d)=%11.7f\n',k+1,k,a,k+1,k,b);
			fa = fx;
		end
		k = k + 1;
		xseq = [xseq, x];
	end
	r = x;


	fprintf('Razao(oes) de parada apos %d iteracoes:\n', k);
	if k >= maxiter , fprintf('\t\tNumero maximo de iteracoes %d atingido\n', k); end;
	if d <= eps , fprintf('\t\tDistancia %e menor ou igual que limite %e\n', d, eps); end;
	if abs(fx) <= eps, fprintf('\t\tValor absoluto da funcao %e pequeno\n', abs(fx)); end;
	if (abs(x) == Inf || abs(x) == -Inf), fprintf('\t\tDivergencia\n', x ); end;
	if fx == 0.0 , fprintf('\t\tValor zero da funcao em x=%.20e\n', x); end;
	fprintf('Raiz calculada=%.20e  --- Verificando: f(raiz)=%.20e\n', r, fx );

	raiz = r;
    hist{1} = xseq;
end


