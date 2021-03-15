function H = MELFB(NFB,NFFT,Ts)
LF = 1000;
UF = 12500;

% Converting from frequency to Mel scale
MLF = 1125*log(1 + LF/700);   % M(f) = 1125*log(1+f/700);
MUF = 1125*log(1 + UF/700);   % M(f) = 1125*log(1+f/700);

% Converting Mel Scale back to Hertz
m = linspace(MLF,MUF,NFB);
h = 700*(exp(m/1125)-1);      % M(-1)(f) = 700*(exp(m/1125)-1);

% Convert the frequncies to FFT bin Numbers
f = floor((NFFT+1).*h*Ts);

for m=1:1:length(f)
    for k=1:1:NFFT
        if( m>1 && k<f(m-1) )
            H(m,k) = 0;
        elseif( m>1 && f(m-1)<=k && k<=f(m) )
            H(m,k) = (k-f(m-1))/(f(m)-f(m-1));
        elseif( m<length(f) && f(m)<=k && k<=f(m+1) )
            H(m,k) = (f(m+1)-k)/(f(m+1)-f(m));
        elseif( m<length(f) && k>f(m+1) )
            H(m,k) = 0;
        end
    end
end
end