function codebook_Table = training(x_table, K, threshold)
% Train the input data table to get codebooks
%
% Input:
%   x_table - a table containing n speakers' data
%   K - number of clusters
%   threshold - threshold of average cluster distortion
% Output:
%   codebook_Table - a table containing n speakers' codebooks

    % get the number of speakers
    n = width(x_table);
    
    % Initialize the codebook table with speaker 1
    x = table2array(x_table(:,1));
    [codebook, ~] = LBG(x, K, threshold);
    codebook_Table = table(codebook);
    
    for i = 2:n
        x = table2array(x_table(:,i));
        [codebook, ~] = LBG(x, K, threshold);
        codebook_Table = [codebook_Table codebook];
    end
end
        
