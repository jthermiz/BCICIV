%% classification of rest and no rest

%create features
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
errorbar(log10(mu),mean(crr,2),std(crr,0,2),'*k')

for i=1:1000
    [~,acc(i),right,wrong]=logLinearOpt(ff_matrix_z,labels,0);
    R(i)={right};
    W(i)={wrong};
end
mean(acc)
std(acc)

for i=1:10
    R_1(i)=sum(R{i}==1)/length(R{i});
    W_1(i)=sum(W{i}==1)/length(W{i});
end
mean(R_1)
mean(W_1)

