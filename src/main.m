clear all;
close all;
clc;

cd 'D:\Study\UCD\21WQ\EEC201\Final Project\Data\Training_Data'

for j=1:1:11
    filename = 's' + string(j) + '.wav';
    [Audio,fs] = audioread(filename);
    Ts = 1/fs;
    t = (0:1:length(Audio)-1)*Ts;
    data{j}= {Audio,t',fs};
end

% plot(0:length(s5)-1, s5);

% cd 'D:\Study\UCD\21WQ\EEC201\Final Project\src'

NFB = 20;
NFFT = 256;
N = 256;
M = 100;
ov = round(2/3*N);
K = 4;
LBG_threshold = 1;

for j=1:11
    mel_cepstrum{j} = MFCC(cell2mat(data{j}(1)), ov, NFFT, NFB, fs);
end

codebook_Table = training(mel_cepstrum, K, LBG_threshold);

cd 'D:\Study\UCD\21WQ\EEC201\Final Project\Data\Test_Data'

for j=1:1:11
    filename = 's' + string(j) + '.wav';
    [Audio,fs] = audioread(filename);
    data_test{j}= {Audio,fs};
end

figure(1)
plot(0:length(cell2mat(data{1}(1)))-1, cell2mat(data{1}(1)));

for j=1:11
    mel_cepstrum_test{j} = MFCC(cell2mat(data{j}(1)), ov, NFFT, NFB, fs);
end

% [~,~] = clustering_2Dtest(mel_cepstrum_test{1}(:,1), mel_cepstrum_test{1}(:,7),mel_cepstrum_test{10}(:,1), mel_cepstrum_test{10}(:,7), K, LBG_threshold, [1 10]);

threshold = find_threshold(codebook_Table, mel_cepstrum, LBG_threshold);

% [avg_Distortion, speakerID] = testing(codebook_Table, mel_cepstrum_test{10}, threshold);
% 
[test_audio,fs] = audioread('s15.wav');
mel_cepstrum_temp = MFCC(test_audio, ov, NFFT, NFB, fs);
[distortion, speakerID] = testing(codebook_Table, mel_cepstrum_temp, threshold);
%% 
cd 'D:\Study\UCD\21WQ\EEC201\Final Project\Data\Noisy_Data\[1000 6000]'
for i=1:11
    filename = 's' + string(i) + '_noisy.wav';
    [Audio,fs] = audioread(filename);
    noisy_data{i}= {Audio,fs};
end
figure(2)
plot(0:length(cell2mat(noisy_data{1}(1)))-1, cell2mat(noisy_data{1}(1)));

for j=1:11
    mel_cepstrum_noisy{j} = MFCC(cell2mat(noisy_data{j}(1)), ov, NFFT, NFB, fs);
end

correct = 0;
for j = 1:11
    mel_cepstrum_temp = mel_cepstrum_noisy{j};
    [distortion, speakerID] = testing(codebook_Table, mel_cepstrum_temp, threshold);
    if speakerID == j
        correct = correct + 1;
    end
end

fprintf('The accuracy is %f\n', correct/11);