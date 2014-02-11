clearvars -EXCEPT test_data train_data train_dg ts_mat

%Data Import
if ~exist('test_data') | ~exist('train_data') | ~exist('train_dg')
    clear
    load 'data\sub1_comp.mat'
end

ts_mat=findFingerFlex(train_dg);
t1=ts_mat(2,1); %finger 1, flex 2
t2=ts_mat(2,2); %finger 1, flex 2
d=train_data(t1:t2,10); %correspond time series in ECoG channel 10

params=[];
params.Fs=1000;
[S,f]=mtspectrumc(d,params); %requires Chronux toolkit

semilogy(S)
xlabel('Frequency (Hz)')
ylabel('Power (?)')



 