%% Loading data

clear;
clc;

imds = imageDatastore('dataset/', "IncludeSubfolders", true, "LabelSource","foldernames", "FileExtensions",[".jpg",".png"]);

augmenter = imageDataAugmenter( ...
    'RandRotation',[0 360], ...
    'RandXReflection', true, ...
    'RandScale',[0.5 1]);

imageSize = [28 28 3];
auimds = augmentedImageDatastore(imageSize,imds);


labels_nums = 1:length(imds.Labels)
tbl = table(imds.Files, imds.Labels); 


A = intlut(Aorig, map)

%%

[train_set, test_set] = splitEachLabel(imds,0.7);

train_tbl = table(train_set.Files, train_set.Labels); 
% test_tbl = table(test_set.Files, test_set.Labels);

% 
% train_set = partitionByIndex(auimds,[1:floor(auimds.NumObservations*0.7)]);
% test_set = partitionByIndex(auimds,[floor(auimds.NumObservations*0.7):auimds.NumObservations]);

categoriesTrain = unique(imds.Labels);
numClasses = length(categoriesTrain);

net = resnet50;
inputSize = net.Layers(1).InputSize;

lgraph = layerGraph(net);
newLearnableLayer = fullyConnectedLayer(numClasses, ...
        Name="new_fc", ...
        WeightLearnRateFactor=10, ...
        BiasLearnRateFactor=10);
    
lgraph = replaceLayer(lgraph,"fc1000",newLearnableLayer);

newActivationLayer = sigmoidLayer(Name="sigmoid");
lgraph = replaceLayer(lgraph,"fc1000_softmax",newActivationLayer);

newOutputLayer = CustomBinaryCrossEntropyLossLayer("new_classoutput");
lgraph = replaceLayer(lgraph,"ClassificationLayer_fc1000",newOutputLayer);

options = trainingOptions("sgdm", ...
    InitialLearnRate=0.0005, ...
    MiniBatchSize=32, ...
    MaxEpochs=10, ...
    Verbose= false, ...
    ValidationData={test_set.Files, test_set.Labels}, ...
    ValidationFrequency=100, ...
    ValidationPatience=5, ...
    Plots="training-progress");

trainedNet = trainNetwork(train_tbl,lgraph,options);
