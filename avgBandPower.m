function [ pow ] = avgBandPower( psd, f, fmin, fmax )
%calculates the average power for a specific frequency band

a=find(fmin<f,1);
b=find(fmax<f,1);

pow=mean(psd(a:b));

end

