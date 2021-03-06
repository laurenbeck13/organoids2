function guess_2D_segmentations
    
    % make a list of segmentation methods
    list_segmentation_methods = {'using cellpose', 'using nucleaizer', 'using flood algorithm', 'using GUI to draw on max merge'};
    
    % ask user how they want to segment the data:
    [index, ~] = listdlg('ListString', list_segmentation_methods, 'SelectionMode', 'single', 'PromptString', 'What algorithm do you want to use?', 'ListSize', [400 300]);
    segmentation_method = list_segmentation_methods{index};
    
    % depending on the structure to segment:
    switch segmentation_method
        
        case 'using cellpose'
            
            organoids2.guess_2D_segmentations.using_cellpose;
        
        case 'using nucleaizer'
            
            organoids2.guess_2D_segmentations.using_nucleaizer;
            
        case 'using flood algorithm'
            
            organoids2.guess_2D_segmentations.using_flood_algorithm;
            
        case 'using GUI to draw on max merge'
            
            organoids2.guess_2D_segmentations.using_GUI_to_draw_on_max_merge;
            
    end
    
end