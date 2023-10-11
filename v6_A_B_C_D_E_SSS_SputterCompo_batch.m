clc; clear all;

comb_D_E     = nchoosek([{'Co'} {'V'} {'Mn'} {'Mo'} {'Cu'} {'Nb'} {'W'} {'Ti'} {'Al'} {'Si'},{'Ta'}],2);
current_path = pwd;
[parentDirectory, ~, ~] = fileparts(pwd);

for i = 1: length(comb_D_E)
    % i =1;
    comb_A_B_C_D_E_temp = ['Fe_Cr_Ni_',comb_D_E{i,1}, '_', comb_D_E{i,2}];
    
    %% new sub dir
    % specify directory name
    subdirName = ['v6_', comb_A_B_C_D_E_temp, '_Sputtering'];
    
     % Destination folder path
    destFolderPath = fullfile(parentDirectory, subdirName);
    
    % check if directory already exists
    if exist(destFolderPath, 'dir') == 7
        fprintf([subdirName, ' already exists.\n']);
    else
          
    % create new directory
        mkdir(destFolderPath);
        fprintf([subdirName, ' created.\n']);
    end
    
    %% copy the .m file
    % Source file path
    srcFilePath_1 = fullfile(current_path, 'v6_A_B_C_D_E_SSS_SputterCompo_master.m');
     
    % New file name
    newFileName_1  = ['v6_', comb_A_B_C_D_E_temp, '_SSS_SputterCompo.m'];
    destFilePath_1 = fullfile(destFolderPath, newFileName_1);
    
    % Copy file and change its name
    copyfile(srcFilePath_1, destFilePath_1);
    
    %% copy the .dat file
    % Source file path
    srcFilePath_2 = fullfile(current_path, 'SputteringCompoMapNormalised.dat');
     
    % New file name
    newFileName_2  = 'SputteringCompoMapNormalised.dat';
    destFilePath_2 = fullfile(destFolderPath, newFileName_2);
    
    % Copy file and change its name
    copyfile(srcFilePath_2, destFilePath_2);
    
    %% batch run
    cd(destFolderPath);
    job = batch(newFileName_1(1:end-2));
    fprintf([newFileName_1(1:end-2), ' job submitted.\n']);
    cd('..');
    
end












