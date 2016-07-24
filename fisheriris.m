% Testing the KNN classifier on the fisheriris data

load fisheriris;
X = meas;
Y = species;

mdl = ClassificationKNN.fit(X,Y);

%Predict
Xnew = [min(X);max(X);mean(X)];
label = predict(mdl,Xnew)

%Cross Validation
rng(1);

cvmdl = crossval(mdl);
error = kfoldLoss(cvmdl);

%disp(error);
