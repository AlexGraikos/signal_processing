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
params{3} = 100;
params{4} = 0.5;
params{5} = 'amor';
params{6} = [];
params{7} = 'morse';
params{8} = [1.5 3];
params{9} = 6;
params{10} = 'haar';
params{11} = 6;
params{12} = 'sym4';
params{13} = 50;
params{14} = 0.5;

% gather_results(record_number, lead, n0, n1, parameters)
gather_results(112,1,1,1000,params);
close all;


%% Signal 112 (lead 2)
% Use same parameters as before (signal 112 lead 1)
gather_results(112,2,1,1000,params);
close all;


%% Signal 123 (lead 1)
params{1} = 150; % Slower heart rate can lengthen window -> better freq resolution
params{2} = 0.5;
params{3} = 100; % Good enough to achieve satisfying freq and time resolution
params{4} = 0.5;
params{5} = 'amor';
params{6} = [];
params{7} = 'morse'; % Morse seems to achieve better 'sharpness' (more similar to qrs complex?)
params{8} = [1.5 3];
params{9} = 6;
params{10} = 'haar'; % Haar still has better resolution for detecting qrs complexes
params{11} = 6;
params{12} = 'sym4';
params{13} = 50;
params{14} = 0.5; % Mode mixing seems to be reduced by applying EEMD

gather_results(123,1,1,1000,params);
close all;


%% Signal 118 (lead 1)
params{1} = 100;
params{2} = 0.5;
params{3} = 150;
params{4} = 0.5;
params{5} = 'amor';
params{6} = [];
params{7} = 'morse';
params{8} = [1.5 3];
params{9} = 6;
params{10} = 'haar';
params{11} = 6;
params{12} = 'sym4';
params{13} = 30;
params{14} = 0.1;

gather_results(118,1,1,1000,params);
close all;


%% Signal 217 (lead 1)
params{1} = 100;
params{2} = 0.5;
params{3} = 150;
params{4} = 0.5;
params{5} = 'amor';
params{6} = [];
params{7} = 'morse';
params{8} = [1.5 3];
params{9} = 6;
params{10} = 'haar';
params{11} = 6;
params{12} = 'sym4';
params{13} = 30;
params{14} = 0.1;

gather_results(217,1,1,1000,params);
close all;


%% Signal 221 (lead 1)
params{1} = 100;
params{2} = 0.5;
params{3} = 150;
params{4} = 0.5;
params{5} = 'amor';
params{6} = [];
params{7} = 'morse';
params{8} = [1.5 3];
params{9} = 6;
params{10} = 'haar';
params{11} = 6;
params{12} = 'sym4';
params{13} = 30;
params{14} = 0.1;

gather_results(221,1,1,1000,params);
close all;

