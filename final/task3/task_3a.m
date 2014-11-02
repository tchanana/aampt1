clearvars;
% Input - 1. Set of simulation files, 2. r
% Output - top r latent semantics
[FileName,PathName] = uigetfile('*.csv','Select word file for set of simulation files');
wordFile = strcat(PathName,FileName);
prompt = 'Enter the value of r: ';
r = input(prompt);
debug = 1;

wordTable=readtable(wordFile);
uniqueFiles = unique(wordTable.Filename); %extract names of epidemic simulation files
numOfObjects = size(uniqueFiles,1);
numOfFeatures = size(wordTable,1)/numOfObjects;

% Preparing Object-Feature matrix, taking as words as features
OF = zeros(numOfObjects,numOfFeatures);
for i = 1:numOfObjects
    fileWordsRows=strcmp(wordTable.Filename,uniqueFiles{i});
    words = table2array(wordTable(fileWordsRows,4:end));
    OF(i,:) = (mean(words,2))'; % taking mean of row (word)
end

[U, S, V] = svd(OF); % Applying SVD on Object-Feature matrix

if debug == 1 % Plotting error graph for analysis
    Sedit = S;
    for j = 1:5
        newOF = U*Sedit*V';
        error = abs(OF - newOF);
        errorPCT = error./OF*100;
        avgErrorPCT(j) = sum(sum(errorPCT))/size(error,1)/size(error,2);
        Sedit(6-j,6-j) = 0;
    end
    figure;plot(avgErrorPCT'); % draw error % while reducing r
end

% preparing semantic matrix by filling object names in 1st column
semantic = cell(numOfObjects,2); 
for j = 1:numOfObjects;
    semantic{j,2} = uniqueFiles{j};
end

% extracting and writing top r latent semantics to output file
outputFile = fopen('ToprSemanticSVD.txt','W');
for i = 1:r
    for j = 1:numOfObjects;
        semantic{j,1} = U(j,i);
    end
    sortedSemantic = sortrows(semantic,-1);

    fprintf(outputFile,'%s\r\n',['Semantic ' int2str(i)]);
    for j = 1:numOfObjects
        fprintf(outputFile,'%s, %f\r\n',sortedSemantic{j,2},sortedSemantic{j,1});
    end
end
fclose(outputFile);
disp('Top r semantics successfully written in ToprSemanticSVD.txt');
msgbox('Top r semantics successfully written in ToprSemanticSVD.txt');
