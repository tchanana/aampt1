function [ Mapping_Error ] = Task4a(  )

global col;
global X;
global PA;
directory = input('Enter the directory having the simulation files ::');

file_list = dir(directory);

no_of_files = size(file_list,1)-2;

object_similarity = zeros(no_of_files);
size(directory)
size(file_list(3).name)
for i=1:no_of_files,
    
    for j=1:no_of_files,
        FileMatrix1=csvread(strcat(directory, (file_list(i+2).name)),1,2);
        FileMatrix2=csvread(strcat(directory, (file_list(j+2).name)),1,2);
        object_similarity(i,j) = sim_EUC(FileMatrix1,FileMatrix2);
    end
    i
end

object_distances
object_distances = distance(object_similarity);
% r = input('Enter r value::');
Mapping_Error = zeros(1,20);
for r=1:20
    
col=0;
X = zeros(no_of_files,r);
PA = zeros(2,r);
FastMap(r,object_distances);
final_distances = Eucl(X);

Mapping_Error(r) = sum(sum(object_distances)) - sum(sum(final_distances));

end

plot(1:20,Mapping_Error);

csvwrite('C:\Users\TonyHunt\Documents\MATLAB\data\X.csv',X);
csvwrite('C:\Users\TonyHunt\Documents\MATLAB\data\PA.csv',PA);
end

