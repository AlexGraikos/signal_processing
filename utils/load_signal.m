function [sig,fs,tm,ann,anntype] = load_signal(record_number,lead,multi_plot)
% [sig,fs,tm,ann,anntype] = load_signal(record_number,lead,multi_plot)
%
%   Inputs:
% record_number: MIT-BIH Arrhythmia DB record number
% lead: ECG lead chosen
% multi_plot: Suppresses figure creation for use in multi-plots
%
%   Outputs:
% sig: Recorded signal
% fs: Sampling frequency
% tm: Sample time labels
% ann: Annotation labels
% anntype: Annotaion types
%
% e.g. [sig,fs,tm,ann,anntype] = load_signal(112,1)

if (nargin < 3)
    multi_plot = 0;
end

% Read data 
[sig,fs,tm] = rdsamp(['database/mitdb/' num2str(record_number)], lead);

% Read signal annotations
% Explained in detail at
% https://physionet.org/physiobank/annotations.shtml
[ann,anntype] = rdann(['database/mitdb/' num2str(record_number)], 'atr');

% Plot signal with annotations
if (multi_plot)
    plot(sig);
    title(['Signal ' num2str(record_number) ' (lead ' num2str(lead) ')']);
    xlabel('Samples');
    ylabel('s[n]');
else
    figure();
    plot(tm,sig);
    hold on;
    text(tm(ann),sig(ann),anntype);
    title(['Signal ' num2str(record_number) ' annotated (lead ' num2str(lead) ')']);
end

end
