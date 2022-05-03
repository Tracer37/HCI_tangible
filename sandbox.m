detector = yolov4ObjectDetector("tiny-yolov4-coco");
disp(detector)
analyzeNetwork(detector.Network)
img = imread("highway.png");
[bboxes,scores,labels] = detect(detector,img);
detectedImg = insertObjectAnnotation(img,"Rectangle",bboxes,labels);
imshow(img)
figure
imshow(detectedImg)