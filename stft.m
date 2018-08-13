function [stft,t_lab] = stft(sig,win_len,overlap,fs)
% [stft,t_lab] = stft(sig,win_len,overlap,fs)
%   Inputs:
% sig: Signal to transform
% win_len: Window length
% overlap: Window overlap ratio
% fs: Sampling Frequency
%   Outputs:
% stft: STFT of input singal
% t_lab: Time labels of STFT computation

figure();
% Compute and plot STFT (hamming window) with given parameters
sp(1) = subplot(2,1,1);
spectrogram(sig, win_len, floor(win_len*overlap), [], fs, 'yaxis');
title(['STFT win\_len=',num2str(win_len), ... 
    ' overlap=',num2str(100*overlap),'%']);

% Plot input signal
sp(2) = subplot(2,1,2);
ts = (0:(length(sig)-1))*1/fs./60;
plot(ts,sig);
xlim([0 ts(end)]);
title('Signal');
linkaxes(sp, 'x'); % Link x axes of subplots

% Return spectogram values and time labels
[stft,w,t_lab] = spectrogram(sig, win_len, floor(win_len*overlap), [], fs);
end