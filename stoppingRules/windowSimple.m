function stop = windowSimple(err , winSize , thres)
%WINDOWSIMPLE Stop if error decreases less than a threshold 'thres' in a window
% of size winSize
%   Detailed explanation goes here
    
    stop = 0;
    
    if numel(err) >= winSize
        numAvg = ceil(0.1 * winSize);   % Number of points to consider for error averaging

        e0 = err(end - winSize+1);
        e1 = err(end);

        if e1/e0 >= (1 - thres)
            stop = 1;
        end
    end
end
