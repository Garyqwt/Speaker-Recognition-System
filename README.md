# Speaker-Recognition-System
**EEC201 Final Project**

**Team Members: Weitai Qian, Ata Vafi**

## Abstract

## Introduction

## Methods
First, since the audio amplitude does not contain any unique information for users, the amplitude is normalized to be [-1,1] range. Next, the main part of the signal is clipped and the short time discrete Fourier transform is performed on the clipped signal. In stft, the speech signal is blocked into frames of N samples with overlap: The first frame consists of the first N samples. The second frame begins M samples after the first frame, and overlaps it by N - M samples, etc. N and M are N = 256 (which is equivalent to ~ 30 msec windowing) and M = N/3.The output of STFT is the spectrum which has a hermitian symmetry property because the audio signal is real. As a result, the half length of the spectrum is selected since the second half is simply redundant. 

### Computing the Mel filterbank
In this section we used 10 filterbanks. To get the filterbanks shown in figure 1(a) we first have to choose a lower and upper frequency. Which is for our case, 1000Hz for the lower and 1250Hz for the upper frequency. Then follow these steps:
1)	Using equation 1, convert the upper and lower frequencies to Mels. 

Since we used 40 filterbanks, for which we need 42 points. This means we need 40 additional points spaced linearly between 1000 and 1250. Now use equation 2 to convert these back to Hertz:
1)	M(f) = 1125ln(1 + f/700);

![alt text](https://github.com/Garyqwt/Speaker-Recognition-System/blob/ec48416b8d99bec86f16d6bdb98e3883bb3318d5/image/MFCC_40.png?raw=true)

Finally, we multiplied the mel filter to the input spectrum and got the Mel spectrum. After that in the cepstrum we take the log of data and perform discrete Fourier transform on the data. Cepstrum converts log mel spectrum back to time. The result is called the mel frequency cepstrum coefficients (MFCC). The cepstral representation of the speech spectrum provides a good representation of the local spectral properties of the signal for the given frame analysis. Because the mel spectrum coefficients (and so their logarithm) are real numbers, they can be converted to the time domain using the Discrete Cosine Transform (DCT).
