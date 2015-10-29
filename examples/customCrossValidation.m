
load breastcancer

% Customize configuration
config = config_set('crossValidation.recompute' , 1 , ...           % Recompute the solution after cross validation
                    'crossValidation.codingFunction' , @zeroOneBin , ...   % Change coding function
                    'crossValidation.errorFunction' , @classificationError , ...   % Change error function
                    'kernel.kernelParameter' , 0.9 , ...           % Change gaussian kernel parameter (sigma)
                    'kernel.kernelFunction' , @gaussianKernel);     % Change kernel function

% Perform default cross validation
[ training_output ] = nystromCoRe_train( Xtr , Ytr , config);

% Perform predictions on the test set and evaluate results
[ prediction_output ] = nystromCoRe_test( Xte , Yte , training_output);