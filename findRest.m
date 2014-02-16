function [ rs_vec ] = findRest( ts_mat,TW_DUR, TS_MAX, Fs )
%Still needs work since there are no rest time window large enough!!
buf=0.25*Fs;
ts_vec=ts_mat(:);
zero_flag=find(ts_mat(1,:)==0,1);
ts_vec=unique(ts_vec);

if isempty(zero_flag)
    ts_vec=ts_vec(2:end);
end


ts_vec=cat(1,ts_vec,TS_MAX);
rs_vec=-1;

EV_num=length(ts_vec);
z=1;
for EV=1:EV_num-1
    EV1=ts_vec(EV);
    EV2=ts_vec(EV+1);
    tw_num=floor((EV2-EV1-2*buf-TW_DUR)/TW_DUR);
    for tw=1:tw_num
        if tw==1
            rs_vec(z)=EV1+TW_DUR+buf;
        else
            rs_vec(z)=rs_vec(z-1)+TW_DUR+1;
        end
        z=z+1;
    end    
end

end

