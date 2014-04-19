function [ b_tr, acc, right,wrong ] = logLinearOpt(x,y,mu)


F=size(x,2);
b = ones(F,1);    % Starting guess
options=[];
options.Method='lbfgs';
N=length(y);

idx=randperm(N);
x=x(idx,:);
y=y(idx);

% [x,y]=pickExamples( x,y );
% 
% N=length(y);
% val_per=0.5;
% val_num=floor(val_per*N);
% 
% x_v=x(1:val_num,:);
% y_v=y(1:val_num);
% 
% x=x(val_num+1:end,:);
% y=y(val_num+1:end,:);


[b_tr,fval,exitflag,output] = minFunc(@calcLCL,b,options,x,y);
acc=predictData(b_tr,x,y);


    function [LCL, LCL_prime]= calcLCL(b,x,y)
        LCL1=0;
        LCL0=0;
        LCL_prime=zeros(1,length(b));
        
        
        for i=1:length(y)
            p=calcP(b,x(i,:));
            LCL_prime=LCL_prime+(y(i)-p)*x(i,:);
            if y(i)==1
                LCL1=LCL1+log( p );
            else
                LCL0=LCL0+log( 1 - p );
            end
        end
        
        LCL=LCL1+LCL0;
        LCL_prime=LCL_prime';
        
        %regularize
        LCL=LCL-mu*dot(b,b);
        LCL_prime=LCL_prime-2*mu*b;
        
        %need to negate because minFunc finds minimum
        LCL=-LCL;
        LCL_prime=-LCL_prime;
        
        
    end

    function p = calcP(b,x)
        p=1/(1+exp(-dot(b,x)));
    end

    function acc=predictData(beta,x_t,y_t)
        
        acc=0;
        q=1;
        z=1;
        
        for i=1:size(x_t,1)
            
            p=calcP(beta,x_t(i,:));
            
            if p>=0.5
                guess=1;
                %disp('guess=1');
            else
                guess=0;
                %disp('guess=0');
            end
            
            if guess==y_t(i)
                acc=acc+1;
                right(q)=guess;
                q=q+1;
            else
                wrong(z)=guess;
                z=z+1;
            end
            
        end
        
        acc=acc/length(y_t);
        
    end

if ~exist('wrong')
    wrong=[];
end

if ~exist('right')
    right=[];
end

end



