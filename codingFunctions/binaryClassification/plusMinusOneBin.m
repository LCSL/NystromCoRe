function [ Ypred ] = plusMinusOneBin( Yscores )
%PLUSMINUSONE Encodes prediction vector as: Class 1: +1; Class 2: -1
%   Detailed explanation goes here

    if size(Yscores,2)>1
        error('plusMinusOne is designed for binary classification coding');
    end

    Ypred = -1 * ones(size(Yscores,1),1);
    Ypred(Yscores>0) = 1;
end

