# Advanced signal processing project 2018.

Using ECG signals from MIT-BIH Arrhythmia Database:
* 112
* 123
* 118
* 217
* 221

Run 'load_and_plot.m' script to load signals from database.

### stft.m
```
% [sig_t,t_lab] = stft(sig,win_len,overlap,fs)
% Applies STFT on input signal.
%
%   Inputs:
% sig: Signal to transform
% fs: Sampling Frequency
% win_len: Window length
% overlap: Window overlap ratio
%
%   Outputs:
% stft: STFT of input singal
% t_lab: Time labels of STFT computation
%
% e.g. [sig_t,t_lab] = stft(sig1,fs1,200,0.5);
```

### wdf.m
```
% wd = wdf(sig,win_len,overlap,fs)
% Computes the WDF of the input signal.
%
%   Inputs:
% sig: Input signal
% fs: Sampling frequency
% win_len: Window length
% overlap: Window overlap ratio
%
%   Outputs:
% wd: WDF of input singal
%
% e.g. wd = wdf(sig1,fs1,200,0.5);
```

### wavelet_transform.m
```
% wt = wavelet_transform(sig,fs,wname,params)
% Applies WT to input signal.
%
%   Inputs:
% sig: Input signal
% fs: Sampling frequency
% wname: Wavelet to use
% params: Wavelet parameters (for morse wavelets)
%
%   Outputs:
% wt: Continuous wavelet transform
%
% e.g. wt = wavelet_transform(sig1,fs1,'morse',[2 90]);
```

#### wavelet_mra.m
```
% [c,l] = wavelet_mra(sig,n,wname)
% Decomposes input signal into multi-resolution components.
%
%   Inputs:
% sig: Input signal
% n: Decomposition level
% wname: Wavelet to use
%
%   Outputs:
% c: Decomposition coefficients
% l: Number of coefficients at each level
%
% e.g. [c,l] = wavelet_mra(sig1,5,'db2');
```

### hilbert_huang.m
```
% [imf,inst_freq] = hilbert_huang(sig,fs,nstd,ensemble)
% Applies HHT on input signal.
%
%   Inputs:
% sig: Input signal
% fs: Sampling frequency
% nstd: Additive noise standard deviation ratio
% ensemble: Number of ensemble IMFs to compute
%
%   Outputs:
% imf: Matrix containing the IMFs
% inst_freq: Cell array containing the instantaneous frequencies
% inst_amp: Cell array containing the instantaneous amplitudes
%
% e.g. [imf,inst_freq,inst_amp] = hilbert_huang(sig1,fs1,0.1,20);
```