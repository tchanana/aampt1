% takes 2 vectors as input and return DTW distance
function sim = func_DTW(V1,V2)
    distance = zeros(numel(V1),numel(V2));
    % create a distance matrix for DTW
    for i = 1 : numel(V1)
        for j = 1 : numel(V2)
            distance(i,j) = power((V1(i) - V2(j)),2);
        end;
    end;
    % doubt : the DTW matrix is a 2D array for a set of state in F1 and F2. but
    % we need a value ? for each set of states
    % DTW matrix
    DTW = zeros(numel(V1),numel(V2));
    DTW(1,1) = 0;
    for i = 2 : numel(V1)
        for j = 2 : numel(V2)
        % distance(i,j) = power((V1(i) - V2(j)),2);
        min_arr = [DTW(i-1,j),DTW(i,j-1),DTW(i-1,j-1)];
        DTW(i,j) = distance(i,j) + min(min_arr);
        end;
    end;
sim = DTW(i,j);
end