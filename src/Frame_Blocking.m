function Frame = Frame_Blocking( data, N, M ) % N = Frame Length % Frame overlap
    Frame(:,1) = data(1:1:N,1);                   
    for j = 2:1:floor((length(data)+M-N)/(N-1))
        A = j*N-M-(j-1);
        B = (j+1)*N-M-j;

        Frame(:,j) = data(A:1:B,1);
    %     xn(:,j) = frame(:,j).*hamming(N,'periodic');
    %     
    %     Sxk(:,j) = fft(xn(:,j));
    %     Mag_Sxk(:,j) = abs(Sxk(:,j)).^2;   % PSD 

    %     Rx1n{i}{j} = autocorr(xn{i}{j});
    %     Sxk{i}{j} = fftshift(fft(Rx1n{i}{j}));
    end
end
