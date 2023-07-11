clc; clear;

%% --- destination directory
source_subfolder = '/Users/ywu/InSync/2021_MPIE/2021-12_H Diffusion/Matlab Toolbox HEA/v5_FeCrNiMoTi_Sputtering_KW131_TWI';
source_file      = [source_subfolder '/', 'KW131_SSS_FCC_byCompo.xlsx'];
 
dst_subfolder = '/Users/ywu/InSync/2021_MPIE/2021-12_H Diffusion/Matlab Toolbox HEA/v6_A-B-C-D-E_Sputtering_ML_master/v6_A-B-C-D-E_Sputtering_ML_KW';
dst_file_at   = [dst_subfolder '/', 'v6_KW131_SSS_FCC_byCompo_at_pct.xlsx'];
dst_file_wt   = [dst_subfolder '/', 'v6_KW131_SSS_FCC_byCompo_wt_pct.xlsx'];

ele_A_comb_i = 'Ni';
ele_B_comb_i = 'Cr';
ele_C_comb_i = 'Mo';
ele_D_comb_i = 'Ti';
ele_E_comb_i = 'Fe';

%% --- save to at_pct and concatenate ele+composition into FORMULA

table_comb_i_at_pct = readtable(source_file,'VariableNamingRule','preserve');

% convert to at_percent and save to excel
table_comb_i_at_pct{:,2:6} = table_comb_i_at_pct{:,2:6} * 100;

table_comb_i_at_pct_col   = table_comb_i_at_pct.Properties.VariableNames(2:6); % column names
table_comb_i_at_pct_compo = table_comb_i_at_pct{:,2:6}; % elements

% empty string array for the formula column
table_comb_i_at_pct_FORMULA = strings([size(table_comb_i_at_pct,1),1]);

% Loop over each row of the table
for k = 1:size(table_comb_i_at_pct,1)

    table_comb_i_at_pct_compo_k = table_comb_i_at_pct_compo(k,:);

    % Loop over each element and its composition value in this row
    table_comb_i_at_pct_FORMULA_k = "";
    for q = 1:length(table_comb_i_at_pct_compo_k)
        table_comb_i_at_pct_FORMULA_k = table_comb_i_at_pct_FORMULA_k + table_comb_i_at_pct_col(q) + table_comb_i_at_pct_compo_k(q);
    end

    table_comb_i_at_pct_FORMULA(k) = table_comb_i_at_pct_FORMULA_k;
end

% Add the formula column to the table
table_comb_i_at_pct = addvars(table_comb_i_at_pct, table_comb_i_at_pct_FORMULA, 'NewVariableNames', 'FORMULA');


%% --- feature calcualtion

ele_all = {'Fe', 'Cr', 'Ni', 'Co', 'V', 'Mn', 'Mo', ...
    'Cu', 'Nb', 'W', 'Ti', 'Al', 'Si', 'Ta'};

atomic_number_all = [26, 24, 28, 27, 23, 25, 42, ...
    29, 41, 74, 22, 13, 14, 73];

ele_indices = [find(contains(ele_all, {ele_A_comb_i})), ...
    find(contains(ele_all, {ele_B_comb_i})), ...
    find(contains(ele_all, {ele_C_comb_i})), ...
    find(contains(ele_all, {ele_D_comb_i})), ...
    find(contains(ele_all, {ele_E_comb_i}))];

atomic_number_ABCDE = atomic_number_all(ele_indices)';

features  = zeros(size(table_comb_i_at_pct,1) ,13); % features matrix
alloy_num = size(features,1);

for features_i = 1: alloy_num
    at_pct_temp = table_comb_i_at_pct_compo(features_i,:)';
    features(features_i,:) = calculatefeatures(atomic_number_ABCDE, at_pct_temp);
end

T_features = array2table(features,...
    'VariableNames', {'a', 'delta_a', 'Tm', 'sigma_Tm', 'Hmix', ...
    'sigma_Hmix', 'ideal_S', 'elec_nega', ...
    'sigma_elec_nega', 'VEC', 'sigma_VEC', ...
    'bulk_modulus',	'sigma_bulk_modulus'});

% Add the selected feature columns to the table
features_sel =  {'delta_a', 'Hmix', 'VEC','sigma_bulk_modulus'};
T_features_sel = T_features(:, features_sel);

table_comb_i_at_pct = horzcat(table_comb_i_at_pct, T_features_sel);


%% Write the updated table_at_pct to the destination file
writetable(table_comb_i_at_pct, dst_file_at);


%% --- at% to wt%

% Define the atomic weights of all elements
atomic_wt_all = [55.847, 51.996, 58.70, 58.9332, 50.9415, 54.9380, 95.94, 63.546, 92.9064, 183.85, 47.90, 26.98154, 28.0855, 180.9479]; % Source: https://www.angelo.edu/faculty/kboudrea/periodic/structure_mass.htm

% Extract the atomic weights of the elements in A, B, C, D, and E
atomic_wt_ABCDE = atomic_wt_all(ele_indices);

% Calculate the total atomic weight of each composition
total_atomic_wt = sum(table_comb_i_at_pct{:, 2:6} .* atomic_wt_ABCDE, 2);

% Calculate the weight percentages of each element for each composition
data_comb_i_wt_pct_A = table_comb_i_at_pct{:, 2} * atomic_wt_ABCDE(1) ./ total_atomic_wt * 100;
data_comb_i_wt_pct_B = table_comb_i_at_pct{:, 3} * atomic_wt_ABCDE(2) ./ total_atomic_wt * 100;
data_comb_i_wt_pct_C = table_comb_i_at_pct{:, 4} * atomic_wt_ABCDE(3) ./ total_atomic_wt * 100;
data_comb_i_wt_pct_D = table_comb_i_at_pct{:, 5} * atomic_wt_ABCDE(4) ./ total_atomic_wt * 100;
data_comb_i_wt_pct_E = table_comb_i_at_pct{:, 6} * atomic_wt_ABCDE(5) ./ total_atomic_wt * 100;

% Create a copy of the original table
table_comb_i_wt_pct = table_comb_i_at_pct;

% Replace columns 2-6 with the weight percentages calculated above
table_comb_i_wt_pct{:,2:6} = [data_comb_i_wt_pct_A data_comb_i_wt_pct_B data_comb_i_wt_pct_C data_comb_i_wt_pct_D data_comb_i_wt_pct_E];

% Save the updated table to a file
% dst_file_wt  = [dst_subfolder '/', '','v6_', comb_A_B_C_D_E_temp, '_SSS_FCC_byCompo_wt_pct.xlsx'];
writetable(table_comb_i_wt_pct, dst_file_wt);

 
