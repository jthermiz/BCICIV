%clearvars -EXCEPT test_data train_data train_dg ts_mat

%Data Import
if ~exist('test_data') | ~exist('train_data') | ~exist('train_dg')
    load 'data\sub1_comp.mat'
end

%Sample rate
Fs=1000; %samples/sec

%Time window for finger flex and rest period
TW_DUR=2.5*Fs; %sec*samples/sec
RS_DUR=1.5*Fs;

%Number of points collects by ECoG channels
%TS_MAX=size(train_data,1);
TS_MAX=max(max(ts_mat)); % because i'm truncating other finger flex so future rest
%periods might be mis-intrepreted.

%Matrix of finger flex starting points
[dum,ts_mat]=findFingerFlex(train_dg,TW_DUR,Fs);

%Vector of rest starting points
rs_vec=findRest(ts_mat,TW_DUR,RS_DUR,TS_MAX,Fs);

%Calculate power matrices
%[px_mat,ps_mat]=powerMatrix(train_data,ts_mat,TW_DUR,Fs);

flex_tm=createTimeSeriesMat(train_data,ts_mat,TW_DUR);
rest_tm=createTimeSeriesMat(train_data,rs_vec,RS_DUR);

%% beta depression demo
[flex_pow, flex_f]=avgManySpect(flex_tm());
[rest_pow, rest_f]=avgManySpect(rest_tm);

f_min=find(flex_f>15,1);
f_max=find(flex_f>40,1);
r_min=find(rest_f>15,1);
r_max=find(rest_f>40,1);
semilogy(flex_f(f_min:f_max),flex_pow(f_min:f_max),rest_f(r_min:r_max),rest_pow(r_min:r_max))
legend('Finger Flex','Rest')
xlabel('Frequency (Hz)')
ylabel('Power')

%% classification of rest and no rest

ff_matrix=featureFuncGen(rest_tm,flex_tm);
ff_matrix_z=zscore(ff_matrix(:,2:end))/100; %zscore and eliminate labels col
ff_matrix_z=cat(2,ones(size(ff_matrix_z,1),1),ff_matrix_z); %add ones in first col
labels=ff_matrix(:,1);


mu=-3:12;
mu=10.^(mu);
for j=1:100
    for i=1:length(mu)
        [dum,crr(i,j)]=logLinearOpt(ff_matrix_z,labels,mu(i));
    end
end
plot(log10(mu),mean(crr,2))




%-------------------------------------

% %% Plot Sample Spectrum
% t1=ts_mat(2,1); %finger 1, flex 2
% t2=t1+TW_DUR; %finger 1, flex 2
% d=train_data(t1:t2,10); %correspond time series in ECoG channel 10
%
% figure
% params=[];
% params.Fs=1000;
% params.tapers=[15 9];
% [S,f]=mtspectrumc(d,params); %requires Chronux toolkit
%
% semilogy(f,S)
% xlabel('Frequency (Hz)')
% ylabel('Power (?)')
% axis([0 200 min( S(1:820) ) max( S(1:820) ) ])

%-------------------------------------

% %% Test Code for this function
% n=size(train_dg,1);
% num_fing=size(train_dg,2);
% bin_dg=zeros(n,num_fing);
%
%
% for i=1:num_fing4
%         if t1==0
%             break;
%         end
%         bin_dg(t1:t2,i)=1;
%     end
% end
%
% i=4;
% figure
% subplot(2,1,1), plot(train_dg(:,i))
% subplot(2,1,2), plot(bin_dg(:,i))



