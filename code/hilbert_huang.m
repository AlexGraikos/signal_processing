function [imf,inst_freq,inst_amp] = hilbert_huang(sig,fs,nstd,ensemble)
% [imf,inst_freq] = hilbert_huang(sig,fs,nstd,ensemble)
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

% Extract IMFs by applying EMD/EEMD
emd_result = eemd(sig,nstd,ensemble);
imf = emd_result(:,2:end-1);
residual = emd_result(:,end);
num_imfs = size(imf,2);

% Plot IMFs and residual
figure();
sp1(1) = subplot(size(emd_result,2),1,1);
plot(sig);
title('Input Signal');
text(length(sig)/2, 7+max(ylim), ... 
    [num2str(ensemble) ' ensemble nstd=' num2str(nstd)], ... 
    'HorizontalAlignment', 'center', 'FontSize', 12);
for k=1:num_imfs
    sp1(k+1) = subplot(size(emd_result,2),1,k+1);
    plot(imf(:,k));
    title(['IMF ' num2str(k)]);
end
sp1(end+1) = subplot(size(emd_result,2),1,size(emd_result,2));
plot(residual);
title('Residual');
linkaxes(sp1, 'x');

% Get instantaneous amplitude/frequency of IMFs
inst_freq = cell(num_imfs,1);
inst_amp = cell(num_imfs,1);
for k = 1:num_imfs
    ht = hilbert(imf(:,k));
    inst_freq{k} = fs/(2*pi)*diff(unwrap(angle(ht)));
    inst_amp{k} = abs(ht(2:end)); % diff ignores first sample
end

% Plot HHT
figure();
sp2(1) = subplot(num_imfs+1,1,1);
plot(sig);
title('Input Signal');
text(length(sig)/2, 5+max(ylim), ... 
    [num2str(ensemble) ' ensemble nstd=' num2str(nstd)], ... 
    'HorizontalAlignment', 'center', 'FontSize', 12);

xval = 1:length(sig)-1;
for k=1:num_imfs
    sp2(k+1) = subplot(num_imfs+1,1,k+1);
    scatter(xval,inst_freq{k},10,inst_amp{k},'filled');
    title(['HS of IMF ' num2str(k)]);
end
linkaxes(sp2, 'x');

  
end