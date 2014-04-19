function [flist]=visualizingFeatures(ff_matrix_z)

class1=ff_matrix_z(1:50,:);
class2=ff_matrix_z(51:end,:);
flist=maxSep(class1,class2)

for i=1:5
    f=flist(i);
    
    % %plots histogram
    % f=1;
    % b=25;
    % hist(r(:,f),b)
    % histfit(r(:,f),b)
    
    % plot normal distrubtion
    figure
    hold on
    plotDist(class1(:,f),'b')
    plotDist(class2(:,f),'g')
    legend('Rest','Flex')
    str=sprintf('Feature #: %d',f);
    title(str)
    hold off
    
    
    
end


%heat map of best features
% hm=plotHeatMap(flist);
% HeatMap(hm,'Symmetric',0)



    function []=plotDist(data,c)
        [N,X]=hist(data,25);
        %         mu = mean(data);
        %         sd = std(data);
        %         ix = -4*sd:1e-3:4*sd; %covers more than 99% of the curve
        %         iy = pdf('normal', ix, mu, sd);
        tmp=['--*' c];
        plot(X,N,tmp,'LineWidth',3);
        
    end

    function [flist]=maxSep(class1,class2)
        c1_mu=mean(class1,1);
        c2_mu=mean(class2,1);
        tmp=abs(c2_mu-c1_mu);
        [val,flist]=sort(tmp,'descend');
    end

    function [hm_data]=plotHeatMap(flist)
        tmp=[flist' (length(flist):-1:1)'];
        [~,idx]=sort(flist,'ascend');
        tmp=tmp(idx,:);
        hm_data=zeros(8);
        z=1;
        
        for r=1:8
            for c=1:8
                try
                    hm_data(r,c)=tmp(z,2);
                    z=z+1;
                catch
                    return;
                end
            end
        end
    end

end

