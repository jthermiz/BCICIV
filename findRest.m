function [ rs_vec ] = findRest( ts_mat,TW_DUR,RS_DUR,TS_MAX,Fs )
%Returns rs_vec, which has time stamps for the start of rest periods

%vectorize ts_mat
ts_vec=ts_mat(:);

%sort time events chronlogically
ts_vec=unique(ts_vec);

if ts_vec(1)==0
    ts_vec=ts_vec(2:end);
end

%add last possible data point (TS_MAX) to vector
ts_vec=cat(1,ts_vec,TS_MAX);

%initialize as -1.. if there no rest events, this vectors return -1
rs_vec=-1;

%rest duration
rs_dur=RS_DUR;

ev_num=length(ts_vec);
z=1;
for ev=1:ev_num-1
    ev1=ts_vec(ev);
    ev2=ts_vec(ev+1);
    tw_num=floor((ev2-ev1-TW_DUR)/rs_dur);
    for tw=1:tw_num
        if tw==1
            rs_vec(z)=ev1+TW_DUR; %rest event occurs after flex event
        else
            rs_vec(z)=rs_vec(z-1)+rs_dur; % each subsequenct rest event
        end
        z=z+1;
    end    
end

rs_vec=rs_vec';

end

