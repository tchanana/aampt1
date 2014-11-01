%% (1.b) This function returns the euclidean similarity between two files.
function simlarity = sim_DTW(FileMatrix1,FileMatrix2)

sim = zeros(size(FileMatrix1,2),1);
for i= 1:size(FileMatrix1,2)
V1 = FileMatrix1(:,i);%extract columnwise data for file 1
V2 = FileMatrix2(:,i);%extract columnwise data for file 2
sim(i) = func_DTW(V1,V2); %call to dynamic function
end;

simlarity = 1/(1+mean(sim));
