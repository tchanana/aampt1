function [ dist ] = shortest_path_finder(location_matrix_path)

location_matrix = importfile(location_matrix_path,2,52);

size_of_shortest_path_matrix = size(location_matrix,1);

dist = int32(ones(size_of_shortest_path_matrix))*intmax;

for i=1:51
    dist(i,i) = 0;
end

for i=1:51
    for j=1:51
        if int32(location_matrix(i,j)) == 1
            
            dist(i,j) = int32(location_matrix(i,j));
        end
    end
end

for k = 1 : 51
    for i = 1 : 51
       for j = 1 : 51
        if dist(i,j) > dist(i,k) + dist(k,j) 
             dist(i,j) = dist(i,k) + dist(k,j);

        end
       end
    end
end

end
