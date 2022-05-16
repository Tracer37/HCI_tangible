function [] = main(threshold, verbose)
% main
arguments
    threshold {mustBeNumeric} = 0.7;    % minimal score to send msg (and showe title)  
    verbose {logical}= true             % plot extra information about detected classes
end
    addpath(genpath('lib')) % include interface class

    RETRY_COUNT_MAX = 3; % max send retries before closing app
    RETRY_COUNT = 3;

    % Prepare input - we use laptop camera
    camera = webcam;
    
    % Load pretrained net
    data = load("pretrainedNet.mat");
    net = data.net;
    
    % Get names of existing classes
    classNames = net.Layers(177).Classes;
    
    % Get input size - images need to be resized
    inputSize = net.Layers(1).InputSize(1:2);
    
    % Prepare controler with
    ipAddress='192.168.1.104';
    debugMode = true;
    tc = TangibleController(debugMode, ipAddress);
    
    % prepare display
    h = figure;
    ax1 = gca();
    if verbose
        h.Position(3) = 2*h.Position(3);
        ax1 = subplot(1,2,1);
        ax2 = subplot(1,2,2);
        ax2.PositionConstraint = 'innerposition';
    end
    while ishandle(h)
        % Display and classify the image
        img = snapshot(camera);
        
        % Show image
        image(ax1, img)
        
        img = imresize(img, inputSize);
    
        [label, score] = classify(net, img);
    
        % Get best match
        maxScore = max(score);
        detectedClass = char(label);
    
        if maxScore > threshold
            title(ax1,{detectedClass, num2str(maxScore, "%.2f")});
            
            try
                % send message with detected class name
                tc.ObjectDetected(detectedClass);
                RETRY_COUNT = RETRY_COUNT_MAX;
            catch
                disp("Unable to send data")
                if RETRY_COUNT <= 0
                    disp("Exiting app")
                    break
                end
                RETRY_COUNT = RETRY_COUNT - 1;    
            end
        else
            if verbose
                title(ax1,[" ", " "]) % for aligment
            else
                title([" ", " "]) % for aligment
            end
        end
        
        if verbose
            nofClasses = length(classNames);

            % Select the top nofClasses predictions
            [~,idx] = sort(score,'descend');
            idx = idx(nofClasses:-1:1);
            scoreTop = score(idx);
            classNamesTop = string(classNames(idx));
        
            % Plot the histogram
            barh(ax2,scoreTop)
            title(ax2, sprintf('Top %d predictions', nofClasses))
            xlabel(ax2, 'Probability')
            xlim(ax2,[0 1])
            yticklabels(ax2, classNamesTop)
            ax2.YAxisLocation = 'right';
        end
        drawnow
    end
    
    % Clear resources
    clear camera
    close all
end