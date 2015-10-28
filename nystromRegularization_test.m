function [ output ] = nystromRegularization_test( Xtr , Xte , Yte , training_output)
%NYTRO_TEST Summary of this function goes here
%   Detailed explanation goes here

    % Compute test kernel
    tic
    KnmTe = training_output.config.kernel.kernelFunction(Xte , ...
                                                         Xtr(training_output.nysIdx,:) , ...
                                                         training_output.config.kernel.kernelParameters);
    output.time.kernelComputation = toc;

    % Perform prediction
    tic
    output.YtePred = KnmTe * training_output.best.alpha;
    if ~isempty(training_output.config.crossValidation.codingFunction)
        output.YtePred = codingFunction(output.YtePred);
    end
    output.time.prediction = toc;

    % Evaluate test error
    tic
    output.testError = training_output.config.crossValidation.errorFunction(Yte , output.YtePred);    
    output.time.errorComputation = toc;
end
