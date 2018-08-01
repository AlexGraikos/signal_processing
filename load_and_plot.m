clear all;

% Read signals from database
[sig1,fs1,tm1] = rdsamp('mitdb/112',1);
[sig2,fs2,tm2] = rdsamp('mitdb/123',2);
[sig3,fs3,tm3] = rdsamp('mitdb/118',1);
[sig4,fs4,tm4] = rdsamp('mitdb/217',1);
[sig5,fs5,tm5] = rdsamp('mitdb/221',2);

% Read signal annotations
% anntype:  N - normal
%           
%           
[ann1,anntype1] = rdann('database/mitdb/112', 'atr');
[ann2,anntype2] = rdann('database/mitdb/123', 'atr');
[ann3,anntype3] = rdann('database/mitdb/118', 'atr');
[ann4,anntype4] = rdann('database/mitdb/217', 'atr');
[ann5,anntype5] = rdann('database/mitdb/221', 'atr');

% Plot signals with annotations
figure();
plot(tm1,sig1);
hold on;
stem(tm1(ann1),sig1(ann1),'LineStyle','none');
title('Signal 112 w/ annotations');

figure();
plot(tm2,sig2);
hold on;
stem(tm2(ann2),sig2(ann2),'LineStyle','none');
title('Signal 123 w/ annotations');

figure();
plot(tm3,sig3);
hold on;
stem(tm3(ann3),sig3(ann3),'LineStyle','none');
title('Signal 118 w/ annotations');

figure();
plot(tm4,sig4);
hold on;
stem(tm4(ann4),sig4(ann4),'LineStyle','none');
title('Signal 217 w/ annotations');

figure();
plot(tm5,sig5);
hold on;
stem(tm5(ann5),sig5(ann5),'LineStyle','none');
title('Signal 221 w/ annotations');