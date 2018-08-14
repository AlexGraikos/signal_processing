function [c,l] = discr_wt(sig,n,wname)
% c = discr_wt(sig,n,wname)
%
%   Inputs:
% sig: Input signal
% n: Decomposition level
% wname: Wavelet to use
%
%   Outputs:
% c: Decomposition coefficients
% l: Number of coefficients at each level

% Compute n-level wavelet decomposition with specified wavelet
[c,l] = wavedec(sig,n,wname);
approx = appcoef(c,l,wname);
detailed = detcoef(c,l,'cells');
N = length(sig);

% Plot signal
figure();
sp(1) = subplot(n+2,1,1);
plot(sig);
title('Input signal');

% Plot detail coefficients (interpolated to N samples)
for i=1:n
    sp(i+1) = subplot(n+2,1,1+i);
    interpolated_details = ...
        interp1(detailed{i},linspace(1,length(detailed{i}),N));
    plot(interpolated_details);
    title(['Level ' num2str(i) ' detail coefficients']); 
end

% Plot approximation coefficients (interpolated to N samples)
sp(n+2) = subplot(n+2,1,n+2);
interpolated_approx = interp1(approx,linspace(1,length(approx),N));
plot(interpolated_approx);
title('Approximation coefficients');
linkaxes(sp, 'x'); % Link x axes of subplots

end