% program to return top R semantics from sim-sim matrix
clearvars;
% Input - 1. Directory containing simulation files 2. Query simulation file
% Input - 3. type of similarity 4. r 5. k
% Output - top k objects


sim_type = menu('Enter Similarity Measure ','1a: Euclidean','1b: DTW','1c: Word Similarity','1d: Word_Average Similarity','1e: Word_Difference Similarity','1f: A Matrix','1g: A Matrix Average','1h: A Matrix Difference');
prompt = 'Enter the value of r: ';
dlg_title = 'Input Parameter';
r = inputdlg(prompt,dlg_title);
r = str2num(r{1,1});

prompt=('Enter the number of objects to return(k): ');
dlg_title = 'Input';
answer = inputdlg(prompt,dlg_title);
k = str2num(answer{1,1});

debug = 0;
DIRECTORY_Sim = 0;
if (sim_type == 1 || sim_type == 2)
    DIRECTORY_Sim   = uigetdir('','Select directory containing set of simulation files');
    % extract list of files present in dir
    list_file       = dir(strcat(DIRECTORY_Sim,'\*.csv'));
    numOfFiles      = size(list_file,1);
    elseif (sim_type == 3 || sim_type == 6)
        % Word Similarity File
        [wordfile1_path,path]   = uigetfile('*.*','Select Word File','C:\MWDB');
        wordfile1_path          = strcat(path,wordfile1_path);
        WordTable               = readtable(wordfile1_path);
        list_file               = cell2struct(unique(WordTable.(1)),{'name'},2);
        numOfFiles              = size(list_file,1);
    elseif (sim_type == 4 || sim_type == 7)
        % Average File
        [wordfile1_path,path]   = uigetfile('*.*','Select Word Average File','C:\MWDB');
        wordfile1_path          = strcat(path,wordfile1_path);
        WordTable               = readtable(wordfile1_path);
        list_file               = cell2struct(unique(WordTable.(1)),{'name'},2);
        numOfFiles              = size(list_file,1);
    elseif (sim_type == 5 || sim_type == 8)
        [wordfile1_path,path]   = uigetfile('*.*','Select Word Difference File','C:\MWDB');
        wordfile1_path          = strcat(path,wordfile1_path);
        WordTable              = readtable(wordfile1_path);
        list_file               = cell2struct(unique(WordTable.(1)),{'name'},2);
        numOfFiles              = size(list_file,1);
    else
        disp('Invalid Choice');
end
SimSim          = zeros(numOfFiles,numOfFiles); % similarity similarity matrix

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
    case 2
        for i = 1:numOfFiles
            for j = i:numOfFiles
                file1name = list_file(i).name;
                file2name = list_file(j).name;
                file1table = csvread(strcat(DIRECTORY_Sim,'\',file1name),1,2);
                file2table = csvread(strcat(DIRECTORY_Sim,'\',file2name),1,2);
                SimSim(i,j) = sim_DTW(file1table, file2table);
                SimSim(j,i) = SimSim(i,j);
            end
        end
    case 3
        
        for i = 1:numOfFiles
            for j = i:numOfFiles
                file1name   = list_file(i).name;
                file2name   = list_file(j).name;
                file1Idx    = strcmp(WordTable.Filename, file1name);
                file1table  = WordTable(file1Idx,:);
                file2Idx    = strcmp(WordTable.Filename, file2name);
                file2table  = WordTable(file2Idx,:);
                SimSim(i,j)       = sim_WAD(file1table, file2table);
                SimSim(j,i) = SimSim(i,j);
                
            end
        end
    case 4
        for i = 1:numOfFiles
            for j = i:numOfFiles
                file1name = list_file(i).name;
                file2name = list_file(j).name;
                file1Idx = strcmp(WordTable.Filename, file1name);
                file1table = WordTable(file1Idx,:);
                file2Idx = strcmp(WordTable.Filename, file2name);
                file2table = WordTable(file2Idx,:);
                SimSim(i,j)       = sim_WAD(file1table, file2table);
                SimSim(j,i) = SimSim(i,j);
            end
        end
    case 5
        for i = 1:numOfFiles
            for j = i:numOfFiles
                file1name = list_file(i).name;
                file2name = list_file(j).name;
                file1Idx = strcmp(WordTable.Filename, file1name);
                file1table = WordTable(file1Idx,:);
                file2Idx = strcmp(WordTable.Filename, file2name);
                file2table = WordTable(file2Idx,:);
                SimSim(i,j) = sim_WAD(file1table, file2table);
                SimSim(j,i) = SimSim(i,j);
            end
        end
        
    case 6
        [file_name,location_path] = uigetfile('*.*','Select Location Matrix','C:\MWDB');
        if file_name == 0
            error(0);
        end;
        file_name = strcat(location_path,file_name);
        
        for i = 1:numOfFiles
            for j = i:numOfFiles
                file1name = list_file(i).name;
                file2name = list_file(j).name;
                file1Idx = strcmp(WordTable.Filename, file1name);
                file1table = WordTable(file1Idx,:);
                file2Idx = strcmp(WordTable.Filename, file2name);
                file2table = WordTable(file2Idx,:);
                SimSim(i,j) = double(sim_A_WAD(file1table, file2table,file_name));
                SimSim(j,i) = SimSim(i,j);
            end
        end
    case 7
        [file_name,location_path] = uigetfile('*.*','Select Location Matrix','C:\MWDB');
        if file_name == 0
            error(0);
        end;
        file_name = strcat(location_path,file_name);
        for i = 1:numOfFiles
            for j = i:numOfFiles
                file1name = list_file(i).name;
                file2name = list_file(j).name;
                file1Idx = strcmp(WordTable.Filename, file1name);
                file1table = WordTable(file1Idx,:);
                file2Idx = strcmp(WordTable.Filename, file2name);
                file2table = WordTable(file2Idx,:);
                SimSim(i,j) = double(sim_A_WAD(file1table, file2table,file_name));
                SimSim(j,i) = SimSim(i,j);
            end
        end
    case 8
        [file_name,location_path] = uigetfile('*.*','Select Location Matrix','C:\MWDB');
        if file_name == 0
            error(0);
        end;
        file_name = strcat(location_path,file_name);
        for i = 1:numOfFiles
            for j = i:numOfFiles
                file1name = list_file(i).name;
                file2name = list_file(j).name;
                file1Idx = strcmp(WordTable.Filename, file1name);
                file1table = WordTable(file1Idx,:);
                file2Idx = strcmp(WordTable.Filename, file2name);
                file2table = WordTable(file2Idx,:);
                SimSim(i,j) = double(sim_A_WAD(file1table, file2table,file_name));
                SimSim(j,i) = SimSim(i,j);
            end
        end
        
        
    otherwise
        disp('Enexpected Value');
end

[U, S, V] = svd(SimSim);

% Dividing objects into clusters
cluster = zeros(r,numOfFiles+1); % first column of cluster constains number of objects in that cluster
for i = 1:numOfFiles
    [~,I] = max(U(i,1:r)); % cluster number of nth Object = index of maximum of row
    cluster(I,1) = cluster(I,1) + 1; % pick row ith upto r terms, find index j of max number
    cluster(I,cluster(I,1)+1) = i; % store i in the index j
end

[FileName,PathName] = uigetfile('*.csv','Select simulation file of query');
queryFile = strcat(PathName,FileName);

if (DIRECTORY_Sim == 0)
    DIRECTORY_Sim   = uigetdir('','Select directory containing set of simulation files');
    % extract list of files present in dir
    list_file       = dir(strcat(DIRECTORY_Sim,'\*.csv'));
    numOfFiles      = size(list_file,1);
end
% find similarity of query from each cluster
clusterSim = zeros(1,r);
queryTable = csvread(queryFile,1,2);

% find cluster similarity w.r.t query file using first object in cluster
clusterSim = zeros(r,2);
clusterSim(:,1) = 1:r;
for i = 1:r
    if cluster(i,1) == 0
        clusterSim(i,2) = 0;
    else
        fileIndex = cluster(i,2);
        fileName = list_file(fileIndex).name;
        filetable = csvread(strcat(DIRECTORY_Sim,'\',fileName),1,2);
        clusterSim(i,2) = sim_EUC(filetable,queryTable);
    end
end

% Sort the cluster similarity
[d1,d2] = sort(clusterSim(:,2),'descend');
orderedClusterSim = clusterSim(d2,:);

% prepare list of filtered elements from cluster
filteredObjects = cell(numOfFiles,2);
for i = 1:numOfFiles
    filteredObjects{i,1} = 0;
end
Idx = 1;
new_count = 0;
old_count = 0;
i = 1; % index to orderedClusterSim
while new_count<k
    clusterIdx = orderedClusterSim(i,1);
    new_count = old_count + cluster(clusterIdx,1);
    if cluster(clusterIdx,1) > 0
        l = 2;
        for j = old_count+1:new_count
            fileIndex = cluster(clusterIdx,l);
            fileName = list_file(fileIndex).name;
            filetable = csvread(strcat(DIRECTORY_Sim,'\',fileName),1,2);
            filteredObjects{j,2} = fileName;% save the name of the file
            filteredObjects{j,1} = sim_EUC(filetable,queryTable);% save the similarity w.r.t the file
            l = l + 1;
        end
        old_count = new_count;
    end
    i = i + 1;
end

% writing top k objects to output file
sortedSim = sortrows(filteredObjects,-1);
outputFile = fopen('TopkObjectsSimSim.txt','W');
for j = 1:k
    fprintf(outputFile,'%s, %e\r\n',sortedSim{j,2},sortedSim{j,1});
end
fclose(outputFile);
disp('Top k objects successfully written in TopkObjectsSimSim.txt');
msgbox('Top k objects successfully written in TopkObjectsSimSim.txt');
