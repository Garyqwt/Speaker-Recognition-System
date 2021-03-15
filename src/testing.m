function [avg_Distortion, isSpeaker] = testing(codebook, x, threshold)
% Test if the given voice belongs to given codebook
%
% Input:
%   codebook - given codebook containing K clusters
%            - K x n matrix
%            - K is the number of clusters
%            - n is the number of dimensions
%   x - given sound data of some speaker
%            - m x n matrix
%            - m is the length of data
%            - n is the number of dimensions
%   threshold - the threshold of clustering distortion to accept this sound
%               belonging to speaker
% Output:
%   avg_Distortion - the average distortion when x is clustered in this
%                    codebook
%   isSpeaker - determines if this sound track belongs to this speaker
%             - 1 is true, 0 is false
    
    % Default false
    isSpeaker = 0;
    center_idx = find_NearestCentroid(x, codebook);
    avg_Distortion = compute_Distortion(x, center_idx, codebook);
    if avg_Distortion < threshold
        isSpeaker = 1;
    end

end

