function external_cell_width = measure_external_cell_width(seg_lumens, seg_nuclei)

    % if there are no nuclei:
    if ~isstruct(seg_nuclei)
        
        external_cell_width = NaN;
    
    % otherwise
    else

        % get the centroid of each nucleus:
        coords_nuclei_centroid = zeros(numel(seg_nuclei), 3);
        for i = 1:numel(seg_nuclei)
            coords_nuclei_centroid(i,:) = mean(seg_nuclei(i).boundary);
        end

        % if there are any lumens:
        if isstruct(seg_lumens)

            % get the boundary coordinates of ALL lumens:
            coords_lumens_all = [];
            for i = 1:numel(seg_lumens)
               coords_lumens_all = [coords_lumens_all; seg_lumens(i).boundary]; 
            end

            % if the lumens are coplanar:
            if numel(unique(coords_lumens_all(:,3))) == 1

                % get the external nuclei:
                coords_nuclei_centroid_external = coords_nuclei_centroid;

            % otherwise:
            else

                % determine which nuclear centroids are within the convex hull of
                % the lumens:
                inside = tsearchn(coords_lumens_all, delaunay(coords_lumens_all), coords_nuclei_centroid);

                % get the external nuclei:
                coords_nuclei_centroid_external = coords_nuclei_centroid(isnan(inside), :);

            end

        % otherwise:
        else

            % get the external nuclei:
            coords_nuclei_centroid_external = coords_nuclei_centroid;

        end

        % get the number of external nuclei:
        number_nuclei_external = size(coords_nuclei_centroid_external,1);

        % if there is only one external nucleus:
        if number_nuclei_external == 1

            external_cell_width = NaN;

        % otherwise:
        else

            % create an array to store distance between each external nucleus
            % and it's closest neighbor:
            external_cell_width = zeros(number_nuclei_external, 1);

            % for each external nucleus:
            for i = 1:number_nuclei_external

                % nucleus to use:
                coords_use = coords_nuclei_centroid_external(i,:);

                % all other nuclei:
                coords_other = coords_nuclei_centroid_external;
                coords_other(i,:) = [];

                % get the distance between the nucleus and all other nuclei:
                distances = pdist2(coords_use, coords_other);

                % get the distance to the closest neighbor:
                external_cell_width(i) = min(distances);

            end

        end
    
    end
end