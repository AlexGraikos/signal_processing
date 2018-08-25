function detect_rr_intervals(record_number,lead,n0,n1)

[sig,fs,tm,ann,anntype] = load_signal(record_number,lead);
close gcf;

n = 10;
wname = 'db6'; % Wavelet to use
[c,l] = wavedec(sig,n,wname);

% Only use beat annotations
ind = anntype == ['N','L','R','B','A','a','J','S','V','r','F','e','j','n','E','/','f','Q','?'];
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
wt = cwt(sig(end/2-10000:end/2+1),'amor'); % Calculate mean distance between peaks using CWT
freq_peaks = sum(abs(wt(25:35,:))); % Peaks in QRS frequencies
auto_coeffs = autocorr(freq_peaks,500); % Autocorr finds mean distance
[m,i] = max(auto_coeffs(150:end));
min_peak_dist = (i+149)*0.8; % 80% of interval is used as min peak distance

% Locate peaks in square of reconstructed signal
[peaks,peak_locs] = findpeaks(rrsig.^2,'MinPeakDistance',min_peak_dist,'MinPeakHeight',5*mean(rrsig.^2));

% Plot results
figure();
sp2(1) = subplot(2,1,1);
plot(sig);
hold on;
stem(peak_locs,sig(peak_locs),'x','LineStyle','none');
hold on;
stem(peak_true,sig(peak_true),'LineStyle','none','Color','g');
hold off;
title(['Signal ' num2str(record_number) ' (lead ' num2str(lead) ') detected/true R peaks']);
legend({'Signal','Detected','True'});


sp2(2) = subplot(2,1,2);
plot(rrsig.^2);
hold on;
stem(peak_locs,rrsig(peak_locs).^2,'x','LineStyle','none');
linkaxes(sp2,'x');
title('Reconstructed signal');


end
