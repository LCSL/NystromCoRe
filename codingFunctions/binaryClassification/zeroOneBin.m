function [ Ypred ] = zeroOneBin( Yscores )
%zeroOneBin Encodes prediction vector as: Class 1: +1; Class 2: 0
%   Detailed explanation goes here

    if size(Yscores,2)>1
        error('zeroOneBin is designed for binary classification coding');
    end

    Ypred = zeros(size(Yscores,1),1);
    Ypred(Yscores>0.5) = 1;
end

