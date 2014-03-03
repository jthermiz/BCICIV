% d = fdesign.bandpass('N,F3dB1,F3dB2',10,0.1,2,Fs);
% Hd = design(d,'butter');
% fvtool(Hd)

low=0.1/(2*pi);
high=5/(2*pi);
W=[low high];

[b a]=butter(4,W,'bandpass');
train=filter(b,a,train_dg(:,1));
test=filter(b,a,test_dg(:,1));

figure
plot(train)
title('train')
figure
plot(test,'r')
title('test')
%% Example Code
% % Make nice signal
% t=(0:999)'/1000;
% x1=sin(10*2*pi*t);
% plot(t,x1);
% 
% % Make a copy with some extra unwanted stuff
% x2=x1+sin(1*2*pi*t);
% plot(t,[x1 x2]);
% 
% % Design a filter to low pass at 0.1xNyquist
% % Nyquist = 500Hz (1/2 the sample rate)
% % Filter will cut below 50Hz
% [b a]=butter(4,W,'bandpass');
% 
% % Use the filter
% x3=filter(b,a,x2);
% 
% % Try a higher order filter
% [b,a]=butter(10,0.1,'low');
% 
% % Use the filter
% x4=filter(b,a,x2);
% plot(t,[x1 x2 x3 x4]);
