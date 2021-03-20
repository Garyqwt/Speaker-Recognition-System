clear all
clc

cd 'D:\Study\UCD\21WQ\EEC201\Final Project\Data\Test_Data'
new_dir = 'D:\Study\UCD\21WQ\EEC201\Final Project\Data\Noisy_Data\[1000 6000]\';

for j=1:1:11
    filename = 's' + string(j) + '.wav';
    [Audio,Fs] = audioread(filename);
    data{j}= Audio(:,1);
end

for i=1:11
    file = data{i};
    new_audio = bandstop(file, [1000 6000], Fs);
    audiowrite(strcat(new_dir, 's', num2str(i), '_noisy.wav'), new_audio, Fs);
end
