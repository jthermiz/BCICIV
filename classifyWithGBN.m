%Playing around with different classifiers

x=ff_matrix_z(:,2:end);
y=labels;
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
% 
% O1 = NaiveBayes.fit(x,y);
% C1 = O1.predict(x_v);
% cMat1 = confusionmat(y_v,C1) 

glm = GeneralizedLinearModel.fit(x,y,'distr','binomial')

% Make a prediction for the test set
Y_glm = glm.predict(x);
Y_glm = round(Y_glm) + 1;

% Compute the confusion matrix
C_glm = confusionmat(double(y),Y_glm);
% Examine the confusion matrix for each class as a percentage of the true class
C_glm = bsxfun(@rdivide,C_glm,sum(C_glm,2)) * 100
