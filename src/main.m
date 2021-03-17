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

for j=1:11
    mel_cepstrum_test{j} = MFCC(cell2mat(data{j}(1)), ov, NFFT, NFB, fs);
end

threshold = find_threshold(codebook_Table, mel_cepstrum_test, LBG_threshold);

[avg_Distortion, speakerID] = testing(codebook_Table, mel_cepstrum_test{10}, threshold);

[test_audio,fs] = audioread('s12.wav');
mel_cepstrum_temp = MFCC(test_audio, ov, NFFT, NFB, fs);
[distortion, speakerID] = testing(codebook_Table, mel_cepstrum_temp, threshold);

