function label_images(folder_name)
    % helper function to run image labeler for |folder_name|
    imageFolder = fullfile(pwd, folder_name);

    printf("Working on path: %s", imageFolder)
    
    % if in data store:
    % imds = imageDatastore(imageFolder);
    % imageLabeler(imds)
    
    imageLabeler(imageFolder)
end