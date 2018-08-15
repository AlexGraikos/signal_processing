% Loads and plots signals from database
signals = [112, 123, 118, 217, 221];

% Read signals from database
[sig1,fs1,tm1] = rdsamp(['database/mitdb/' num2str(signals(1))],1);
[sig2,fs2,tm2] = rdsamp(['database/mitdb/' num2str(signals(2))],2);
[sig3,fs3,tm3] = rdsamp(['database/mitdb/' num2str(signals(3))],1);
[sig4,fs4,tm4] = rdsamp(['database/mitdb/' num2str(signals(4))],1);
[sig5,fs5,tm5] = rdsamp(['database/mitdb/' num2str(signals(5))],2);

% Read signal annotations
% Explained in detail at
% https://physionet.org/physiobank/annotations.shtml
[ann1,anntype1] = rdann(['database/mitdb/' num2str(signals(1))], 'atr');
[ann2,anntype2] = rdann(['database/mitdb/' num2str(signals(2))], 'atr');
[ann3,anntype3] = rdann(['database/mitdb/' num2str(signals(3))], 'atr');
[ann4,anntype4] = rdann(['database/mitdb/' num2str(signals(4))], 'atr');
[ann5,anntype5] = rdann(['database/mitdb/' num2str(signals(5))], 'atr');

% Plot signals with annotations
figure();
plot(tm1,sig1);
hold on;
text(tm1(ann1),sig1(ann1),anntype1);
title(['Signal ' num2str(signals(1)) ' annotated']);

figure();
plot(tm2,sig2);
hold on;
text(tm2(ann2),sig2(ann2),anntype2);
title(['Signal ' num2str(signals(2)) ' annotated']);

figure();
plot(tm3,sig3);
hold on;
text(tm3(ann3),sig3(ann3),anntype3);
title(['Signal ' num2str(signals(3)) ' annotated']);

figure();
plot(tm4,sig4);
hold on;
text(tm4(ann4),sig4(ann4),anntype4);
title(['Signal ' num2str(signals(4)) ' annotated']);

figure();
plot(tm5,sig5);
hold on;
text(tm5(ann5),sig5(ann5),anntype5);
title(['Signal ' num2str(signals(5)) ' annotated']);
