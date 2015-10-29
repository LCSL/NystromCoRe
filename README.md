


![LIM2](http://s22.postimg.org/x4jihvp0x/lim2.png)
The NyströmCoRe Matlab Package
========================
***Less is More: Nyström Computational Regularization***

![LIM1](http://s4.postimg.org/e8cnt4sst/LIS1.png)




Copyright (C) 2015, [Laboratory for Computational and Statistical Learning](http://lcsl.mit.edu/#/home) (IIT@MIT).
All rights reserved.

*By Raffaello Camoriano, Alessandro Rudi and Lorenzo Rosasco*

*Contact: raffaello.camoriano@iit.it*

Please check the attached license file.

Introduction
============

This Matlab package provides an implementation of the Nyström Computational Regularization algorithm presented in the following work:

> *Alessandro Rudi, Raffaello Camoriano, Lorenzo Rosasco*, ***Less is More: Nyström Computational Regularization***, 16 Jul 2015, http://arxiv.org/abs/1507.04717

> We study Nyström type subsampling approaches to large scale kernel methods, and prove learning bounds in the statistical learning setting, where random sampling and high probability estimates are considered. In particular, we prove that these approaches can achieve optimal learning bounds, provided the subsampling level is suitably chosen. These results suggest a simple incremental variant of Nyström Kernel Regularized Least Squares, where the subsampling level implements a form of computational regularization, in the sense that it controls at the same time regularization and computations. Extensive experimental analysis shows that the considered approach achieves state of the art performances on benchmark large scale datasets. 

This software package provides a simple and extendible interface to Nyström Computational Regularization. It has been tested on MATLAB r2014b, but should work on newer and older versions too. If it does not, please contact us and/or open an issue. Examples are available  in the "examples" folder.

Examples
====

Automatic training with default options
----

```matlab

load breastcancer

% Perform default cross validation
[ training_output ] = nystromCoRe_train( Xtr , Ytr );

% Perform predictions on the test set and evaluate results
[ prediction_output ] = nystromCoRe_test( Xte , Yte , training_output);
```

Specifying a custom kernel parameter
----
```matlab


load breastcancer

% Customize configuration
config = config_set('kernel.kernelParameter' , 0.9 , ...           % Change gaussian kernel parameter (sigma)
                    'kernel.kernelFunction' , @gaussianKernel);     % Change kernel function

% Perform default cross validation
[ training_output ] = nystromCoRe_train( Xtr , Ytr , config);

% Perform predictions on the test set and evaluate results
[ prediction_output ] = nystromCoRe_test( Xte , Yte , training_output);
```

Specifying a custom subsampling level range
----
```matlab

load breastcancer

% Customize configuration
config = config_set('kernel.minM' , 10 , ...         % Minimum subsampling level
                    'kernel.maxM' , 200 , ...        % Maximum subsampling level
                    'kernel.numStepsM' , 191 , ...   % Set m steps (in this version, it must be set to maxM - minM + 1)
                    'kernel.kernelParameter' , 0.9 , ...           % Change gaussian kernel parameter (sigma)
                    'kernel.kernelFunction' , @gaussianKernel);     % Change kernel function

% Perform default cross validation
[ training_output ] = nystromCoRe_train( Xtr , Ytr , config);

% Perform predictions on the test set and evaluate results
[ prediction_output ] = nystromCoRe_test( Xte , Yte , training_output);
```

Some more customizations
----
```matlab

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
```
**For a complete list of customizable configuration options, see the next section.**


Configuration Parameters
====
All the configurable parameters of the algorithm can be set by means of the provided *config_set* function, which returns a custom configuration structure that can be passed to the *nystromCoRe_train* function. If no configuration structure is passed, *nystromCoRe_train* uses the default configuration parameters listed below. *nystromCoRe_train* performs the training by running the NYTRO algorithm. It returns a structure with the trained model, which can then be passed to *nystromCoRe_test* for performing predictions and test error assessment.

This is an example of how the configuration parameters can be customized by means of the *config_set* function. See the code in "examples/customCrossValidation.m" for more details.

```matlab
% Customize configuration
config = config_set('crossValidation.recompute' , 1 , ...           % Recompute the solution after cross validation
                    'crossValidation.codingFunction' , @zeroOneBin , ...   % Change coding function
                    'crossValidation.errorFunction' , @classificationError , ...   % Change error function
                    'kernel.kernelParameter' , 0.9 , ...           % Change kernel parameter (sigma)
                    'kernel.kernelFunction' , @gaussianKernel);     % Change kernel function
```

**The default configuration parametrs are reported below:**
* **Data**
    * data.shuffle = 1

* **Cross Validation**
    * crossValidation.storeTrainingError = 0
    * crossValidation.validationPart = 0.2
    * crossValidation.recompute = 0
    * crossValidation.errorFunction = @rmse
        * Provided functions (*errorFunctions* folder):
            * @rmse: root mean squared error
            * @classificationError : Relative classification error (error rate)
        * Custom functions can be implemented by the user, simply following the input-output structure of any of the provided functions.
    * crossValidation.codingFunction = [ ]
        * Provided functions (*codingFunctions* folder):
            * @plusMinusOneBin: Class 1: +1, class 2: -1
            * @zeroOneBin : Class 1: +1, class 2: 0
        * Custom functions can be implemented by the user, simply following the input-output structure of any of the provided functions.
    * crossValidation.stoppingRule = @windowLinearFitting
        * Provided functions (*stoppingRules* folder):
            * @windowSimple: Stops if the ratio e1/e0 >= (1-threshold). e1 is the error of the most recent iteration. e0 is the error of the oldest iteration in the window
            * @windowAveraged : Works like @windowSimple, but taking e1 and e0 as the mean over the oldest and newest 10% of the points contained in the window (to increase stability).
            * @windowMedian : Works like @windowAveraged, but computes the median rather than the mean.
            * @windowLinearFitting : Works like @windowSimple, but uses a linear fitting of all the points in the window to obtain a more stable estimate of e0 and e1.
        * Custom functions can be implemented by the user, simply following the input-output structure of any of the provided functions.
    * crossValidation.windowSize = 10
    * crossValidation.threshold = 0

* **Filter**
    * filter.numLambdaGuesses  = 11
    * filter.lambdaGuesses  = logspace(0,-10,config.filter.numLambdaGuesses)

* **Kernel**
    * kernel.kernelFunction  = @gaussianKernel
        * Provided functions:
            * @gaussianKernel : Gaussian kernel function. In this case, the kernel parameter is the bandwidth sigma.
        * Custom functions can be implemented by the user, simply following the input-output structure of any of the provided functions.
    * kernel.kernelParameter = 1
    * kernel.fixedM = [];
    * kernel.minM = 10;
    * kernel.maxM = 100;
    * kernel.numStepsM = 91;    
    
Output structures
======

*nystromCoRe_train*
----

* best.
    * validationError : Best validation error found in cross validation
    * m : Best subsampling level
    * alpha : Best coefficients vector
    * lambda : Best lambda
    * lambdaIdx : Best lambda index
    * sampledPoints : Sampled training points associated to the lowest validation error

* time.
    * kernelComputation : Time for kernel computation
    * crossValidationTrain : Time for filter iterations during cross validation
    * crossValidationEval : Time for validation error evaluation during cross validation
    * crossValidationTotal : Cumulative cross validation time
    * retrainint : Time for retraining after cross validation
    * fullTraining : Training time in the just-train case (no cross validation)

* errorPath.
    * training : Training error path for each of the computed iterations
    * validation : Validation error path for each of the computed iterations

*nystromCoRe_test*
----

* YtePred : Predicted output
* testError : Test error
* time.
    * kernelComputation : Kernel computation time
    * prediction : Prediction computation time
    * errorComputation : Error computation time