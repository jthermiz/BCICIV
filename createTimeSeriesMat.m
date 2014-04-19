function [tm]=createTimeSeriesMat(train_data, ts ,dur)
%generate a matrix that is dur X number of time stamps in ts
%each column is a time series.. time series are picked from train_data

%number of fingers
class_num = size(ts,2);

%number of events (or trials)
ev_max=size(ts,1); %assumes ts matrix contains no zero entries

%number of ECoG channels
ch_num=size(train_data,2);

%init tm matrix
%tm is 4d... 1D=time series, 2D=number of events, 3D=class (or finger),
%4D=ECoG channel number
ev_num=sum(~ts(:)==-1);
tm = nan(dur, ev_num, size(ts, 2), ch_num);

for class = 1:class_num
    for ch = 1:ch_num   
        ev=1;
        while  ev<=size(ts,1) && ~(ts(ev,class)==-1)      
            tm (:, ev, class, ch) = train_data(ts(ev, class):ts(ev, class)+dur-1, ch);
            ev=ev+1;            
        end
    end
end



end
