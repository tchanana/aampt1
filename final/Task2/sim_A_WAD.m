%% (1.f 1.g 1.h) This function returns the similarity between two files in word directory.
function simlarity = sim_A_WAD(File1WordMatrix,File2WordMatrix,locationMatrixPath)
% Task 1f%
% 3 input required - word/avg/diff file, simulation file name 1, simulation file
% name2
% return - simlarity
%locationMatrixPath='C:\MWD\project\graphs\LocationMatrix.csv';
%%%%%% inputs required %%%%%%
%simulationDir='C:\MWD\project\dataset\'; % may be required later

% Variable intialization
simlarity = 0.00;

W1 = File1WordMatrix(:,4:end);
S1 = File1WordMatrix{:,2};
S1=cellfun(@(x) x(4:end),S1,'UniformOutput',false);
T1 = File1WordMatrix{:,3};

% extracting words, states and time for 2nd file from word file
W2 = File2WordMatrix(:,4:end);
S2 = File2WordMatrix{:,2};
S2=cellfun(@(x) x(4:end),S2,'UniformOutput',false);
T2 = File2WordMatrix{:,3};

maxTime = max(T1);
% preparing master list of words by taking union
masterWordTable=union(W1,W2,'rows');

distanceMatrix=shortest_path_finder(locationMatrixPath);

LocationMatrix=readtable(locationMatrixPath,'ReadRowNames',1);

steateHeader=LocationMatrix.Properties.VariableNames;

stateIndexFile1=zeros(size(S1,1),1);
stateIndexFile2=zeros(size(S2,1),1);

for stateIndex=1:size(steateHeader,2)
      stateIndexFile1(strcmp(S1,steateHeader(stateIndex)),1)=stateIndex;    
      stateIndexFile2(strcmp(S2,steateHeader(stateIndex)),1)=stateIndex;   
end


%Calculating number of appearances of unique words in each file
for uniqueIndex = 1:height(masterWordTable)
    indexOfMasterWordinFile1(:,uniqueIndex) = ismember(W1,masterWordTable(uniqueIndex,:),'rows');
    indexOfMasterWordinFile2(:,uniqueIndex) = ismember(W2,masterWordTable(uniqueIndex,:),'rows');
end
    
for uniqueIndex = 1:height(masterWordTable)
    
    uniqueWordCountFile1=sum(indexOfMasterWordinFile1(:,uniqueIndex));
    uniqueWordCountFile2=sum(indexOfMasterWordinFile2(:,uniqueIndex));
    
    if((uniqueWordCountFile1*uniqueWordCountFile2)>0)
        stateIndex1=stateIndexFile1(indexOfMasterWordinFile1(:,uniqueIndex));
        stateIndex2=stateIndexFile2(indexOfMasterWordinFile2(:,uniqueIndex));
        time1=T1(indexOfMasterWordinFile1(:,uniqueIndex));
        time2=T2(indexOfMasterWordinFile2(:,uniqueIndex));
        for i = 1:uniqueWordCountFile1
                state1 = stateIndex1(i);
                for j = 1:uniqueWordCountFile2
                        state2 = stateIndex2(j);
                        stateSim = 1/(1+distanceMatrix(state1,state2));
                        timeSim=(maxTime-abs(time2(j)-time1(i)))/maxTime;
                        simlarity = simlarity+stateSim+timeSim;
                end
         end
        
    end
end


