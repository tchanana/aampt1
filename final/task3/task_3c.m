% program to return top R semantics from sim-sim matrix
clearvars;
% Input - 1. Directory containing set of simulation files, 2. r
% Output - top r latent semantics

sim_type = menu('Enter Similarity Measure ','1a: Euclidean','1b: DTW','1c: Word Similarity','1d: Word_Average Similarity','1e: Word_Difference Similarity','1f: A Matrix','1g: A Matrix Average','1h: A Matrix Difference');
prompt = 'Enter the value of r: ';
dlg_title = 'Input Parameter';
r = inputdlg(prompt,dlg_title);
r = str2num(r{1,1});
debug = 1;

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
                SimSim(i,j)       = sim_WAD(file1table, file2table);
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
                SimSim(i,j)       = sim_A_WAD(file1table, file2table,file_name);
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
                SimSim(i,j) = sim_A_WAD(file1table, file2table,file_name);
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
                SimSim(i,j) = sim_A_WAD(file1table, file2table,file_name);
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
msgbox('Top r semantics successfully written in ToprSemanticSimSim.txt');
