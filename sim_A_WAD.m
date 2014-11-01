%% (1.f 1.g 1.h) This function returns the similarity between two files in word directory.
function simlarity = sim_A_WAD(File1WordMatrix,File2WordMatrix,LocationMatrix)
% Task 1f%
% 3 input required - word/avg/diff file, simulation file name 1, simulation file
% name2
% return - simlarity

%%%%%% inputs required %%%%%%
%simulationDir='C:\MWD\project\dataset\'; % may be required later

% Variable intialization
simlarity = 0.00;

W1 = File1WordMatrix(:,4:end);
S1 = File1WordMatrix{:,2};
T1 = File1WordMatrix{:,3};

% extracting words, states and time for 2nd file from word file
W2 = File2WordMatrix(:,4:end);
S2 = File2WordMatrix{:,2};
T2 = File2WordMatrix{:,3};

maxTime = max(T1);
% preparing master list of words by taking union
masterWordTable=union(W1,W2,'rows');

%Calculating number of appearances of unique words in each file
for uniqueIndex = 1:height(masterWordTable)
    indexOfMasterWordinFile1 = ismember(W1,masterWordTable(uniqueIndex,:),'rows');
    indexOfMasterWordinFile2 = ismember(W2,masterWordTable(uniqueIndex,:),'rows');
    if(sum(indexOfMasterWordinFile1)*sum(indexOfMasterWordinFile2)>0)
       for i = 1:size(indexOfMasterWordinFile1,1)
           if(indexOfMasterWordinFile1(i) == 1)
               state1 = S1{i};
               for j = 1:size(indexOfMasterWordinFile2,1)
                    if(indexOfMasterWordinFile2(j) == 1)
                         state2 = S2{j};
                         stateSim = getStateSim(cell2mat(state1{1,1}),cell2mat(state2{1,1}),LocationMatrix);
                         if (abs(T2(j)-T1(i))==0)
                             timeSim=1;
                         else
                             timeSim=(maxTime-abs(T2(j)-T1(i)))/maxTime;
                         end
                         simlarity = simlarity+stateSim*timeSim;
                    end
               end
           end
       end
   end
end
