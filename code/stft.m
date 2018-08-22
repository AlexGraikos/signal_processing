function [sig_t,t_lab] = stft(sig,fs,win_len,overlap,multi_plot)
% [sig_t,t_lab] = stft(sig,fs,win_len,overlap,multi_plot)
% Applies STFT on input signal.
%
%   Inputs:
% sig: Signal to transform
% fs: Sampling Frequency
% win_len: Window length
% overlap: Window overlap ratio
% multi_plot: Suppresses figure for use in multi-plots
%
%   Outputs:
% stft: STFT of input singal
% t_lab: Time labels of STFT computation
%
% e.g. [sig_t,t_lab] = stft(sig1,fs1,200,0.5);

if (nargin < 5)
    multi_plot = 0;
end

% Compute and plot STFT (hamming window)
[sig_t,w,t_lab] = spectrogram(sig, win_len, floor(win_len*overlap), [], fs);

if (multi_plot)
    imagesc([0 length(sig)], [w(1) w(end)], log10(abs(sig_t)));
    xlabel('Samples');
    ylabel('Frequency (Hz)');
    title({'Short Time Fourier Transform (Hamming window)', [' win\_len=', num2str(win_len), ... 
        ' overlap=',num2str(100*overlap),'%']});
    set(gca,'Ydir','Normal');
else
    figure();
    sp(1) = subplot(2,1,1);
    imagesc([0 length(sig)], [w(1) w(end)], log10(abs(sig_t)));
    xlabel('Samples');
    ylabel('Frequency (Hz)');
    title({'Short Time Fourier Transform (Hamming window)', [' win\_len=', num2str(win_len), ... 
        ' overlap=',num2str(100*overlap),'%']});
    set(gca,'Ydir','Normal');

    % Plot input signal
    sp(2) = subplot(2,1,2);
    plot(sig);
    title('Input Signal');
    xlabel('Samples');
    ylabel('s[n]');
    linkaxes(sp, 'x'); % Link x axes of subplots
end

end