% close all
% c='bgrmk';
% hold on
% for i=1:1
%     st=(i-1)*5+1;
%     fn=st+4;
%     [pow,f]=avgManySpect(rest_tm(:,st:fn,1,1));
%     semilogy(f,pow,c(i),'LineWidth',2)
% end
% 
% figure
% hold on
% for i=6:10
%     st=(i-1)*5+1;
%     fn=st+5;
%     [pow,f]=avgManySpect(rest_tm(:,st:fn,1,1));
%     semilogy(f,pow,c(i-5),'LineWidth',2)
% end
% hold off

[pow,f]=avgManySpect(rest_tm(:,1:51,1,7));
    semilogy(f(1:100),pow(1:100),'b','LineWidth',2)