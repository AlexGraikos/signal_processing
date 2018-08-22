function gather_results(record_number, lead, n0, n1, params)
% gather_results(record_number, lead, n0, n1, parameters)
%
%   Inputs:
% record_numer: MIT-BIH Arrhythmia DB record number to load
% lead: ECG lead
% n0: Starting sample
% n1: End sample
% params: Cell array of analysis parameters
%   params{1} = stft_win_len;
%   params{2} = stft_overlap;
%   params{3} = wdf_win_len;
%   params{4} = wdf_overlap;
%   params{5} = cwt_wavelet1;
%   params{6} = cwt_wavelet1_params;
%   params{7} = cwt_wavelet2;
%   params{8} = cwt_wavelet2_params;
%   params{9} = dwt_wavelet1_level;
%   params{10} = dwt_wavelet1;
%   params{11} = dwt_wavelet2_level;
%   params{12} = dwt_wavelet2;
%   params{13} = hht_nensemble;
%   params{14} = hht_nstd;
%
% e.g. gather_results(112,1,1,10000,params)

% Unwrap parameters
stft_win_len = params{1};
stft_overlap = params{2};
wdf_win_len = params{3};
wdf_overlap = params{4};
cwt_wavelet1 = params{5};
cwt_wavelet1_params = params{6};
cwt_wavelet2 = params{7};
cwt_wavelet2_params = params{8};
dwt_wavelet1_level = params{9};
dwt_wavelet1 = params{10};
dwt_wavelet2_level = params{11};
dwt_wavelet2 = params{12};
hht_nensemble = params{13};
hht_nstd = params{14};

% Load signal
[sig,fs,tm,ann,anntype] = load_signal(record_number,lead);
sig_prefix = ['report/fig/' num2str(record_number) 'l' num2str(lead)];


%% STFT, WDF
stft_wdf_fig = figure();
sp(1) = subplot(3,1,1);
plot(sig(n0:n1));
title(['Signal ' num2str(record_number) ' (lead ' num2str(lead) ')']);
xlabel('Samples');
ylabel('s[n]');
sp(2) = subplot(3,1,2);
stft(sig(n0:n1),fs,stft_win_len,stft_overlap,1); % -- STFT
sp(3) = subplot(3,1,3);
wdf(sig(n0:n1),fs,wdf_win_len,wdf_overlap,1); % -- WDF
linkaxes(sp, 'x');
print(stft_wdf_fig, [sig_prefix '_stft_wdf'],'-dpdf','-fillpage');


%% CWT
cwt_fig = figure();
sp(1) = subplot(3,1,1);
plot(sig(n0:n1));
title(['Signal ' num2str(record_number) ' (lead ' num2str(lead) ')']);
xlabel('Samples');
ylabel('s[n]');
sp(2) = subplot(3,1,2);
wavelet_transform(sig(n0:n1),fs,cwt_wavelet1,cwt_wavelet1_params,1); % -- WT (morlet)
sp(3) = subplot(3,1,3);
wavelet_transform(sig(n0:n1),fs,cwt_wavelet2,cwt_wavelet2_params,1); % -- WT (morse)
linkaxes(sp, 'x');
print(cwt_fig, [sig_prefix '_cwt'], '-dpdf','-fillpage');


%% DWT
[dwt_fig] = wavelet_mra(sig(n0:n1),dwt_wavelet1_level,dwt_wavelet1); % -- WD (haar)
print(dwt_fig, [sig_prefix '_dwt1'], '-dpdf','-fillpage');
[dwt_fig] = wavelet_mra(sig(n0:n1),dwt_wavelet2_level,dwt_wavelet2); % -- WD (sym4)
print(dwt_fig, [sig_prefix '_dwt2'], '-dpdf','-fillpage');


%% HHT
[emd_fig,hht_fig] = hilbert_huang(sig(n0:n1),fs,0,1); % -- HHT
print(emd_fig, [sig_prefix '_emd.pdf'], '-dpdf','-fillpage');
print(hht_fig, [sig_prefix '_hht.pdf'], '-dpdf','-fillpage');

[emd_fig,hht_fig] = hilbert_huang(sig(n0:n1),fs,hht_nstd,hht_nensemble); % -- Ensemble-HHT
print(emd_fig, [sig_prefix '_emd_ensemble'], '-dpdf','-fillpage');
print(hht_fig, [sig_prefix '_hht_ensemble'], '-dpdf','-fillpage');


end