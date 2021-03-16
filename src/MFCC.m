function [Mel_Cepstrum,t] = MFCC(data,ov,NFFT,NFB,fs)
% N = 256;         % Frame Length
% M = 100;         % Frame overlap
% frame = Frame_Blocking(data,ov,M);                   % Frame Blocking
% xn = hamming_window(frame,NFFT);                     % Hamming Window
[Sxk,~,t] = stft(data,fs,'Window',hamming(NFFT),'OverlapLength',ov,'FFTLength',NFFT);
% Sxk = fft(xn); % STFT()
Sxk = Sxk(1:end/2+1,:);
Mag_Sxk = abs(Sxk).^2;                               % PSD 
H = melfb(NFB,NFFT,fs);                            % MELFB
Mel_Spectrum_out = H*Mag_Sxk;
% Mel_Spectrum_out = Mel_Spectrum( H, Mag_Sxk );
Mel_Cepstrum = dct(log10(Mel_Spectrum_out));
Mel_Cepstrum = Mel_Cepstrum./max(max(abs(Mel_Cepstrum)));
end