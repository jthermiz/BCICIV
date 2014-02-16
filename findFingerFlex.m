function [ timeStampMat ] = findFingerFlex( train_dg, TW_DUR, Fs )
% Description: parse EMG data for finger flex time windows
% Inputs: the finger flex data
% Ouput: a matrix filled with time stamps. each column
%         represents a finger channel. each entry in a column
%         represents the start of a finger flex event that lasts TW_DUR

thres=1;
buf=0.25*Fs;               %sec * sample/sec
dur=TW_DUR;
%dur=2.5*Fs;                %sec * sample/sec
fing_num=size(train_dg,2);
z=1;
i=1;

for f=1:fing_num
    while i < size(train_dg,1)
        
        if train_dg(i,f)>thres
            t1=i-buf;
            t2=t1+dur;
            if t2>size(train_dg,1) %don't count event that happens "too" close
                                   %to end 
                break
            end
            timeStampMat(z,f)=t1;
            %timeStampMat(z,2*f-1)=t1; timeStampMat(z,2*f)=t2;
            z=z+1;
            i=t2+1;
        else
            i=i+1;
        end
        
    end
    i=1;
    z=1;
end

% %Test Code for this function 
% n=size(train_dg,1);
% num_fing=size(train_dg,2);
% bin_dg=zeros(n,num_fing);
% 
% 
% for i=1:num_fing
%     for j=1:size(ts_mat(:,1:2),1)
%         t1=ts_mat(j,2*i-1);
%         t2=ts_mat(j,2*i);
%         if t1==0 && t2==0
%             break;
%         end
%         bin_dg(t1:t2,i)=1;
%     end
% end
% 
% i=1;
% subplot(2,1,1), plot(train_dg(:,i))
% subplot(2,1,2), plot(bin_dg(:,i))

end



