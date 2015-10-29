
load breastcancer

% Perform default cross validation
[ training_output ] = nystromCoRe_train( Xtr , Ytr );

% Perform predictions on the test set and evaluate results
[ prediction_output ] = nystromCoRe_test( Xte , Yte , training_output);