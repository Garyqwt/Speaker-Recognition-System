function centroids = update_Centroids(codebook, x, center_idx)
% Update the codebook with the clustered data points
%
% Input:
%   codeboook - a codebook of all centroids
%   x - a matrix size of m x n containing m n-dimensional points 
%       m - number of datapoint in each dimension
%       n - number of dimensions (#MFCC filters)
%   center_idx - a 1-D array containing cloest centroid for each
%                data point
% Output:
%   centroids - an updated codebook of clustered datapoint

    K = size(codebook, 1);
    m = size(x,1);
    
    for i = 1:K
        cluster = find(center_idx == i);
        if size(cluster) ~= 0
            temp_points = x(cluster, :);
            codebook(i,:) = mean(temp_points,1); 
        end
    end
       
    centroids = codebook;

end