function [ timeStampMat, timeStampMatTrunc ] = findFingerFlex( train_dg, TW_DUR, Fs )
% Description: parse for finger flex time windows
% Inputs: the finger flex data
% Ouput: a matrix filled with time stamps. each column
%         represents a finger channel. each entry in a column
%         represents the start of a finger flex event that lasts TW_DUR

%thresold
thres=1;

%margain on either side of time window of detected finger flex
buf=(TW_DUR-2*Fs)/2;                %sec * sample/sec


%time window for finger flex
dur=TW_DUR;

%number of fingers
fing_num=size(train_dg,2);

%window length for detecting threshold
wind=250;                        %sample

%initializations
z=1;
i=1+buf;

for f=1:fing_num
    while (i+wind) < size(train_dg,1)
        
        if mean(train_dg(i:i+wind,f)) > thres
            %if train_dg(i,f)>thres %old single point threshold detector
            i=i+ceil(wind/2); %new time window averaging method
            
            
            t1=i-buf;
            t2=t1+dur;
            if t2>size(train_dg,1) %don't count event that happens "too" close
                %to end
                break
            end
            timeStampMat(z,f)=t1;
            z=z+1;
            i=t2+1;
        else
            i=i+1;
        end
        
    end
    i=1+buf;
    z=1;
end

x=nan(fing_num,1);
for f=1:fing_num
    tmp=find(timeStampMat(:,f)==0,1);
    if isempty(tmp)
        x(f)=length(timeStampMat(:,f));
    else
        x(f)=tmp-1;
    end
end
timeStampMatTrunc=timeStampMat(1:min(x),:);

end



