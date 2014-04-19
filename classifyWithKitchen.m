%classify with a bunch of models


iter=1;
p=zeros(iter,5);

for i=1:iter
    
    Xtrain=ff_matrix_z;
    Ytrain=labels;
    
    %shuffle examples
    % [Xtrain,Ytrain]=pickExamples(Xtrain,Ytrain);
    N=length(Ytrain);
    idx=randperm(N);
    Xtrain=Xtrain(idx,:);
    Ytrain=Ytrain(idx);
    
    N=length(Ytrain);
    val_per=0.3;
    val_num=floor(val_per*N);
    
    %create validation set
    Xtest=Xtrain(1:val_num,:);
    Ytest=Ytrain(1:val_num);
    
    %create training set
    Xtrain=Xtrain(val_num+1:end,:);
    Ytrain=Ytrain(val_num+1:end);
    
    
    %% Generalized Linear Model -- Logistic Regression
    % Train the classifier
    glm = GeneralizedLinearModel.fit(Xtrain,Ytrain,'linear','Distribution','binomial','link','logit');
    
    % Make a prediction for the test set
    Y_glm = glm.predict(Xtest);
    Y_glm = round(Y_glm);
    
    % Compute the confusion matrix
    C_glm = confusionmat(Ytest,Y_glm);
    P_glm = mean(Ytest==Y_glm);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_glm = bsxfun(@rdivide,C_glm,sum(C_glm,2)) * 100;
    
    %% Quadratic Discrimant Analysis
    
    % % Train the classifier
    % da = ClassificationDiscriminant.fit(Xtrain,Ytrain,'discrimType','quadratic');
    %
    % % Make a prediction for the test set
    % Y_da = da.predict(Xtest);
    %
    % % Compute the confusion matrix
    % C_da = confusionmat(Ytest,Y_da);
    % % Examine the confusion matrix for each class as a percentage of the true class
    % C_da = bsxfun(@rdivide,C_da,sum(C_da,2)) * 100
    
    %% Classification Using Nearest Neighbors
    
    % Train the classifier
    knn = ClassificationKNN.fit(Xtrain,Ytrain,'Distance','seuclidean');
    
    % Make a prediction for the test set
    Y_knn = knn.predict(Xtest);
    
    % Compute the confusion matrix
    C_knn = confusionmat(Ytest,Y_knn);
    P_knn = mean(Ytest==Y_knn);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_knn = bsxfun(@rdivide,C_knn,sum(C_knn,2)) * 100;
    
    %% Naive Bayes Classification
    
    % Train the classifier
    Nb = NaiveBayes.fit(Xtrain,Ytrain); %assumes gaussian by default
    
    % Make a prediction for the test set
    Y_Nb = Nb.predict(Xtest);
    
    % Compute the confusion matrix
    C_nb = confusionmat(Ytest,Y_Nb);
    P_nb= mean(Ytest==Y_Nb);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_nb = bsxfun(@rdivide,C_nb,sum(C_nb,2)) * 100;
    
    %% Support Vector Machines
    opts = statset('MaxIter',30000);
    % Train the classifier
    svmStruct = svmtrain(Xtrain,Ytrain,'kernel_function','linear','kktviolationlevel',0.1,'options',opts);
    
    % Make a prediction for the test set
    Y_svm = svmclassify(svmStruct,Xtest);
    C_svm = confusionmat(Ytest,Y_svm);
    P_svm = mean(Ytest==Y_svm);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_svm = bsxfun(@rdivide,C_svm,sum(C_svm,2)) * 100;
    
    %% Decision Trees
    
    % Train the classifier
    t = ClassificationTree.fit(Xtrain,Ytrain);
    
    % Make a prediction for the test set
    Y_t = t.predict(Xtest);
    
    % Compute the confusion matrix
    C_t = confusionmat(Ytest,Y_t);
    P_t =  mean(Ytest==Y_t);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_t = bsxfun(@rdivide,C_t,sum(C_t,2)) * 100;
    
    
    %% Compare all classifiers
    
    Cmat = [C_glm C_nb C_knn  C_svm C_t ];
    Pmat = [P_glm P_nb P_knn P_svm P_t ];
    labels_str = {'Logistic Regression ',...
        'Naive Bayes ', 'k-nearest Neighbors ', 'Support VM ', 'Decision Trees '};
    
    p(i,:)=Pmat;
end

v=mean(p,1)
e=std(p,1)
comparisonPlot( Cmat, labels_str )
figure
bar([Pmat])
axis([0 6 min(Pmat)-.05 max(Pmat)])
title('Prediction Accuracy vs Classification Method')