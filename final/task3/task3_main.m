% ask user if word dictionary needs to be created?
createWordDirectory=menu('Create word dictionary?','Yes','No');

% if yes the give the call to phase1-task1
switch createWordDirectory
    case 1
        DIRECTORY_Sim   = uigetdir('','Enter Directory for set of simulation files');
        wordFilePath=MWDPhase1_1(strcat(DIRECTORY_Sim,'\'));
        MWDPhase1_2(wordFilePath); 
end

% which task to be performed?
choice = menu('Enter the specific operation for task 3','3a Latent-semantics using SVD','3b-Latent-semantics using LDA','3c-Latent-semantics using Simulation-Simulation Matrix','3d-Top k simulations using SVD','3e-Top k simulations using LDA','3f-Top k simulations using Sim-Sim Matrix');

switch choice
    case 1
        task_3a();% call to svd
    case 2
        task_3b();% call to lda
    case 3
        task_3c();% call to sim-sim reduction
    case 4
        [simfile_name,simfile_path]=uigetfile('*.csv','Select the query file','C:\MWD\project');% browse to query file
        wordFilePath=MWDPhase1_1(strcat(simfile_path)); 
        MWDPhase1_2();
        task_3d();% query using svd
    case 5
        [simfile_name,simfile_path]=uigetfile('*.csv','Select the query file','C:\MWD\project');% browse to query file
        wordFilePath=MWDPhase1_1(strcat(simfile_path)); 
        MWDPhase1_2();
        task_3e();% query using lda
    case 6
        [simfile_name,simfile_path]=uigetfile('*.csv','Select the query file','C:\MWD\project');% browse to query file
        wordFilePath=MWDPhase1_1(strcat(simfile_path)); 
        MWDPhase1_2();
        task_3f();% query using sim-sim matrix
end

