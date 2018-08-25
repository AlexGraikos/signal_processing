% Analyze signals by applying transofmations required
% Results are saved in report/fig

params = cell(14,1);
% Parameter definitions:
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


%% Signal 112 (lead 1)
params{1} = 100;
params{2} = 0.5;
params{3} = 150;
params{4} = 0.5;
params{5} = 'amor';
params{6} = [];
params{7} = 'morse';
params{8} = [1.5 3];
params{9} = 6;
params{10} = 'db4';
params{11} = 6;
params{12} = 'bior1.3';
params{13} = 100;
params{14} = 0.1;

% gather_results(record_number, lead, n0, n1, parameters)
gather_results(112,1,20001,35000,params);
close all;


%% Signal 112 (lead 2)
% Use same parameters as before (signal 112 lead 1)
gather_results(112,2,20001,35000,params);
close all;


%% Signal 123 (lead 1)
params{1} = 150; % Slower heart rate can lengthen window -> better freq resolution
params{2} = 0.5;
params{3} = 150; % Good enough to achieve satisfying freq and time resolution
params{4} = 0.5;
params{5} = 'amor';
params{6} = [];
params{7} = 'morse'; % Morse seems to achieve better 'sharpness' (more similar to qrs complex?)
params{8} = [1.5 3];
params{9} = 6;
params{10} = 'db4'; % db4 still has better resolution for detecting qrs complexes
params{11} = 6;
params{12} = 'bior1.3';
params{13} = 100;
params{14} = 0.1; % Mode mixing seems to be reduced by applying EEMD

gather_results(123,1,110001,125000,params);
close all;


%% Signal 118 (lead 1)  
params{1} = 150; % RBBB lengthens QRS complex, can increase time window for better freq resolution
params{2} = 0.5;
params{3} = 150; % APCs/PVCs contain different frequencies and could be discerned
params{4} = 0.5;
params{5} = 'amor'; % APCs/PVCs are much more discernable and can be easily seperated
params{6} = [];
params{7} = 'morse'; % Sharper spectra but much more difficult to distinguish non-normal beats
params{8} = [1.5 3];
params{9} = 6;
params{10} = 'db4'; % APCs/PVCs are visible on detail spaces
params{11} = 6;
params{12} = 'bior1.3';
params{13} = 100;
params{14} = 0.1; % Mode mixing not as apparent. More likely in higher IMFs

gather_results(118,1,350001,365000,params);
close all;


%% Signal 217 (lead 1)
params{1} = 100; % Needs smaller win_len for better time resolution. 
                 % Difficult to discern between different types of pulses
params{2} = 0.5; % PVCs can be a bit more discernable. Lower freqs are amplified during PVCs.
params{3} = 110;
params{4} = 0.5;
params{5} = 'amor'; % PVCs much more easier to discern. Lower freqs have highter amplitude during PVCs.
params{6} = [];
params{7} = 'morse'; % Same as morlet but with sharper results
params{8} = [1.5 3];
params{9} = 10;
params{10} = 'db4'; % Needs more detail levels to locate PVCs
params{11} = 10;
params{12} = 'bior1.3'; % PVCs appear in some of the higher detail signals.
                        % The higher the signal the lower the resolution
                        % though
params{13} = 100;
params{14} = 0.1; % Heavy mode mixing. IMF that follows heart rate is disturbed when PVCs appear.
                  % There is an IMF that detects abnormal beats.

gather_results(217,1,180001,195000,params);
close all;


%% Signal 221 (lead 1)
params{1} = 110; % Really difficult to discern different beats. Maybe some lower freqs amplified.
                 % Atrial fibrillation is clearly visible.
params{2} = 0.5; % Abnormal beats (PVCs) easier to discern. Lower freqs clearly have higher amplitude.
params{3} = 100;
params{4} = 0.5;
params{5} = 'amor'; % PVCs distinguishable. Lower freqs of PVC beat are apparent.
params{6} = [];
params{7} = 'morse'; % PVCs still discernable. Higher sharpness allows better localization of R-R intervals.
params{8} = [1.5 3];
params{9} = 10;
params{10} = 'db4'; % PVCs are located in high detail coeffs.
params{11} = 10;
params{12} = 'bior1.3'; % Clearer results than db4 wavelet.
params{13} = 100;
params{14} = 0.1; % EEMD is a must. Heart rate IMF is all over the place cause of atrial fibrillation.
                  % PVC detecting IMF is weaker but still exists.

gather_results(221,1,60001,75000,params);
close all;

