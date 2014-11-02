%% (1.a) This function returns the euclidean similarity between two files.
function simlarity = sim_EUC(FileMatrix1,FileMatrix2)

simlarity=1/(1+mean(sqrt(sum((FileMatrix1-FileMatrix2).^2,1)),2));
