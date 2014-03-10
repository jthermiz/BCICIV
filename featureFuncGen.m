function [ ff_matrix ] = featureFuncGen(rest_tm, flex_tm )
%Generate matrix of feature functions, where columns are features
%and rows are examples
%First column is the label.
%Examples are randomized

ch_num=size(rest_tm,4);
beta=[15,40];
gamma=[66,114];
ex_num=size(rest_tm,2)+size(flex_tm,2)*size(flex_tm,3);
F=ch_num*2+1;
ff_matrix=zeros(ex_num,F);
z=1;


for ex=1:size(rest_tm,2)
    for ch=1:ch_num
        sig=rest_tm(:,ex,1,ch);
        [psd, f]=avgManySpect(sig);
        bp=avgBandPower(psd,f,beta(1),beta(2));
        gp=avgBandPower(psd,f,gamma(1),gamma(2));
        ff_matrix(z,ch*2)=bp;
        ff_matrix(z,ch*2+1)=gp;        
    end
    ff_matrix(z,1)=0;
    z=z+1;
end

for ex=1:size(flex_tm,2)
    for class=1:size(flex_tm,3)
        for  ch=1:ch_num
            sig=flex_tm(:,ex,class,ch);
            [psd, f]=avgManySpect(sig);
            bp=avgBandPower(psd,f,beta(1),beta(2));
            gp=avgBandPower(psd,f,gamma(1),gamma(2));
            ff_matrix(z,ch*2)=bp;
            ff_matrix(z,ch*2+1)=gp;            
        end
        ff_matrix(z,1)=1;
        z=z+1;
    end
end


end

