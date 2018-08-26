function detect_rr_intervals(record_number,lead,n0,n1)


[sig,fs,tm,ann,anntype] = load_signal(record_number,lead);
sig_prefix = ['report/fig/' num2str(record_number) 'l' num2str(lead)];
close gcf;

if (nargin < 3)
    n0 = 1;
    n1 = length(sig);
    save_plot = 0;
else
    save_plot = 1;
end

tic;
n = 10;
wname = 'db6'; % Wavelet to use
[c,l] = wavedec(sig,n,wname);

% Only use beat annotations
ind = anntype == ['N','L','R','B','/','f'];
ind = logical(sum(ind,2));
peak_true = ann(ind);

% Reconstruct signal only with chosen detail levels
chosen_dlevels = [2 3 4 5];

c(1:l(1)) = 0; % Zero approx coeffs
for i=1:n
    dlevel = n-i+1;
    if (~any(dlevel == chosen_dlevels))
        c(sum(l(1:i))+1:sum(l(1:i+1))) = 0; % Nullify coeffs
    end
end
rrsig = waverec(c,l,wname); % Reconstruct signal

% Find mean R-R peak distance
[wt,freq] = cwt(sig(end/2-15000:end/2+1),'amor'); % Calculate mean distance between peaks using CWT
freq_peaks = sum(abs(wt(25:35,:))); % Peaks in QRS frequencies
auto_coeffs = autocorr(freq_peaks,500); % Autocorr finds mean distance
[m,i] = max(auto_coeffs(150:end));
min_peak_dist = (i+149)*0.8; % 80% of interval is used as min peak distance

% Locate peaks in square of reconstructed signal
[peaks,peak_locs] = findpeaks(rrsig.^2,'MinPeakDistance',min_peak_dist,'MinPeakHeight',5*mean(rrsig.^2));
toc;

% Plot results
figure();
plot(sig);
hold on;
stem(peak_locs,sig(peak_locs),'x','LineStyle','none');
hold on;
stem(peak_true,sig(peak_true),'LineStyle','none','Color','g');
hold off;
title(['Signal ' num2str(record_number) ' (lead ' num2str(lead) ') detected/true R peaks']);
xlabel('Samples');
legend({'Signal','Detected','True'});
xlim([n0 n1]);
ylim([min(sig) max(sig)])
if (save_plot)
    print([sig_prefix '_detected_peaks'],'-dpdf','-bestfit');
end

% Distance matrix
m1 = length(peak_true);
m2 = length(peak_locs);
distMat = abs(repmat(peak_true,1,m2) - repmat(peak_locs',m1,1));

% Calculate accuracy of algorithm
radius = 20; % Samples
TP = sum(sum(distMat < radius));
FN = sum(sum(distMat < radius,2) == 0);
FP = sum(sum(distMat < radius) == 0);

fprintf('TP: %d, FN: %d, FP: %d\n', TP, FN, FP);
fprintf('Accuracy: %f %% \n', 100*TP/(TP+FN+FP));


end
