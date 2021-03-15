function Mel_Cepstrum = MFCC(data,N,M,NFFT,NFB,Ts)
% N = 256;         % Frame Length
% M = 100;         % Frame overlap
frame = Frame_Blocking(data,N,M);                    % Frame Blocking
xn = hamming_window(frame,N);                        % Hamming Window     
Sxk = fft(xn);
Sxk = Sxk(1:end/2,:);
Mag_Sxk = abs(Sxk).^2;                               % PSD 
H = MELFB(NFB,NFFT/2,Ts);                            % MELFB
Mel_Spectrum_out = Mel_Spectrum( H, Mag_Sxk );
Mel_cepstrum = dct(log(Mel_Spectrum_out));
end