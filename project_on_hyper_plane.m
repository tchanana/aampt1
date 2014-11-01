function [ dist_hyper_plane ] = project_on_hyper_plane(object_distances,X,col)

rows = size(object_distances,1);
cols = size(object_distances,1);
dist_hyper_plane = zeros(rows,cols);

for i=1:rows,
    for j=1:cols,
        if object_distances(i,j)^2 - (X(i,col)-X(j,col))^2 >= 0
            dist_hyper_plane(i,j) = sqrt(object_distances(i,j)^2 - (X(i,col)-X(j,col))^2);
%         dist_hyper_plane(i,j)
        else
            dist_hyper_plane(i,j) = sqrt(-(object_distances(i,j)^2 - (X(i,col)-X(j,col))^2));
        end
    end
end


end