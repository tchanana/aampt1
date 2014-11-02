% Query using top r semantics from SVD
clearvars;
% Input - 1. Word file of simulation files 2. Query word file 3. r 4. k
% Output - top 
[FileName,PathName] = uigetfile('*.csv','Select word file for set of simulation files');
wordFile = strcat(PathName,FileName);

[FileName,PathName] = uigetfile('*.csv','Select word file of query');
wordQuery = strcat(PathName,FileName);

prompt=('Enter the number of top semantics(r): ');
dlg_title = 'Input';
answer = inputdlg(prompt,dlg_title);
r = str2num(answer{1,1});

prompt=('Enter the number of objects to return(k): ');
dlg_title = 'Input';
answer = inputdlg(prompt,dlg_title);
k = str2num(answer{1,1});

wordTable = readtable(wordFile);
queryTable = readtable(wordQuery);

%extract name of epidemic simulation files
uniqueFiles = unique(wordTable.Filename);

numOfObjects = size(uniqueFiles,1);
numOfFeatures = size(wordTable,1)/numOfObjects;

OF = zeros(numOfObjects,numOfFeatures);
% Filling values in Object-Feature matrix as words
for i = 1:numOfObjects
    fileWordsRows=strcmp(wordTable.Filename,uniqueFiles{i});
    words = table2array(wordTable(fileWordsRows,4:end));
    OF(i,:) = (mean(words,2))'; % taking mean of row (word)
end

[U, S, V] = svd(OF);

for i = r+1:min(size(S))
    S(i,i) = 0; %setting semantics other than r to zero
end

queryFileName = unique(queryTable.Filename);
if size(queryFileName,1) > 1
    error('Word File of query contains multiple file name')
end
queryWords = table2array(queryTable(:,4:end));
Q = mean(queryWords,2)';

newOF = U*S*V';
% Norm of each object in reduced space
norm = (sqrt(sum((newOF').^2)))';
% need to divide by norm
%result = (U*S*(V'*Q'))./norm;

result(:,1) = 1:1:numOfObjects;
result(:,2) = (U*S*(V'*Q'))./norm;
[d1,d2] = sort(result(:,2),'descend');
result = result(d2,:);

% writing return top k objects to output file
outputFile = fopen('TopkObjectsSVD.txt','W');
for i = 1:k
    fileIndex = result(i,1);
    fprintf(outputFile,'%s, %f\r\n',uniqueFiles{fileIndex},result(i,2));
end
fclose(outputFile);
disp('Top k objects successfully written in TopkObjectsSVD.txt');
