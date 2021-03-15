function winout = hamming_window(frame,N) % N = Window Length

for j=1:1:length(frame(1,:))
winout(:,j) = frame(:,j).*hamming(N,'periodic');
end

end