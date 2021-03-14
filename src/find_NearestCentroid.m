function center_idx = find_NearestCentroid(X, centroids)
% Find the cloest centroid idx for each data point.
%
% Input:
%   X - a matrix size of m x n containing m n-dimensional points 
%       m - number of datapoint in each dimension
%       n - number of dimensions (#MFCC filters)
%   centroids - a K x n matix containing K centroids
% Output:
%   center_idx - a 1-D array containing cloest centroid for each
%                data point
%
    % get the number of centroids
    K = size(centroids, 1);
    m = size(X,1);
    center_idx = zeros(size(X,1), 1);
 
    for i = 1:m
        shortest_dist = 1e10;
        shortest_idx = 0;
        for j = 1:K
            dist = norm(X(i,:)-centroids(j,:));
            if dist < shortest_dist
                shortest_dist = dist;
                shortest_idx = j;
            end
        end
        center_idx(i) = shortest_idx;
    end
end