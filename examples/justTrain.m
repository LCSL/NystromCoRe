load breastcancer

% Customize configuration
config = config_set('filter.lambdaGuesses' , 1e-4 , ... % Set a single lambda
                    'kernel.fixedM' , 100 , ...         % Set a fixed subsampling level m (no cross validation is performed in this case)
                    'kernel.kernelParameter' , 0.9 );   % Change gaussian kernel parameter (sigma)

% Perform default cross validation
[ training_output ] = nystromCoRe_train( Xtr , Ytr , config);

% Perform predictions on the test set and evaluate results
[ prediction_output ] = nystromCoRe_test( Xte , Yte , training_output);