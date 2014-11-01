prompt('Enter the simulation directory for task1 follows by \:');
sim_dir=input(prompt,'s');

prompt('Enter the word directory for task1 followed by \:');
word_dir=input(prompt,'s');

prompt('Enter the location matrix path for task1 :');
location_path=input(prompt,'s');

LocationMatrix=readtable(locationmatrixpath,'ReadRowNames',1);%initialize the location matrix in tabular form. ReadRowNames parameter will treat first column as rownames.

wordfile1_name='epidemic_word_file.csv';
wordfile2_name='epidemic_word_file_avg.csv';
wordfile3_name='epidemic_word_file_diff.csv';

prompt('Enter name of first file in directory for similarity(e.g 1.csv):');
file1_name=input(prompt,'s');

prompt('Enter name of second file in directory for similarity(e.g 1.csv):');
file2_name=input(prompt,'s');

simfile1_path=strcat(sim_dir,file1_name);
simfile2_path=strcat(sim_dir,file2_name);
wordfile1_path=strcat(word_dir,wordfile1_name);
wordfile2_path=strcat(word_dir,wordfile2_name);
wordfile3_path=strcat(word_dir,wordfile3_name);

FileMatrix1=csvread(simfile1_path,1,2);
FileMatrix2=csvread(simfile2_path,1,2);
WordTable=readtable(wordfile1_path);
WordTableAvg=readtable(wordfile2_path);
WordTableDiff=readtable(wordfile3_path);

msg=strcat('Similarity between two simulation files ',file1_name,' and ',file2_name);
disp(msg);

similarityMatrix=cell(8,2);

similarityMatrix(1,1)='1a-Smilarity using euclidean distance=';
similarityMatrix(1,2)=sim_EUC(FileMatrix1,FileMatrix2);

similarityMatrix(2,1)='1b-Smilarity using DTW function=';
similarityMatrix(2,2)=sim_DTW(FileMatrix1,FileMatrix2);


File1WordMatrixIdx=strcmp(WordTable.Filename,file1_name);
File2WordMatrixIdx=strcmp(WordTable.Filename,file2_name);
File1WordMatrix=WordTable(File1WordMatrixIdx,:);
File2WordMatrix=WordTable(File2WordMatrixIdx,:);

similarityMatrix(3,1)='1c-Smilarity using word dictionary=';
similarityMatrix(3,2)=sim_WAD(File1WordMatrix,File2WordMatrix);

similarityMatrix(6,1)='1f-Smilarity using word dictionary and A function=';
similarityMatrix(6,2)=sim_A_WAD(File1WordMatrix,File2WordMatrix,LocationMatrix);

File1WordMatrixIdx=strcmp(WordTableAvg.Filename,file1_name);
File2WordMatrixIdx=strcmp(WordTableAvg.Filename,file2_name);
File1WordMatrix=WordTableAvg(File1WordMatrixIdx,:);
File2WordMatrix=WordTableAvg(File2WordMatrixIdx,:);

similarityMatrix(4,1)='1d-Smilarity using word average dictionary=';
similarityMatrix(4,2)=sim_WAD(File1WordMatrix,File2WordMatrix);

similarityMatrix(7,1)='1g-Smilarity using word average dictionary and A function=';
similarityMatrix(7,2)=sim_A_WAD(File1WordMatrix,File2WordMatrix,LocationMatrix);


File1WordMatrixIdx=strcmp(WordTableDiff.Filename,file1_name);
File2WordMatrixIdx=strcmp(WordTableDiff.Filename,file2_name);
File1WordMatrix=WordTableDiff(File1WordMatrixIdx,:);
File2WordMatrix=WordTableDiff(File2WordMatrixIdx,:);

similarityMatrix(5,1)='1e-Smilarity using word difference dictionary=';
similarityMatrix(5,2)=sim_WAD(File1WordMatrix,File2WordMatrix);

similarityMatrix(8,1)='1h-Smilarity using word difference dictionary and A function=';
similarityMatrix(8,2)=sim_A_WAD(File1WordMatrix,File2WordMatrix,LocationMatrix);


