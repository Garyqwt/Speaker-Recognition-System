function  Mel_Spectrum_out = Mel_Spectrum(H,Mag_Sxk)
A = zeros(128,1);
for j=1:1:length(Mag_Sxk(1,:))
    for m = 1:1:length(H(:,1))
            A = Mag_Sxk(:,j).*H(m,:)' + A;    
    end
        Mel_Spectrum_out(j,:) = A;
end
end