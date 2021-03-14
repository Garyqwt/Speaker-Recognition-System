function codebook = LBG(x, K, threshold)
% LBG Algorithm
% This function performs interatively K-mean clustering until certain 
% threshold is met.
%
% Inputs: 
%   - x contains training data vectors (one per row) 
%       - m x n matrix
%           - m is number of datapoint
%           - n is the number of dimension (#filters)
%   - K is number of centroids required 
%   - threshold is the max acceptable error
% Outputs: 
%   - codebook contains the result VQ codebook (K rows, one for each centroids) 
%       - K x n matrix
%           - K is the number of clusters
%           - n is the number of dimension (#filters)


% Take the mean of each dimension as the initial codebook
codebook = mean(x,1); 

while(size(codebook,1) < K)
    codebook = expand_Codebook(codebook);
    avg_dist = Inf;
    err = Inf;
    while(err > threshold)
        center_idx = find_NearestCentroid(x, codebook);
        codebook = update_Centroids(codebook, x, center_idx);
        D = compute_Distortion(x, center_idx, codebook);
        err = (D - avg_dist)/avg_dist;
        avg_dist = D;
    end
end

