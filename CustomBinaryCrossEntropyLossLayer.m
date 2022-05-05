classdef CustomBinaryCrossEntropyLossLayer < nnet.layer.RegressionLayer
    % CustomBinaryCrossEntropyLossLayer  Binary cross-entropy loss layer
    %
    % This custom layer is intended for use in multilabel image
    % classification problems.
    %
    % Example:
    %   layer = CustomBinaryCrossEntropyLossLayer("output");
    %
    % Copyright 2021 The MathWorks, Inc.

    methods
        function layer = CustomBinaryCrossEntropyLossLayer(name)
            if isempty(name)
                layer.Name = "";
            else
                layer.Name = name;
            end
        end

        function loss = forwardLoss(~, Y, T)
            loss = crossentropy(Y, T, ...
                'DataFormat', 'SSCB', ...
                'TargetCategories','independent');
        end
    end
end