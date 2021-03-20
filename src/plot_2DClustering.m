function plot = plot_2DClustering(codebook1, codebook2, center_idx1, center_idx2, x1, x2, speaker_Info)
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
%   speaker_Info - 1 x 2 matrix
%                - [speaker1ID speaker2ID]
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
        speaker1_str = 'speaker' + string(speaker_Info(1));
        speaker2_str = 'speaker' + string(speaker_Info(2));
        legend(speaker1_str, speaker2_str, speaker1_str, speaker2_str);
        
        scatter(x1(:,1), x1(:,2), 'filled', 'o', 'green', 'DisplayName',speaker1_str);
        scatter(x2(:,1), x2(:,2), 'filled', 'o', 'red', 'DisplayName',speaker2_str);
        
        scatter(codebook1(:,1), codebook1(:,2), 150, 'x', 'black', 'DisplayName',speaker1_str);
        scatter(codebook2(:,1), codebook2(:,2), 100, 'filled', '^', 'black', 'DisplayName',speaker2_str);

        
        hold off
    end

end

