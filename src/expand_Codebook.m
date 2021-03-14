function expanded_codebook = expand_Codebook(codebook)
% Double the size of codebook by 2
%
% Input:
%   codebook - a matrix size of k x n containing k n-dimensional points 
%              k - number of clusters
%              n - number of dimensions (#MFCC filters)
% Output:
%   expanded_codebook - a 2k x n matrix containing n-dimensional
%                       coordinates of 2k centroids
%
    
    e = 0.01;
    temp_codebook = codebook + codebook.*e; 
    codebook = codebook - codebook.*e;
    expanded_codebook = vertcat(temp_codebook, codebook);
end