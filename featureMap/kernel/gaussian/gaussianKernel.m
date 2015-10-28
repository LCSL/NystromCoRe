function M = gaussianKernel(X1, X2, kerPar)
    c = -2.0;
    M = c * X1 * X2';
    
    X1 = X1.*X1;
    Sx1 = sum(X1, 2);
    on2 = ones(1, size(X2,1));
    M = M + Sx1*on2;
    
    X2 = X2.*X2;
    Sx2 = sum(X2, 2)';
    on1 = ones(numel(Sx1),1);
    M = M + on1*Sx2;

    c = -1/(2 * kerPar^2);
    M = c*M; 
    
    M = exp(M);
end
