function D = compute_Distortion(X, center_idx, centroids)
% Compute the average distortion of each cluster
%
% Input:
%   X - a matrix size of m x n containing m n-dimensional points 
%   center_idx - size m 1D array: index of cloest centroid for each data point
%   centroids - a K x n matix containing K centroids
% Output:
%   D - Average distortion of all clusters
%
    K = size(centroids, 1);
    m = size(X,1);
    D = 0;
    
    for i = 1:m
        cluster = centroids(center_idx(i),:);
        err = (X(i,:) - cluster).^2;
        distance = sum(err);
        D = D + distance;
    end
    D = D / K;
end
            