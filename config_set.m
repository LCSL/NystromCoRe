function [ config ] = config_set( varargin )
%CONFIG_SET Constructs the default  configuration stucture to be used by
%nystromRegularization_train

    % Set default configuration fields
    config = struct();

    % data
    config.data.shuffle = 1;

    % crossValidation
    config.crossValidation.storeTrainingError = 0;
    config.crossValidation.validationPart = 0.2;
    config.crossValidation.recompute = 0;
    config.crossValidation.errorFunction = @rmse;
    config.crossValidation.codingFunction = [];
    config.crossValidation.stoppingRule = @windowLinearFitting;
    config.crossValidation.windowSize = 10;
    config.crossValidation.threshold = 0;

    % filter
    config.filter.numLambdaGuesses  = 11;
    config.filter.lambdaGuesses  = logspace(0,-10,config.filter.numLambdaGuesses);

    % kernel
    config.kernel.kernelFunction  = @gaussianKernel;
    config.kernel.kernelParameter = 1;
    config.kernel.fixedM = [];
    config.kernel.minM = 10;
    config.kernel.maxM = 100;
    config.kernel.numStepsM = 91;

    % Parse function inputs
    if ~isempty(varargin)

        % Assign parsed parameters to object properties
        fields = varargin(1:2:end);
        for idx = 1:numel(fields)
            
            currField = fields{idx};
            % Parse current field
            k = strfind(currField , '.');
            k = [0 ; k ; (numel(currField)+1)];
            tokens = cell(1,(numel(k) - 1));
            for i = 1 : (numel(k) - 1);
                tokens{i} = currField( (k(i)+1) : (k(i+1)-1) );
            end

            cmdStr = 'config';
            for i = 1 : (numel(tokens) - 1)
                cmdStr = strcat(cmdStr , '.(''' , tokens{i} , ''')');
            end
            cmdStr = strcat(cmdStr , '.(''' , tokens{end} , ''') = varargin{2*(idx-1) + 2};');
            eval(cmdStr);
        end
    end
    
    % Checks

    if config.filter.numLambdaGuesses  ~= numel(config.filter.lambdaGuesses)
        display(['Number of lambda guesses set to ' , num2str(numel(config.filter.lambdaGuesses))])
        config.filter.numLambdaGuesses  = numel(config.filter.lambdaGuesses);
    end
end
