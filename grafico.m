function grafico(f, result, nomeMetodo, num)
    figure(num);

    % Extrair valores das aproximações
    x_vals = result{1};
    fx_vals = arrayfun(f, x_vals);
    
    % Plot da função original
    x = linspace(min(x_vals)-1, max(x_vals)+1, 100);
    y = f(x);
    plot(x, y, 'y', 'LineWidth', 1, 'Color', '#edb01f');
    
    hold on;
    plot(x_vals, fx_vals, 'ro', 'MarkerSize', 3);
    
    % Adicionar numeração acima dos pontos
    for i = 1:length(x_vals)
        y_offset = 0.85 * i; 
        text(x_vals(i), fx_vals(i) + y_offset, sprintf('%d', i), 'Color', 'b', 'FontSize', 8, 'HorizontalAlignment', 'center');
    end

    xlabel('x');
    ylabel('f(x)');
    title(['Aproximações sobre f(x) - ', nomeMetodo]);
    grid on;
    hold off;

    % Criar pasta para salvar gráficos
    pastaTabelas = 'graficos';
    if ~exist(pastaTabelas, 'dir')
        mkdir(pastaTabelas);
    end
    saveas(figure(num), fullfile(pastaTabelas, sprintf('grafico%s.png', nomeMetodo)));

    % Gráfico de barras do erro logarítmico
    figure(num + 10);

    k = 1:length(x_vals);  % Iterações
    err_log = abs(fx_vals); % Erro absoluto (evita log de número negativo)

    % Plot de barras
    bar(k, err_log, 'b'); 
    set(gca, 'YScale', 'log');  % Escala log no eixo Y
    
    xlabel('k');
    ylabel('ln(|f(x^{(k)})|)');
    title(['Convergência Logarítmica - ', nomeMetodo]);
    legend('ln(|f(x^{(k)})|)', 'Location', 'northeast');
    
    % Adicionar rótulos de valores sobre as barras
    for i = 1:length(k)
        text(k(i), err_log(i), sprintf('%.2e', err_log(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'Color', 'k');
    end

    grid on;

    % Salvar gráfico de barras
    saveas(figure(num + 10), fullfile(pastaTabelas, sprintf('graficoBarras%s.png', nomeMetodo))); 
end
