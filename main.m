clearvars -EXCEPT test_data train_data train_dg ts_mat

%Data Import
if ~exist('test_data') | ~exist('train_data') | ~exist('train_dg')
    clear
    load 'data\sub1_comp.mat'
end

Fs=1000; %samples/sec
TW_DUR=2.5*Fs; %sec*samples/sec
TS_MAX=size(train_data,1);

ts_mat=findFingerFlex(train_dg,TW_DUR,Fs);
[px_mat,ps_mat]=powerMatrix(train_data,ts_mat,TW_DUR,Fs);


%% Plot Sample Spectrum
% t1=ts_mat(2,1); %finger 1, flex 2
% t2=t1+TW_DUR; %finger 1, flex 2
% d=train_data(t1:t2,10); %correspond time series in ECoG channel 10
% 
% figure
% params=[];
% params.Fs=1000;
% params.tapers=[5 9];
% [S,f]=mtspectrumc(d,params); %requires Chronux toolkit
% 
% semilogy(f,S)
% xlabel('Frequency (Hz)')
% ylabel('Power (?)')



 