function stop = windowMedian(err , winSize , thres)
%WINDOWMEDIAN Stop if error decreases less than a threshold 'thres' in a window
% of size winSize, averaging the initial and final error values over a
% fraction of the window size
%   Detailed explanation goes here
    
    stop = 0;
    
    if numel(err) >= winSize

        numAvg = ceil(0.1 * winSize);   % Number of points to consider for error averaging

        e0 = median(err(end - winSize + 1 : end - winSize + numAvg));
        e1 = median(err(end - numAvg + 1 : end));

        if e1/e0 >= (1 - thres)
            stop = 1;
        end
    end
end

