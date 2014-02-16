function [x_mat, s_mat ] = powerMatrix(neural_data,ts_mat,TW_DUR,Fs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

CH_num=size(neural_data,2);
FING_num=size(ts_mat,2);
x_mat=zeros(FING_num,CH_num);
s_mat=zeros(FING_num,CH_num);
params=[];
params.tapers=[5 9];
params.Fs=Fs;

for CH=1:CH_num
    for FING=1:FING_num  
        tic
        EX_num=find(ts_mat(:,FING)==0,1)-1;
        if isempty(EX_num)
            EX_num=size(ts_mat,2);
        end
        x_tmp=zeros(EX_num,1);
        for EX=1:EX_num
            t1=ts_mat(EX,FING);
            t2=t1+TW_DUR;
            S=mtspectrumc(neural_data(t1:t2,CH),params);
            x_tmp(EX)=mean(S);            
        end
        x_mat(FING,CH)=mean(x_tmp);
        s_mat(FING,CH)=std(x_tmp);
        toc
    end
%     %rs_vec stuff
%     EX_num=length(rs_vec);
%     x_tmp=zeros(EX_NUM,1);
%     for EX=1:EX_num
%         t1=rs_vec;
%         t2=t1+TW_DUR;
%         x_tmp(EX)=mean(neural_data(t1:t2,CH));
%     end
%     x_mat(FING_num+1,CH)=mean(x_tmp);
%     s_mat(FING_num+1,CH)=mean(x_tmp);
end




   