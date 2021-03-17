function codebook_Table = training(mel_cepstrum, K, threshold)
% Train the input data table to get codebooks
%
% Input:
%   mel_cepstrum - training vector for n speakers
%              - n x 1 cell array
%   K - number of clusters
%   threshold - threshold of average cluster distortion
% Output:
%   codebook_Table - a table containing n speakers' codebooks

    % get the number of speakers
    n = size(mel_cepstrum,2);
    
    % Initialize the codebook table
    codebook_Table = table;
    
    for i = 1:n
        x = mel_cepstrum{i};
        [codebook, ~] = LBG(x, K, threshold);
        codebook_Table = addvars(codebook_Table, codebook);
    end
end
        
