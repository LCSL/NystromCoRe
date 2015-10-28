function [ error ] = rmse( Y , Ypred )
%RMSE root mean squared error
%   Detailed explanation goes here

    t = size(Y,2);
    n = size(Y,1);
    
    % Compute test set accuracy
    if t>2
        diff = Y - Ypred;
        sqDiff = diff .* diff;
        sqSumDiff = sum(sqDiff,2);
        eucNrmDiff = sqrt(sqSumDiff);

        perf = sqrt(sum(eucNrmDiff.^2)/size(Y,1));
        error = 1 - perf;
    else
        error  = sqrt(sum((Y - Ypred).^2)/n);
    end    
end
