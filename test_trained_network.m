%% Classify New Image

% Load a new image to classify using the trained network.
I = imread("tire_test_img.jpg");

% Resize the test image to match the network input size.
I = imresize(I, [224 224]);

% Classify the test image using the trained network.
[YPred,probs] = classify(net, I);
imshow(I)
label = YPred;
title(string(label) + ", " + num2str(100*max(probs), 3) + "%");