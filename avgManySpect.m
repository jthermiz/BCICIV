%Returns average power spectrum using multi-taper method
%Takes tm as agrument which is 4D matrix of time series


function [avg_spect, f]=avgManySpect(tm)

params=[];
params.Fs=1000;
params.tapers=[10 9];

%init's
S=0;

[dur,ev_num,class_num,ch_num]=size(tm);

for ch=1:ch_num
    for class=1:class_num
        for ev=1:ev_num
            
            %multi-taper fft
            [tmp,f]=mtspectrumc(tm(:,ev,class,ch),params);
            S=S+tmp;
            
        end
    end
end

avg_spect=S/(ev_num*class_num*ch_num);

end


