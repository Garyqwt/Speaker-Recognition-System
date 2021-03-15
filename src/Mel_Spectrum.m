function  Mel_Spectrum_out = Mel_Spectrum(H,Mag_Sxk{1})

for j=1:1:length(Mag_Sxk{1}(1,:))
    for m = 1:1:length(H(:,1))
            A = sum(Mag_Sxk{1}(:,j).*H(m,:)');
    end
        Mel_Spectrum_out(j,:) = A;
end
end
