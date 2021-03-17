function [codebook1, codebook2] = clustering_2Dtest(speaker1_d1, speaker1_d2,speaker2_d1, speaker2_d2, K, threshold)
% Plot the 2D clustering for speaker 1 and 2 in 2D
%
% Input:
%   speaker1_d1 - 1D vector of speaker1
%   speaker1_d2 - 1D vector of speaker1
%   speaker2_d1 - 1D vector of speaker2
%   speaker2_d2 - 1D vector of speaker2
%   K - number of clusters
%   threshold - threshold of average cluster distortion
% Output:
%   plotted - redundant return value

speaker1 = horzcat(speaker1_d1, speaker1_d2);
speaker2 = horzcat(speaker2_d1, speaker2_d2);

[codebook1, center_idx1] = LBG(speaker1, K, threshold);
[codebook2, center_idx2] = LBG(speaker2, K, threshold);

plotted = plot_2DClustering(codebook1, codebook2, center_idx1, center_idx2, speaker1, speaker2);


end

