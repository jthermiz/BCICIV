function [ ff_matrix ] = featureFuncGen(rest_tm, flex_tm )
%Generate matrix of feature functions, where columns are features
%and rows are examples
%First column is the label.
%Examples are randomized

ch_num=size(rest_tm,4);
    beta=[15,40];
%     beta1=[15 25];
%     beta2=[26 40];
    gamma=[66,114];
%     gamma1=[66 90];
%     gamma2=[91 114];
%     high=[130 170];
%     high1=[130 150];
%     high2=[151 170];

fea=2;
ex_num=size(rest_tm,2)+size(flex_tm,2)*size(flex_tm,3);
F=ch_num*fea; %for BG
%F=ch_num+1; % for B
ff_matrix=zeros(ex_num,F);
labels=zeros(ex_num,1);
z=1;

%create rest examples

%need to fix!!!
for ex=1:size(rest_tm,2)
    for ch=1:ch_num
        sig=rest_tm(:,ex,1,ch);
        [psd, f]=avgManySpect(sig);
        bp=avgBandPower(psd,f,beta(1),beta(2));
        %ff_matrix(z,ch+1)=bp;
        gp=avgBandPower(psd,f,gamma(1),gamma(2));
        ff_matrix(z,(ch-1)*fea+1)=bp;
        ff_matrix(z,(ch-1)*fea+2)=gp;
%         x=avgBandPower(psd,f,beta1(1),beta1(2));
%         ff_matrix(z,(ch-1)*fea+2)=x;
%         x=avgBandPower(psd,f,beta2(1),beta2(2));
%         ff_matrix(z,(ch-1)*fea+3)=x;
%         x=avgBandPower(psd,f,gamma1(1),gamma1(2));
%         ff_matrix(z,(ch-1)*fea+4)=x;
%         x=avgBandPower(psd,f,gamma2(1),gamma2(2));
%         ff_matrix(z,(ch-1)*fea+5)=x;
%         x=avgBandPower(psd,f,high(1),high(2));
%         ff_matrix(z,(ch-1)*fea+6)=x;
%         x=avgBandPower(psd,f,high1(1),high1(2));
%         ff_matrix(z,(ch-1)*fea+7)=x;
%         x=avgBandPower(psd,f,high2(1),high2(2));
%         ff_matrix(z,(ch-1)*fea+8)=x;
    end
    labels(z,1)=0;
    z=z+1;
end

%create flex examples
for ex=1:size(flex_tm,2)
    for class=1:size(flex_tm,3)
        if flex_tm(:,ex,class,:) == zeros(size(flex_tm(:,ex,class,:)))
            continue;
        end
        for  ch=1:ch_num
            
            
            sig=flex_tm(:,ex,class,ch);
            [psd, f]=avgManySpect(sig);
            bp=avgBandPower(psd,f,beta(1),beta(2));
            %ff_matrix(z,ch+1)=bp;
            gp=avgBandPower(psd,f,gamma(1),gamma(2));
            ff_matrix(z,(ch-1)*fea+1)=bp;
            ff_matrix(z,(ch-1)*fea+2)=gp;
%             x=avgBandPower(psd,f,beta1(1),beta1(2));
%             ff_matrix(z,(ch-1)*fea+2)=x;
%             x=avgBandPower(psd,f,beta2(1),beta2(2));
%             ff_matrix(z,(ch-1)*fea+3)=x;
%             x=avgBandPower(psd,f,gamma1(1),gamma1(2));
%             ff_matrix(z,(ch-1)*fea+4)=x;
%             x=avgBandPower(psd,f,gamma2(1),gamma2(2));
%             ff_matrix(z,(ch-1)*fea+5)=x;
%             x=avgBandPower(psd,f,high(1),high(2));
%             ff_matrix(z,(ch-1)*fea+6)=x;
%             x=avgBandPower(psd,f,high1(1),high1(2));
%             ff_matrix(z,(ch-1)*fea+7)=x;
%             x=avgBandPower(psd,f,high2(1),high2(2));
%             ff_matrix(z,(ch-1)*fea+8)=x;
            
        end
        labels(z,1)=1;
        z=z+1;
    end
end

ff_matrix=[labels,ff_matrix];

%eliminate all examples with all zero entries
ff_matrix(all(ff_matrix==0,2),:)=[];

end

