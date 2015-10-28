function [ error ] = classificationError( Y , Ypred )
%classificationError Summary of this function goes here
%   Detailed explanation goes here

    t = size(Y,2);
    n = size(Y,1);

    % Compute test set accuracy
    if t>2
        C = transpose(bsxfun(@eq, Y', Ypred'));
        D = sum(C,2);
        E = D == t;
        numCorrect = sum(E);
        acc = (numCorrect / n);
    else
        C = transpose(bsxfun(@eq, Y', Ypred'));
        D = sum(C,2);
        numCorrect = sum(D);
        acc = (numCorrect / n);
    end
    
    error = 1 - acc;

end

