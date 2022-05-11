addpath(genpath('lib')) % include interface class

% prepare input - we use laptop camera
camera = webcam;

% load pretrained net
data = load("pretrainedNet.mat");
net = data.net;

% define input size - images need to be resized
inputSize = net.Layers(1).InputSize(1:2);

% Properties
THRESHOLD = 0.7; % minimal score to send msg (and showe title)
DEBUG = false; % plot extra information about detected classes

% prepare controler with (for now) default values
ipAddress='127.0.0.1';
port=55001;
debugMode = true;
tc = TangibleController(debugMode, ipAddress, port);

% prepare display
h = figure;
if DEBUG
    h.Position(3) = 2*h.Position(3);
    ax1 = subplot(1,2,1);
    ax2 = subplot(1,2,2);
    ax2.PositionConstraint = 'innerposition';
end
while ishandle(h)
    % Display and classify the image
    img = snapshot(camera);

    if DEBUG
        image(ax1, img)
    else
        image(img)
    end
    
    img = imresize(img, inputSize);

    [label,score] = classify(net, img);

    maxScore = max(score);
    detectedClass = char(label);

    if maxScore > THRESHOLD
        if DEBUG
            title(ax1,{detectedClass, num2str(maxScore, "%.2f")});
        else
            title({detectedClass, num2str(maxScore, 2)});
        end
        
        % send message with detected class name
        tc.ObjectDetected(detectedClass);
    else
        if DEBUG
            title(ax1,[" ", " "]) % for aligment
        else
            title([" ", " "]) % for aligment
        end
    end
    
    if DEBUG
        % Select the top five predictions
        [~,idx] = sort(score,'descend');
        idx = idx(3:-1:1);
        scoreTop = score(idx);
        classNamesTop = string(classes(idx));
    
        % Plot the histogram
        barh(ax2,scoreTop)
        title(ax2,'Top 5')
        xlabel(ax2,'Probability')
        xlim(ax2,[0 1])
        yticklabels(ax2, classNamesTop)
        ax2.YAxisLocation = 'right';
    end

    drawnow
end

% turn off camera
clear camera