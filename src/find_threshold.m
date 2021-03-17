function threshold = find_threshold(codebook_Table, mel_cepstrum_test, LBG_threshold)
% Find the optimal threshold from testing set
% Input:
%   codebook_Table - a codebook table containing n speakers
%            - K x n matrix
%            - K is the number of clusters
%            - n is the number of dimensions
%   mel_cepstrum - training vector for n speakers
%              - n x 1 cell array
% Output:
%   threshold - optimal threshold
    
    % get the number of speakers
    n = size(mel_cepstrum_test,2);
    
    for i = 1:n
        [avg_Distortion, speakerID] = testing(codebook_Table, mel_cepstrum_test{i}, LBG_threshold);
        temp_arr(i,1) = avg_Distortion;
        temp_arr(i,2) = speakerID;
    end
    threshold = max(temp_arr(:,1));
end

