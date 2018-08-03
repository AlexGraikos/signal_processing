function [stft,t_lab] = stft(sig,win_len,overlap,fs)
% Returns STFT of input signal
% e.g. stft(sig,50,0.5,fs);

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