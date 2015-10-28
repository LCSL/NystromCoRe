function stop = windowLinearFitting(err , winSize , thres)
%WINDOWLINEARFITTING Stop if error decreases less than a threshold 'thres' in a window
% of size winSize
%   Detailed explanation goes here
    
    stop = 0;
    
    if numel(err) >= winSize
        
        l = winSize - 1;
        
        currErr = err( ( end-winSize + 1 ) : end );
        x = (0:winSize-1)';
        X = [ones(winSize,1), x];
        b = X\currErr';
        
        if (l*b(2)/b(1)) >= thres
            stop = 1;
        end
    end
end

