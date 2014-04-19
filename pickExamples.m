function [ x_new, y_new ] = pickExamples( x,y )
%Picks a random subset of the training data. Pick y1_num of class=1 and
%y0_num of class=2

%parameters
y1_num=50;
y0_num=50;

%shuffle data 
N=length(y);
idx=randperm(N);
x=x(idx,:);
y=y(idx);

y1_idx=find(y==1,y1_num);
y0_idx=find(y==0,y0_num);

x_new=[x(y1_idx,:); x(y0_idx,:)];
y_new=[y(y1_idx,:); y(y0_idx,:)];

%shuffle data again
N=length(y_new);
idx=randperm(N);
x_new=x_new(idx,:);
y_new=y_new(idx);


end

