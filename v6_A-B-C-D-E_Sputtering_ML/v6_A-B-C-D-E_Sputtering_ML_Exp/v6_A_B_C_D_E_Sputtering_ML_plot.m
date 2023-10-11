clc; clearvars; close all;

% http://www.phy.ohio.edu/~hadizade/blog_files/PyColormap4Matlab.html
% # set the Python path
path_python = '/Users/ywu/opt/anaconda3/envs/tf-env/bin/python';
% # importing Greys colormap from Matplotlib
cl_RdYlBu_r = getPyPlot_cMap('RdYlBu_r', [], [], path_python);
cl_RdBu_r  = getPyPlot_cMap('RdBu_r', [], [], path_python);
cl_RdGy_r  = getPyPlot_cMap('RdGy_r', [], [], path_python);

cmap1 = linspecer;
cmap2 = cl_RdYlBu_r;
cmap3 = cl_RdBu_r;
cmap4 = cl_RdGy_r;



%% load data

T_KW99_sim  = readtable('v6_KW99_SSS_FCC_byCompo_at_pct_ML.xlsx',"VariableNamingRule","preserve");
T_KW131_sim = readtable('v6_KW131_SSS_FCC_byCompo_at_pct_ML.xlsx',"VariableNamingRule","preserve");
T_coord     = readtable('PVD_x_y.xlsx',"VariableNamingRule","preserve");

KW99_sim_FCC  = find(T_KW99_sim.Gmin_eq_FCC == 1);
KW99_sim_noFCC = find(T_KW99_sim.Gmin_eq_FCC == 0);
KW131_sim_FCC  = find(T_KW131_sim.Gmin_eq_FCC == 1);
KW131_sim_noFCC = find(T_KW131_sim.Gmin_eq_FCC == 0);
 
coord_x = T_coord.x;
coord_y = T_coord.y;

T_KW99_exp  = readtable('/Users/ywu/InSync/2021_MPIE/2021-12_H Diffusion/Matlab Toolbox HEA/v5_FeCrNiCoV_Sputtering_KW99_MPIE/Ecorr_Icorr_KW101_VHN_XRD_KW99_NiCrCoVFe.xlsx',"VariableNamingRule","preserve");
T_KW131_exp = readtable('/Users/ywu/InSync/2021_MPIE/2021-12_H Diffusion/Matlab Toolbox HEA/v5_FeCrNiMoTi_Sputtering_KW131_TWI/KW131-Ecorr_Icorr_KW131-VHN_KW131-Compo_KW130-XRD_NiCrMoTiFe.xlsx',"VariableNamingRule","preserve");

KW99_exp_FCC  = find(T_KW99_exp.FCC == 1);
KW99_exp_noFCC = find(T_KW99_exp.FCC == 0);
KW131_exp_FCC  = find(T_KW131_exp.FCC == 1);
KW131_exp_noFCC = find(T_KW131_exp.FCC == 0);

 


%% for plotting - KW99

figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x, coord_y, 300, T_KW99_sim.sigma_SSS,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap1)
c = colorbar;
% caxis([100 600]);
% title('SSS\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Solid solution strengthening (MPa)';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])

saveas(gcf, ['KW99_plot_SSS', '.png'],'png');


figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x, coord_y, 300, T_KW99_sim.H1_new_pred_KFold_mean,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap2)
c= colorbar; 
% caxis([50 300]);
% title('Hardness (ML)\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Hardness by ANN';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])
saveas(gcf, ['KW99_plot_Hardness', '.png'],'png');



figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x(KW99_exp_FCC), coord_y(KW99_exp_FCC), 300, T_KW99_sim.sigma_SSS(KW99_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap1)
c = colorbar;
% caxis([100 600]);
% title('SSS\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Solid solution strengthening (MPa)';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])

saveas(gcf, ['KW99_plot_SSS_FCC', '.png'],'png');


figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x(KW99_exp_FCC), coord_y(KW99_exp_FCC), 300, T_KW99_sim.H1_new_pred_KFold_mean(KW99_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap2)
c= colorbar; 
% caxis([50 300]);
% title('Hardness (ML)\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Hardness by ANN';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])
saveas(gcf, ['KW99_plot_Hardness_FCC', '.png'],'png');



figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x, coord_y, 300, T_KW99_sim.C2_new_pred_KFold_mean,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap3)
c = colorbar;
% caxis([100 600]);
% title('Pitting potential (ML)\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Pitting potential by ANN (mV vs SCE)';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])
saveas(gcf, ['KW99_plot_Corrosion', '.png'],'png');







%% for plotting - KW131

figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x, coord_y, 300, T_KW131_sim.sigma_SSS,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap1)
c = colorbar;
% caxis([100 600]);
% title('SSS\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Solid solution strengthening (MPa)';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])

saveas(gcf, ['KW131_plot_SSS', '.png'],'png');


figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x, coord_y, 300, T_KW131_sim.H1_new_pred_KFold_mean,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap2)
c= colorbar; 
% caxis([50 300]);
% title('Hardness (ML)\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Hardness by ANN';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])
saveas(gcf, ['KW131_plot_Hardness', '.png'],'png');



figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x(KW131_exp_FCC), coord_y(KW131_exp_FCC), 300, T_KW131_sim.sigma_SSS(KW131_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap1)
c = colorbar;
% caxis([100 600]);
% title('SSS\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Solid solution strengthening (MPa)';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])

saveas(gcf, ['KW131_plot_SSS_FCC', '.png'],'png');


figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x(KW131_exp_FCC), coord_y(KW131_exp_FCC), 300, T_KW131_sim.H1_new_pred_KFold_mean(KW131_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap2)
c= colorbar; 
% caxis([50 300]);
% title('Hardness (ML)\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Hardness by ANN';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])
saveas(gcf, ['KW131_plot_Hardness_FCC', '.png'],'png');



figure;
set(gcf,'units','points','position',[0,0,400,300]);
hold on
scatter(coord_x, coord_y, 300, T_KW131_sim.C2_new_pred_KFold_mean,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap3)
c = colorbar;
% caxis([100 600]);
% title('Pitting potential (ML)\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
c.Label.String = 'Pitting potential by ANN (mV vs SCE)';
c.Label.FontSize = 15;
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])
saveas(gcf, ['KW131_plot_Corrosion', '.png'],'png');







%% SSS (Curtin) - Simulation






figure(1);
set(gcf,'units','points','position',[0,0,1800,900]);


subplot(3, 4, 1)
hold on
scatter(coord_x, coord_y, 300, T_KW99_sim.sigma_SSS,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap1)
% caxis([100 600]);
colorbar;
title('SSS\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 2)
hold on
scatter(coord_x(KW99_exp_FCC), coord_y(KW99_exp_FCC), 300, T_KW99_sim.sigma_SSS(KW99_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap1)
% caxis([100 600]);
colorbar;
title('SSS\_NiCrCoVFe\_FCConly', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 3)
hold on
scatter(coord_x, coord_y, 300, T_KW131_sim.sigma_SSS,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap1)
% caxis([100 600]);
colorbar;
title('SSS\_NiCrMoTiFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 4)
hold on
scatter(coord_x(KW131_exp_FCC), coord_y(KW131_exp_FCC), 300, ...
    T_KW131_sim.sigma_SSS(KW131_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap1)
% caxis([100 600]);
colorbar;
title('SSS\_NiCrMoTiFe\_FCConly', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])

%% hardness (ML) - Simulation


subplot(3, 4, 5)
hold on
scatter(coord_x, coord_y, 300, T_KW99_sim.H1_new_pred_KFold_mean,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap2)
% caxis([100 600]);
colorbar;
% title('Hardness (ML)\_NiCrCoVFe', 'FontWeight','Normal');
title('NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 6)
hold on
scatter(coord_x(KW99_exp_FCC), coord_y(KW99_exp_FCC), 300, T_KW99_sim.H1_new_pred_KFold_mean(KW99_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap2)
% caxis([100 600]);
colorbar;
title('Hardness (ML)\_NiCrCoVFe\_FCConly', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 7)
hold on
scatter(coord_x, coord_y, 300, T_KW131_sim.H1_new_pred_KFold_mean,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap2)
% caxis([100 600]);
colorbar;
% title('Hardness (ML)\_NiCrMoTiFe', 'FontWeight','Normal');
title('NiCrMoTiFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 8)
hold on
scatter(coord_x(KW131_exp_FCC), coord_y(KW131_exp_FCC), 300, ...
    T_KW131_sim.H1_new_pred_KFold_mean(KW131_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap2)
% caxis([100 600]);
colorbar;
title('Hardness (ML)\_NiCrMoTiFe\_FCConly','FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 9)
hold on
scatter(coord_x, coord_y, 300, T_KW99_sim.H1_new_pred_KFold_std,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca, cmap4)
% caxis([100 600]);
colorbar;
% title('Hardness (ML)\_NiCrCoVFe\_err', 'FontWeight','Normal');
title('NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 11)
hold on
scatter(coord_x, coord_y, 300, T_KW131_sim.H1_new_pred_KFold_std,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca, cmap4)
% caxis([100 600]);
colorbar;
% title('Hardness (ML)\_NiCrMoTiFe\_err', 'FontWeight','Normal');
title('NiCrMoTiFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])

saveas(gcf, ['KW99_KW131_Strength', '.png'],'png');


%% Pitting potential (ML) - Simulation
figure(2);
set(gcf,'units','points','position',[0,0,1800,900]);


subplot(3, 4, 5)
hold on
scatter(coord_x, coord_y, 300, T_KW99_sim.C2_new_pred_KFold_mean,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap3)
% caxis([100 600]);
colorbar;
% title('Pitting potential (ML)\_NiCrCoVFe', 'FontWeight','Normal');
title('NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 6)
hold on
scatter(coord_x(KW99_exp_FCC), coord_y(KW99_exp_FCC), 300, T_KW99_sim.C2_new_pred_KFold_mean(KW99_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap3)
% caxis([100 600]);
colorbar;
% title('Pitting potential (ML)\_NiCrCoVFe\_FCConly', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 7)
hold on
scatter(coord_x, coord_y, 300, T_KW131_sim.C2_new_pred_KFold_mean,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap3)
% caxis([100 600]);
colorbar;
% title('Pitting potential (ML)\_NiCrMoTiFe', 'FontWeight','Normal');
title('NiCrMoTiFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 8)
hold on
scatter(coord_x(KW131_exp_FCC), coord_y(KW131_exp_FCC), 300, ...
    T_KW131_sim.C2_new_pred_KFold_mean(KW131_exp_FCC),"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap3)
% caxis([100 600]);
colorbar;
title('Pitting potential (ML)\_NiCrMoTiFe\_FCConly','FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 9)
hold on
scatter(coord_x, coord_y, 300, T_KW99_sim.C2_new_pred_KFold_std,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca, cmap4)
% caxis([100 600]);
colorbar;
% title('Pitting potential (ML)\_NiCrCoVFe\_err', 'FontWeight','Normal');
title('NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 11)
hold on
scatter(coord_x, coord_y, 300, T_KW131_sim.C2_new_pred_KFold_std,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca, cmap4)
% caxis([100 600]);
colorbar;
% title('Pitting potential (ML)\_NiCrMoTiFe\_err', 'FontWeight','Normal');
title('NiCrMoTiFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])

saveas(gcf, ['KW99_KW131_Corrosion', '.png'],'png');


%% Pitting potential (ML) - Exp ? only E_corr
figure(3);
set(gcf,'units','points','position',[0,0,1800,900]);

subplot(3, 4, 5)
hold on
scatter(coord_x, coord_y, 300, T_KW99_exp.ArcMelt_Homo_E_corr,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap3)
% caxis([100 600]);
colorbar;
title('Corrosion potential\_E_{corr} (Exp)\_NiCrCoVFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])


subplot(3, 4, 7)
hold on
scatter(coord_x, coord_y, 300, T_KW131_exp.ArcMelt_Homo_E_corr,"filled")
scatter(coord_x, coord_y, 300, [0.5 0.5 0.5],'LineWidth',1)
colormap(gca,cmap3)
% caxis([100 600]);
colorbar;
title('Corrosion potential\_E_{corr} (Exp)\_NiCrMoTiFe', 'FontWeight','Normal');
xlabel('position x');
ylabel('position y');
box on; axis square; xticks(0:10:100); yticks(0:10:100);
set(gca,'xscale','lin', 'FontSize',15); xtickangle(45);
set(gca,'yscale','lin', 'FontSize',15);
labels = num2str((1:size(T_coord,1))','%d');
text(coord_x, coord_y, labels, 'horizontal','center', 'vertical','middle', 'color', [0.5 0.5 0.5])




saveas(gcf, ['KW99_KW131_Corrosion_Ecorr', '.png'],'png');






%% 

cmap5 = linspecer(4);

figure(4);
hold on
scatter(T_KW99_sim.sigma_SSS(KW99_sim_FCC), ...
    T_KW99_sim.H1_new_pred_KFold_mean(KW99_sim_FCC), ...
    100, cmap5(1,:), "filled")
scatter(T_KW99_sim.sigma_SSS(KW99_sim_noFCC), ...
    T_KW99_sim.H1_new_pred_KFold_mean(KW99_sim_noFCC), ...
    100, cmap5(2,:), "filled")

scatter(T_KW131_sim.sigma_SSS(KW131_sim_FCC), ...
    T_KW131_sim.H1_new_pred_KFold_mean(KW131_sim_FCC), ...
    100, cmap5(3,:), "filled")
scatter(T_KW131_sim.sigma_SSS(KW131_sim_noFCC), ...
    T_KW131_sim.H1_new_pred_KFold_mean(KW131_sim_noFCC), ...
    100, cmap5(4,:), "filled")


%%

cmap5 = linspecer(2);

figure(5);
hold on
scatter(T_KW99_sim.sigma_SSS(KW99_exp_FCC), ...
    T_KW99_sim.H1_new_pred_KFold_mean(KW99_exp_FCC), ...
    100, cmap5(1,:), "filled")
scatter(T_KW99_sim.sigma_SSS(KW99_exp_noFCC), ...
    T_KW99_sim.H1_new_pred_KFold_mean(KW99_exp_noFCC), ...
    100, cmap5(1,:), 'LineWidth',2)
scatter(T_KW131_sim.sigma_SSS(KW131_exp_FCC), ...
    T_KW131_sim.H1_new_pred_KFold_mean(KW131_exp_FCC), ...
    100, cmap5(2,:), "filled")
scatter(T_KW131_sim.sigma_SSS(KW131_exp_noFCC), ...
    T_KW131_sim.H1_new_pred_KFold_mean(KW131_exp_noFCC), ...
    100, cmap5(2,:), 'LineWidth',2)
xlabel('Sigma SSS', 'FontSize', 16);
ylabel('H1 new pred KFold mean', 'FontSize', 16);
legend({'KW99 FCC', 'KW99 no FCC', 'KW131 FCC', 'KW131 no FCC'}, ...
    'Location', 'best', 'FontSize', 12);
set(gca, 'FontSize', 14);
box on; grid on; axis square;
xlim([0, max([T_KW99_sim.sigma_SSS; T_KW131_sim.sigma_SSS])]);
ylim([0, max([T_KW99_sim.H1_new_pred_KFold_mean; T_KW131_sim.H1_new_pred_KFold_mean])]);










