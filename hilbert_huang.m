function hilbert_huang(sig,fs,nstd,ensemble)

% Extract IMFs by applying EMD/EEMD
imf = eemd(sig,nstd,ensemble);
num_imfs = size(imf,2)-2; % Ignore singal and residual

% Plot Signal
figure();
sp1(1) = subplot(num_imfs+2,1,1);
plot(imf(:,1));
title('Input Signal');

% Plot IMFs
for k=1:num_imfs
    sp1(k+1) = subplot(num_imfs+2,1,k+1);
    plot(imf(:,k+1));
    title(['IMF ' num2str(k)]);
end

% Plot residual
sp1(end+1) = subplot(num_imfs+2,1,num_imfs+2);
plot(imf(:,end));
title('Residual');
linkaxes(sp1, 'x');

% Get instantaneous amplitude/frequency of IMFs
inst_freq = cell(num_imfs,1);
inst_amp = cell(num_imfs,1);
for k = 1:num_imfs
    ht = hilbert(imf(:,k+1));
    inst_freq{k} = diff(unwrap(angle(ht)))/(2*pi)*fs;
    inst_amp{k} = abs(ht(1:end-1));
end

% Plot HHT
figure();
sp2(1) = subplot(num_imfs+1,1,1);
plot(sig);
title('Input Signal');

xval = 0:length(sig)-2;
for k=1:num_imfs
    sp2(k+1) = subplot(num_imfs+1,1,k+1);
    scatter(xval,inst_freq{k},10,inst_amp{k},'filled');
    title(['Instantaneous frequency of IMF ' num2str(k)]);
end
linkaxes(sp2, 'x');

  
end