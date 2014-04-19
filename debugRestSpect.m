%Was used to debug rest spectrum and find beta bump
%avgManySpect together and plot on semilogy scale

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


% %% beta depression demo
% [flex_pow, flex_f]=avgManySpect(flex_tm());
% [rest_pow, rest_f]=avgManySpect(rest_tm);
% 
% f_min=find(flex_f>15,1);
% f_max=find(flex_f>40,1);
% r_min=find(rest_f>15,1);
% r_max=find(rest_f>40,1);
% semilogy(flex_f(f_min:f_max),flex_pow(f_min:f_max),rest_f(r_min:r_max),rest_pow(r_min:r_max))
% legend('Finger Flex','Rest')
% xlabel('Frequency (Hz)')
% ylabel('Power')