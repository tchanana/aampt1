%% (1.c 1.d 1.e) This function returns the similarity between two files in word directory.
function simlarity = sim_WAD(File1Matrix,File2Matrix)

W1=unique(File1Matrix(:,4:end),'rows');
W2=unique(File2Matrix(:,4:end),'rows');

simlarity=height(intersect(W1,W2,'rows'));
