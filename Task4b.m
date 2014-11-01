function [ most_similar_files ] = Task4b(  )

query_file_name = input('Enter the name of the query file::');
query_data = csvread(query_file_name,1,2);
k = input('Enter the value of k ::');

dimensions = csvread('C:\Users\TonyHunt\Documents\MATLAB\data\PA.csv');
data_directory = 'C:\Users\TonyHunt\Documents\MATLAB\SampleData_P2\Set_of_Simulation_Files\';
datafiles = dir(data_directory);

plotted_data = zeros(1,size(dimensions,2));
for i=1:size(dimensions,2)
%     dimensions(1,i+2)
%     datafiles(dimensions(1,i+2)).name
    first_dim = csvread(strcat(data_directory,datafiles(dimensions(1,i)+2).name),1,2);
%     dimensions(2,i+2)
%     datafiles(dimensions(1,i+2)).name
    second_dim = csvread(strcat(data_directory,datafiles(dimensions(2,i)+2).name),1,2);
    Ai = sim_EUC(first_dim,query_data);
    Bi = sim_EUC(second_dim,query_data);
    AB = sim_EUC(first_dim,second_dim);
    plotted_data(i) = projection(Ai,Bi,AB);
end

distances = Find_distances( plotted_data );

distances_dup = distances;
indices = zeros(1,20);
for j = 1:k
   [a,indices(j)] = min(distances_dup);
   distances_dup(indices(j)) = inf;
end
most_similar_files = datafiles(indices(1)+2).name;
for i=2:k
    most_similar_files = strcat(most_similar_files,', ', datafiles(indices(i)+2).name);
end

end

