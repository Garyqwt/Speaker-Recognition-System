# Speaker-Recognition-System
**EEC201 Final Project**

**Team Members: Weitai Qian, Ata Vafi**

## Abstract
This project builds a speaker recognition system relying on small number of samples. It mainly has 3-stages pipeline: (1) feature extraction (2) feature learning (3) speaker identification. In the feature extraction stage, Short-Time Fourier Transform (STFT) is used with hamming window size of 256. 20 filters are then used for MFCC to generate 20-dimension training vectors. After feature extraction, vector quantization and k-means clustering are used to learn these features. The system achieves 100% accuracy on training set and 100% accuracy on testing set before notch filters are used to generate more noisy dataset.

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

### 1. Computing the Mel filterbank
In this section we used 10 filterbanks. To get the filterbanks shown in figure 1(a) we first have to choose a lower and upper frequency. Which is for our case, 1000Hz for the lower and 1250Hz for the upper frequency. Then follow these steps:
1)	Using equation 1, convert the upper and lower frequencies to Mels. 

Since we used 40 filterbanks, for which we need 42 points. This means we need 40 additional points spaced linearly between 1000 and 1250. Now use equation 2 to convert these back to Hertz:
1)	M(f) = 1125ln(1 + f/700);

![alt text](https://github.com/Garyqwt/Speaker-Recognition-System/blob/ec48416b8d99bec86f16d6bdb98e3883bb3318d5/image/MFCC_40.png?raw=true)

Finally, we multiplied the mel filter to the input spectrum and got the Mel spectrum. After that in the cepstrum we take the log of data and perform discrete Fourier transform on the data. Cepstrum converts log mel spectrum back to time. The result is called the mel frequency cepstrum coefficients (MFCC). The cepstral representation of the speech spectrum provides a good representation of the local spectral properties of the signal for the given frame analysis. Because the mel spectrum coefficients (and so their logarithm) are real numbers, they can be converted to the time domain using the Discrete Cosine Transform (DCT).

### 2. Vector Quantization
K-means clustering is a common technique in unsupervised learning, and LBG algorithm is an iterative algorithm based on k-means clustering. For each speaker, 
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
Several sound tracks are used for training to generate a codebook containing n speakers' sound features. Then a single voice file is used as testing set and find the distortions in different codewords. The codeword with smallest distortion is most likely corresponding to this testing voice only if the distortion is below certain threshold. This threshold is dynamically explored, since many factors like the number of clusters and size of hamming window impact the threshold of speaker identification. So, the corresponding test voices of training set are used to find the optimal threshold range. In this case, our system can reject some voice samples which are not in the training set.

## Results
### 1. Feature Extraction

### 2. Vector Quantization
Test 5: Check any two dimensions clustering in a 2D plane
Test 6: Plot VQ codewords in two dimensions in a 2D plane
<p align="center">
    <img src="/image/clustering_single.png" width = "383" height = "315" alt = "single clustering" />
    <img src="/image/cluster_sample.png" width = "383" height = "315" alt = "VQ example" />
</p>
