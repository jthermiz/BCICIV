%clearvars -EXCEPT test_data train_data train_dg ts_mat

%Data Import
load('data\sub2_comp.mat')
load('data\sub2_testlabels.mat')
train_dg=[train_dg;test_dg];
train_data=[train_data;test_data];
clearvars -except train_data train_dg


%Sample rate
Fs=1000; %samples/sec

%Time window for finger flex and rest period
TW_DUR=2.5*Fs; %sec*samples/sec
RS_DUR=1*Fs;

%Matrix of finger flex starting points
[ts_mat_t,ts_mat]=findFingerFlex(train_dg,TW_DUR,Fs);

%Number of points collects by ECoG channels
TS_MAX=size(train_data,1);
%TS_MAX=max(max(ts_mat_t)); % because i'm truncating other finger flex so future rest
%periods might be mis-intrepreted.

%Vector of rest starting points
rs_vec=findRest(ts_mat_t,TW_DUR,RS_DUR,TS_MAX,Fs);

%4-D time series matrix
flex_tm=createTimeSeriesMat(train_data,ts_mat_t,TW_DUR);
rest_tm=createTimeSeriesMat(train_data,rs_vec,RS_DUR);

%make features
ff_matrix=featureFuncGen(rest_tm,flex_tm);
ff_matrix_z=zscore(ff_matrix(:,2:end))/100; %zscore and eliminate labels col
labels=ff_matrix(:,1);

%classify -- feature selection
flist=visualizingFeatures(ff_matrix_z);
classifyWithKitchen

% N=5;
% vv=zeros(N,5);
% ee=zeros(N,5);
% figure
% hold on
% for q=1:N
%     classifyWithKitchen
%     vv(q,:)=v;
%     ee(q,:)=e;
%     plot(q,max(v))
% end
% hold off
% 
% [nmax,meth]=max(vv(:));











