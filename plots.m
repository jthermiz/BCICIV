load('sub1_comp.mat');

%%
timerange = 1:10000;
channels = 1:10;
windowlen = 512;
f_s = 1000;
t = timerange/f_s;
figure,plot(t, train_dg(timerange,:));
legend('Finger 1', 'Finger 2', 'Finger 3', 'Finger 4', 'Finger 5');
%%
for i = channels
    figure;
    spectrogram(train_data(timerange,i), windowlen, [], [], f_s);
    title(sprintf('Channel %d', i));
end
