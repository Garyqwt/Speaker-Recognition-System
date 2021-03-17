function [avg_Distortion, speakerID] = testing(codebook_Table, x, threshold)
% Test if the given voice belongs to given codebook
%
% Input:
%   codebook_Table - a codebook table containing n speakers
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

    % get the number of speakers
    format long;
    n = width(codebook_Table);
    speakerID = 0;
    avg_Distortion = 10000;
    distortion = zeros(1,n);
    
    for i = 1:n
        codebook = table2array(codebook_Table(:,i));
        center_idx = find_NearestCentroid(x, codebook);
        temp_Distortion = compute_Distortion(x, center_idx, codebook);
%         fprintf('temp_Distortion is %f\n', temp_Distortion);
        distortion(1,i) = temp_Distortion;
        if temp_Distortion < avg_Distortion
            avg_Distortion = temp_Distortion;
            speakerID = i;
        end
        
    end
    
    if avg_Distortion > threshold
        speakerID = 0;
    end
        
    
end

