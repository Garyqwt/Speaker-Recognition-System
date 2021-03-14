clear all;
close all;
clc;

cd 'D:\Study\UCD\21WQ\EEC201\Final Project\Data\Training_Data'

[s1, fs1] = audioread('s1.wav');
[s2, fs2] = audioread('s2.wav');
[s3, fs3] = audioread('s3.wav');
[s4, fs4] = audioread('s4.wav');
[s5, fs5] = audioread('s5.wav');
[s6, fs6] = audioread('s6.wav');
[s7, fs7] = audioread('s7.wav');
[s8, fs8] = audioread('s8.wav');
[s9, fs9] = audioread('s9.wav');
[s10, fs10] = audioread('s10.wav');
[s11, fs11] = audioread('s11.wav');

plot(0:length(s5)-1, s5);


X=[1 3; 4 2; 6 1; 7 0];
centroids = [2 1 5; 0 1 2];


%findMyHood returns the centroid memberships for every example
%
%Inputs:
%   X - [m*n] matrix containing m-samples and n-number of features
%   centroids - [K*n] matrix containing K-number of centroids
%               on a n-dimensional space (feature space)
%Outputs:
%   idx - [m*1] matrix containing each centroid membership on m-samples
%

% Set K
K = size(centroids, 1);
idx = zeros(size(X,1), 1);
distance = zeros(size(X, 1), K);

for i = 1:K
    diff = bsxfun(@minus, X, centroids(i,:));
    distance(:, i) = sum(diff.^2, 2);
end

[dummy idx] = min(distance, [], 2);
%     % Alternatively:
%     for j = 1:size(X,1)
%        [dummy idx(j)] = min(distance(j, :));
%     end

