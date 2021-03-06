# Speaker-Recognition-System
**EEC201 Final Project**

**Team Members: Weitai Qian, Ata Vafi**

## Abstract
This project builds a speaker recognition system relying on small number of samples. It mainly has 3-stages pipeline: (1) feature extraction (2) feature learning (3) speaker identification. In the feature extraction stage, Short-Time Fourier Transform (STFT) is used with hamming window size of 256. 20 filters are then used for MFCC to generate 20-dimension training vectors. After feature extraction, vector quantization and k-means clustering are used to learn these features. The system achieves 100% accuracy on training set and 100% accuracy on testing set before notch filters are used to generate more noisy dataset. After the notch filters are applied to the test signals, the accuracy decreases as the range of stopband becomes larger.

## Introduction
![alt text](https://github.com/Garyqwt/Speaker-Recognition-System/blob/0908619db721db564444893b9eab3428cad87615/image/pipeline.PNG?raw=true)
### Feature Extraction
Feature extraction stage takes n speakers’ sample reading ‘zero’ as the input. For each piece of sound, the signal is framed in short period of time. The features in short period remain relatively stable than long-time signal. Then STFT is used to extract features with hamming window size of 256. After STFT, we have spectrum of each speech. Then we use MFCC filter bank to generate the Cepstrum from DCT.
### Feature Learning
Feature learning stage takes the results of cepstrum as training vector of each speaker’s codebook. For each speaker, a unique codebook is generated by taking training vector into LBG algorithm. LBG algorithm is an iterative k-means clustering algorithm which cluster data points in k groups. After feature learning, each speaker has a corresponding feature codebook which will be later used to train and test.
### Speaker Identification
Speaker identification stage is a training and testing phase. A codebook table containing n codebook from different speakers generated from training dataset is used as reference model. The second voice record from the same speaker is used as the input of the testing phase. This new signal is also preprocessed through MFCC to generate a testing vector. This testing vector is then used to find the most similar voice from the codebook table. The codebook which has smallest distortion for the testing vector will be identified as certain speaker if the distortion is smaller than a certain threshold. Several optimization methods on parameters (such as number of clusters, optimal threshold exploration and size of hamming window) are performed in this section as well.


## Methods
First, since the audio amplitude does not contain any unique information for users, the amplitude is normalized to be [-1,1] range. Next, the main part of the signal is clipped and the short time discrete Fourier transform is performed on the clipped signal. In stft, the speech signal is blocked into frames of N samples with overlap: The first frame consists of the first N samples. The second frame begins M samples after the first frame, and overlaps it by N - M samples, etc. N and M are N = 256 (which is equivalent to ~ 30 msec windowing) and M = N/3.The output of STFT is the spectrum which has a hermitian symmetry property because the audio signal is real. As a result, the half length of the spectrum is selected since the second half is simply redundant. 

### 1. Feature Extraction
#### Short-Time Fourier Transform
The short-time Fourier transform (STFT) is used to analyze how the frequency content of a nonstationary signal changes over time. The STFT of a signal is calculated by sliding an analysis window of length M over the signal and calculating the discrete Fourier transform of the windowed data. The window hops over the original signal at intervals of R samples. Most window functions taper off at the edges to avoid spectral ringing. If a nonzero overlap length L is specified, overlap-adding the windowed segments compensates for the signal attenuation at the window edges. The DFT of each windowed segment is added to a matrix that contains the magnitude and phase for each point in time and frequency. The number of rows in the STFT matrix equals the number of DFT points, and the number of columns is given by
<img src="https://render.githubusercontent.com/render/math?math=k = \frac{Nx-L}{M-L}">
where Nx is the length of the original signal x(n) and the ⌊⌋ symbols denote the floor function.
The STFT matrix is given by X(f) = [X1(f) X2(f) X3(f) ⋯ Xk(f)] such that the mth element of this matrix is

<p align="center">
  <img src="https://render.githubusercontent.com/render/math?math=Xm(f) = \sum_{n=-infty}^{\infty} x(n)g(n-mR)e^{-i 2\pi\fn}">
</p>

where
* g(n) — Window function of length M
* Xm(f) — DFT of windowed data centered about time mR
* R — Hop size between successive DFTs. The hop size is the difference between the window length Mand the overlap length L

In stft, the speech signal is blocked into frames of N samples with overlap: The first frame consists of the first N samples. The second frame begins M samples after the first frame, and overlaps it by N - M samples, etc. N and M are N = 256 (which is equivalent to ~ 30 msec windowing) and M = N/3. The output of STFT is the spectrum which has a hermitian symmetry property because the audio signal is real. As a result, the half-length of the spectrum is selected since the second half is simply redundant.

<p align="center">
  <img width="460" height="300" src="https://github.com/Garyqwt/Speaker-Recognition-System/blob/56d07669c46644a9d2ce0c1065118074dbcb54f5/image/STFT_2.png">
</p>


#### Computing the Mel filter bank
To get the filter banks we first chose a lower and upper frequency. The lower frequency is 1kHz and upper frequency is 6.25 kHz. Then follow these steps:
* Using M(f) = 1125ln(1+f/700), the upper and lower frequencies are converted to Mels. In our case 1 kHz is 998.2 Mels and 6.25 kHz is 2582.34 Mels.
* Since 40 filter banks are used in this project, we need total points of 42. This means we need 40 additional points spaced linearly between 998.2 and 2582.34. This comes out to:
m(i) = 998.2, 1036.83, 1075.47, …, 2543.702, 2582.34
* Now we used M-1(f) = 700(exp(m/1125)-1) to convert these back to Hertz:
h(i) =999.97, 1059.37, 1120.84, …, 6015.33, 6249.97
* Since the frequency resolution required to put filters at the exact points calculated above is not available, so we need to round those frequencies to the nearest FFT bin. This process does not affect the accuracy of the features. To convert the frequencies to fft bin numbers we need to know the FFT size and the sample rate,
f(i) = floor((nfft+1)×h(i)×Ts)
This results in the following sequence:
f(i) = 20, 21, 23, … , 123, 128
* We can see that the final filter bank finishes at bin 128, which corresponds to 6.25 kHz with a 128-point FFT size.
Now we create our filter banks. The first filter bank will start at the first point, reach its peak at the second point, then return to zero at the 3rd point. The second filter bank will start at the 2nd point, reach its max at the 3rd, then be zero at the 4th etc.

<p align="center">
  <img src="https://github.com/Garyqwt/Speaker-Recognition-System/blob/9dbdc42ad8f93591def9d59c2f0ce7c20fe595e7/image/Mel2.jpg">
</p>

Finally, we multiplied the mel filter to the input spectrum and got the Mel spectrum. After that in the cepstrum we take the log of data and perform discrete Fourier transform on the data. Cepstrum converts log mel spectrum back to time. The result is called the mel frequency cepstrum coefficients (MFCC). The cepstral representation of the speech spectrum provides a good representation of the local spectral properties of the signal for the given frame analysis. Because the mel spectrum coefficients (and so their logarithm) are real numbers, they can be converted to the time domain using the Discrete Cosine Transform (DCT).

### 2. Vector Quantization
#### K-means Clustering
K-means clustering is a common technique in unsupervised learning. Its goal is to minimize the squared error function based on Euclidean distances. The k-means clustering has cost function:

<p align="center">
    <img src="https://render.githubusercontent.com/render/math?math=J(V) = \sum_{i=1}^{c} \sum_{j=1}^{ci} {(|xi-vj|)}^2">
 </p>

where 
* |xi-vj| is the Euclidean distance between xi and vj
* 'ci' is the number of data points in ith cluster
* 'c' is the number of cluster centers

In our case, we have a 20-dimensions vector from MFCC filter banks, so the cost function is computed based on 20-dimension Euclidean distance. The k-means clustering algorithm finds the best cluster center for each data point based on the number of clusters.

#### LBG Algorithm
LBG algorithm is an iterative algorithm based on k-means clustering. For each speaker, 
![alt text](https://github.com/Garyqwt/Speaker-Recognition-System/blob/fef532c2591c2df31a2581142b7962c372ea2eda/image/LBG.png?raw=true)

(1)	Initialize a centroid which locates at mean of every dimension.

(2)	Split each centroid to two (double the number of clusters) by using yn+ = yn(1+𝜖) and yn- = yn(1-𝜖).

(3)	Cluster the training vectors with given cluster centers.

(4)	Update the centroids so that, in each cluster, every vectors have the same distortion.

(5)	Compute the average distortion in this codebook.

(6)	If average distortion is acceptable and number of clusters exceeds requirement, output this codebook.

(7)	If average distortion is not acceptable, repeat (3)(4)(5).

(8)	If average distortion is acceptable but the number of clusters doesn’t meet requirement, repeat (2)(3)(4)(5).

### 3. Speaker Identification
Several sound tracks are used for training to generate a codebook containing n speakers' sound features. Then a single voice file is used as testing set and find the distortions in different codewords. The codeword with smallest distortion is most likely corresponding to this testing voice only if the distortion is below certain threshold. This threshold is dynamically explored, since many factors like the number of clusters and size of hamming window impact the threshold of speaker identification. So, we choose 2 * max_distortion as the threshold to accept the testing sample. In this case, our system can reject some voice samples which are not in the training set.

## Results
### 1. Feature Extraction
#### STFT
<p align="center">
  <img src="https://github.com/Garyqwt/Speaker-Recognition-System/blob/81f115102390512a8597ac6e6be0ded0830cf8db/image/STFT.jpg">
</p>


#### Cepstrums
<p align="center">
    <img src="/image/Cepstrum1.jpg"/>
    <img src="/image/Cepstrum2.jpg"/>
</p>

### 2. Vector Quantization
Test 5: Check any two dimensions clustering in a 2D plane
Test 6: Plot VQ codewords in two dimensions in a 2D plane
<p align="center">
    <img src="/image/clustering_single.png" width = "383" height = "315" alt = "single clustering" />
    <img src="/image/cluster_sample.png" width = "383" height = "315" alt = "VQ example" />
</p>

### 3. Speaker Identification
The optimal number of clusters is the first parameter we decided to determine, and we want it to make the average distortion per cluster is in a reasonable range and also has good resolution to distinguish among speakers. So we test number of clusters = [2 4 8 16 32] and get average distortion per cluster for each test. Then we find the elbow point in this plot and determine it is the optimal number of clusters in our case.

<p align="center">
  <img src="https://github.com/Garyqwt/Speaker-Recognition-System/blob/c9d4116d64e84eb8d511a197e71619d25687f9c8/image/Distortion_vs_Clusters.png">
</p>

The elbow point is when number of clusters is 4 and we use 4 clusters for all other tests. When the number of clusters is 4, we have max distortion in the codebook equal to 1.0932. Then we determine the threshold to accpet the test case belonging to this codebook to 1.0932 * 2 = 2.1864. After determining the threshold, we run several tests on this system:

#### Testing with original testing set
This test use a trained codebook composed of 11 original training speakers' voice and 14 test cases including 11 original test cases and 3 cases from our friends.In this test, our accuracy is 100% and it could reject voices which have not seen before. In the figure below, the red dash line is the threshold to accept the voice. So, untrained voices (s12, s13 and s14) are rejected because of high distortion.

<p align="center">
  <img src="https://github.com/Garyqwt/Speaker-Recognition-System/blob/c9d4116d64e84eb8d511a197e71619d25687f9c8/image/Distortion_of_Testset.png">
</p>

#### Testing with noisy testing set
In this test, we generate noisy test set with notch filter. We tried different range of stopband, and the accuracy of system decreases with wider stopband. It meets our assumption because more information is lost as the stopband becomes wider. The sampling frequency of our signal is 12.5kHz, so we test five different stopbands: [1k 2k], [1k 3k], [1k 4k], [1k 5k], [1k 6k]. The accuracy remains 100% when we have a narrow stopband from 1kHz to 2kHz, then the performance decreases a lot. For the last test [1k 6k], it only successfully identifies 1/11 speakers, then we decide to stop here.

<p align="center">
  <img src="https://github.com/Garyqwt/Speaker-Recognition-System/blob/a5170ffaee3325336cd8fc6b0a5de4577b702c0c/image/Acc_vs_filter.png">
</p>

## Future Work
This system has good performance using origianl training and testing sets. It can achieve higher accuracy than human ear when the noise is not introduced. However, when the notch filters are applied to testing files, it fails to identify many voice files which can be distinguished by human ears. This system can also be improved with larger dataset. For the optimal threshold finding, more analytic way could be proposed rather than using empirical oberservation.

## Appendix
* This project is done as the final project of EEC201 in UC Davis.
* We appreciate helps from Dr. Z.Ding and TA Songyang Zhang.
* We acknowledge many related papers which provided basic concepts in feature extraction and vector quantization.
