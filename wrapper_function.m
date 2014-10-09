
function [  ] = wrapper_function()

    disp('***List of tasks***');
    disp('1.Task1');
    disp('2.Task2');
    disp('3.Task3');
    disp('4.Task4');
    task = input('Enter the number of the task to execute::');
    if(task == 1)
         disp('***List of subtasks***');
         disp('1.Task-1a');
         disp('2.Task-1b');
         disp('3.Task-1c');
         disp('4.Task-1d');
         disp('5.Task-1e');
         disp('6.Task-1f');
         disp('7.Task-1g');
         disp('8.Task-1h');
         subtask = input('Enter the number of the subtask to execute::');
         switch(subtask)
             case 1
             case 2
             case 3
             case 4
             case 5
             case 6
             case 7
             case 8
         end
                 
    elseif(task == 2)
    elseif(task == 3)
        disp('***List of subtasks***');
        disp('1.Task-3a');
        disp('2.Task-3b');
        disp('3.Task-3c');
        disp('4.Task-3d-f');
        subtask = input('Enter the number of the subtask to execute::');
         switch(subtask)
             case 1
             case 2
             case 3
             case 4
         end
    elseif(task == 4)
        disp('***List of subtasks***');
        disp('1.Task-4a');
        disp('2.Task-4b');
        subtask = input('Enter the number of the subtask to execute::');
         switch(subtask)
             case 1
             case 2
         end
    else
        disp('enter a valid Input');
    end

end

