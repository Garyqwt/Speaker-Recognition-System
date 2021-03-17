function plot = plot_2DClustering(codebook1, codebook2, center_idx1, center_idx2, x1, x2)
% Plot the clustering in 2-dimension
%   
% Input:
%   codebook1 - k x 2 matrix containing coordinate of centroids
%               k - number of clusters
%   codebook2 - k x 2 matrix containing coordinate of centroids
%               k - number of clusters
%   center_idx1 - m1 x 1 matrix containing index of centroids it belongs to
%               m1 - number of points
%   center_idx1 - m2 x 1 matrix containing index of centroids it belongs to
%               m2 - number of points
%   x1 - m1 x 2 matrix containing coordinates of data points
%              m1 - number of points
%   x2 - m2 x 2 matrix containing coordinates of data points
%              m2 - number of points
% Output:
%   plot - shows if the input valid for plotting. 1 for valid, 0 for
%   invalid.
% 
    plot = 1;
    if (size(codebook1, 2) ~= 2) || (size(x1, 2) ~= 2) && (size(codebook2, 2) ~= 2) || (size(x2, 2) ~= 2)
        plot = 0;
    end
    
    if plot == 1
        m1 = size(center_idx1);
        m2 = size(center_idx2);
        k = size(codebook1, 1);
        figure(1)
        hold on
        
        
        for j = 1:m1
            scatter(x1(j,1), x1(j,2), 'filled', 'o', 'green');
        end
        for j = 1:m2
            scatter(x2(j,1), x2(j,2), 'filled', 'o', 'red');
        end
        
        for i = 1:k
            scatter(codebook1(i,1), codebook1(i,2), 150, 'x', 'black');
            scatter(codebook2(i,1), codebook2(i,2), 100, 'filled', '^', 'black');
        end
        
        hold off
    end

end

