function grafico(f, result, nomeMetodo, num)
    figure(num);

    % Extrair valores das aproximações
    x_vals = result{1};
    fx_vals = arrayfun(f, x_vals);
    
    x = linspace(min(x_vals)-1, max(x_vals)+1, 100);
    y = f(x);
    plot(x, y, 'b', 'LineWidth', 2);
    hold on;
    plot(x_vals, fx_vals, 'ro-', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
    
    % Adicionar numeração acima dos pontos
    for i = 1:length(x_vals)
        y_offset = 0.3 + 1*i; 
        text(x_vals(i), fx_vals(i) + y_offset, sprintf('%d', i), 'Color', 'b', 'FontSize', 12, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    end

    xlabel('x');
    ylabel('f(x)');
    title(['Aproximações sobre f(x) - ', nomeMetodo]);
    grid on;

    % Salva os gráficos na pasta "graficos"
    pastaTabelas = 'graficos';
    if ~exist(pastaTabelas, 'dir')
        mkdir(pastaTabelas);
    end

    saveas(figure(num), fullfile(pastaTabelas, sprintf('grafico%s.png', nomeMetodo))); 
end
