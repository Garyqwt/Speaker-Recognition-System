function winout = hamming_window(frame,NFFT) % N = Window Length
    for j=1:1:length(frame(1,:))
    winout(:,j) = frame(:,j).*hamming(NFFT,'periodic');
    end
end