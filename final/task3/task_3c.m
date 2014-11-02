% program to return top R semantics from sim-sim matrix
clearvars;
% Input - 1. Directory containing set of simulation files, 2. r
% Output - top r latent semantics
DIRECTORY_Sim   = uigetdir('','Select directory containing set of simulation files');
prompt = 'Enter the value of r: ';
r = input(prompt);
debug = 1;

% extract list of files present in dir
list_file       = dir(strcat(DIRECTORY_Sim,'\*.csv')); 
numOfFiles      = size(list_file,1);
SimSim          = zeros(numOfFiles,numOfFiles); % similarity similarity matrix

% prepare sim-sim matrix
sim_type = 1;
switch sim_type
    case 1
        for i = 1:numOfFiles
            for j = i:numOfFiles
                file1name = list_file(i).name;
                file2name = list_file(j).name;
                file1table = csvread(strcat(DIRECTORY_Sim,'\',file1name),1,2);
                file2table = csvread(strcat(DIRECTORY_Sim,'\',file2name),1,2);
                SimSim(i,j) = sim_EUC(file1table, file2table);
                SimSim(j,i) = SimSim(i,j);
            end
        end
    otherwise
        disp('Enexpected Value');
end

[U, S, V] = svd(SimSim);

semantic = cell(numOfFiles,2); 
for j = 1:numOfFiles;
    semantic{j,2} = list_file(j).name;
end

% writing return top R semantics to output file
outputFile = fopen('ToprSemanticSimSim.txt','W');
for i = 1:r
    for j = 1:numOfFiles;
        semantic{j,1} = U(j,i);
    end
    sortedSemantic = sortrows(semantic,-1);

    fprintf(outputFile,'%s\r\n',['Semantic ' int2str(i)]);
    for j = 1:numOfFiles
        fprintf(outputFile,'%s, %f\r\n',sortedSemantic{j,2},sortedSemantic{j,1});
    end
end
fclose(outputFile);
disp('Top r semantics successfully written in ToprSemanticSimSim.txt');
