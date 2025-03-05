function tabela(f, hist, nomeMetodo)
    xseq = hist{1}; 
    
    % Calcular os valores da função e as distâncias
    fx_vals = arrayfun(f, xseq);
    distancias = [NaN; diff(xseq(:))]; 
    
    disp(nomeMetodo)

    % Exibir o cabeçalho da tabela
    fprintf('%12s | %12s | %12s |\n', 'x_k', 'f(x_k)', 'x_k+1 - x_k');
    fprintf('-------------------------------------------------\n');
    % Exibir os valores da tabela
    for k = 1:length(xseq)
        if k == 1
            fprintf('%12.6f | %12.6f | %12s |\n', xseq(k), fx_vals(k), 'NaN');
        else
            fprintf('%12.6f | %12.6f | %12.6f |\n', xseq(k), fx_vals(k), distancias(k));
        end
    end
    fprintf('-------------------------------------------------\n');
    
    % Salvar a tabela em um arquivo .txt
    pastaTabelas = 'tabelas';
    if ~exist(pastaTabelas, 'dir')
        mkdir(pastaTabelas);
    end
    
    fileID = fopen(fullfile(pastaTabelas, sprintf('tabela%s.txt', nomeMetodo)), 'w');
    fprintf(fileID, '%12s | %12s | %12s |\n', 'x_k', 'f(x_k)', 'x_k+1 - x_k');
    fprintf(fileID, '-------------------------------------------------\n');
    
    for k = 1:length(xseq)
        if k == 1
            fprintf(fileID, '%12.6f | %12.6f | %12s |\n', xseq(k), fx_vals(k), 'NaN');
        else
            fprintf(fileID, '%12.6f | %12.6f | %12.6f |\n', xseq(k), fx_vals(k), distancias(k));
        end
    end
    fprintf(fileID, '-------------------------------------------------\n');
    fclose(fileID);
end