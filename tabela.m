function tabela(hist, metodo)

    %printf("Resultados para o método %s\n", metodo);
    tab = [(1:length(hist{1}))', hist{1}', [NaN, abs(diff(hist{1}))]'];
    fprintf('%12s | %10s | %10s | %15s |\n', 'Iteração', 'x(k)', 'f(x(k))', '|x(k+1) - x(k)|');
    fprintf('--------------------------------------------------------\n');
    for i = 1:size(tab,1)
        fprintf('%10d | %10.6f | %10.6f | %15.6f |\n', i, tab(i,2), f(tab(i,2)), tab(i,3));
    end

end