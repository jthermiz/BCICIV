%%
clc;
clear;
close all;
%%
load('data/sub1_comp.mat');

f_s = 1000;
timerange = 1:400*f_s;
channels = 1:62;
windowlen = 512;

t = timerange/f_s;

numchannels = size(channels,2);
finger = 1;

NFFT = 256;
NW = 4;
% gamma band = 66 to 114ish
minfreq = 66;
maxfreq = 114;
minbin = int32(NFFT/2*(minfreq/(f_s/2))+1);
maxbin = int32(NFFT/2*(maxfreq/(f_s/2))+1);

%% detecting movements
[pks, idxs] = findpeaks(train_dg(timerange, finger), 'MINPEAKHEIGHT', ...
                        0.5, 'MINPEAKDISTANCE', windowlen/2);

% plotting movements
figure;
plot(timerange, train_dg(timerange,finger));
hold all;
stem(idxs+timerange(1), pks);
stem(idxs+timerange(1)-windowlen/2, pks);
stem(idxs+timerange(1)+windowlen/2-1, pks);
numpeaks = size(pks,1);

finger_movements = zeros(windowlen, numpeaks);
erps = zeros(windowlen, numchannels);
psds = zeros(NFFT/2+1, numchannels);

% calculating power spectrum for each period of motion
for k=1:numpeaks
    from = idxs(k)-windowlen/2;
    to = idxs(k) + windowlen/2-1;
    finger_movements(:,k) = train_dg(from:to, finger);
    erps = erps + train_data(from:to, channels);
    for l = 1:numchannels
        % psd = mtspectrumc(train_data(from:to, l), params);
        % [psd,f] = pmtm(train_data(from:to, l))
        psds(:, l) = psds(:, l) + pmtm(train_data(from:to, l), NW, NFFT);
    end
end
erps = erps/numpeaks;
psds = psds/numpeaks;
mean_finger_movement = mean(finger_movements,2);
figure,plot(erps);
figure;
imagesc(psds');

% mean_gamma_power = mean(psds(minbin:maxbin, :), 1);
% sd_gamma_power = std(psds(minbin:maxbin, :), 0, 1);

figure;
boxplot(psds(minbin:maxbin, :), 'datalim', [0 1E6], 'extrememode', ...
        'clip');

savefig(gcf, finger);
