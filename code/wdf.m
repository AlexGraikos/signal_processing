function wd = wdf(sig,fs,win_len,overlap)
% wd = wdf(sig,win_len,overlap,fs)
%
%   Inputs:
% sig: Input signal
% fs: Sampling frequency
% win_len: Window length
% overlap: Window overlap ratio
%
%   Outputs:
% wd: WDF of input singal

% Compute WDF over overlapping windows
N = length(sig);
wd = zeros(win_len,N);
slide = win_len*(1-overlap);
for k = 1:slide:N-win_len+1
    windowed_sig = sig(k:k+win_len-1);
    window = hann(win_len);
    W = mywigner(windowed_sig, window);
    wd(:,k:k+win_len-1) = wd(:,k:k+win_len-1) + transp(W);
end
nfft = size(W,2);
freq = (-nfft/2+1:nfft/2) / nfft * fs;

% Plot distribution
figure();
sp(1) = subplot(2,1,1);
imagesc([0 N], [freq(1) freq(end)], wd);
title(['Wigner Distribution win\_len=' num2str(win_len) ' overlap ' ...
    num2str(overlap*100) '%']);
xlabel('Samples');
ylabel('Frequency');
set(gca,'Ydir','Normal');

% Plot signal
sp(2) = subplot(2,1,2);
plot(sig);
title('Input signal');
xlabel('Samples');
ylabel('s[n]');
linkaxes(sp, 'x'); % Link x axes of subplots

end