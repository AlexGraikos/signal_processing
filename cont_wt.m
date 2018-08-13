function wt = cont_wt(sig,fs,wname,params)
% wt = cont_wt(sig,fs,wname,params)
%
%   Inputs:
% sig: Input signal
% fs: Sampling frequency
% wname: Wavelet to use
% params: Wavelet parameters (for morse wavelets)
%   Outputs:
% wt: Continuous wavelet transform

% Calculate CWT
N = length(sig);
if (strcmp(wname,'morse'))
    [wt,freq] = cwt(sig,wname,fs,'WaveletParameters',params);
else
    [wt,freq] = cwt(sig,wname,fs);
end

% Plot CWT
figure();
sp(1) = subplot(2,1,1);
imagesc([0 N],[freq(1) freq(end)], abs(wt));
title('Continuous Wavelet Transform');
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